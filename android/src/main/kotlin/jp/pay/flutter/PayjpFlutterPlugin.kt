/*
 *
 * Copyright (c) 2020 PAY, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package jp.pay.flutter

import android.content.Context
import android.os.Build
import android.util.Log
import androidx.core.os.LocaleListCompat
import com.google.android.gms.common.GooglePlayServicesNotAvailableException
import com.google.android.gms.common.GooglePlayServicesRepairableException
import com.google.android.gms.security.ProviderInstaller
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import jp.pay.android.Payjp
import jp.pay.android.PayjpCardForm
import jp.pay.android.PayjpConfiguration
import jp.pay.android.cardio.PayjpCardScannerPlugin
import jp.pay.android.model.ClientInfo
import jp.pay.android.model.TenantId
import java.util.Locale

class PayjpFlutterPlugin: MethodCallHandler, FlutterPlugin, ActivityAware {
  companion object {
    private const val CHANNEL_NAME = "payjp"
    @Suppress("unused")
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      PayjpFlutterPlugin().setUpChannel(registrar.context(), registrar.messenger(), registrar)
    }
  }

  private var channel: MethodChannel? = null
  private var applicationContext: Context? = null
  private var cardFormModule: CardFormModule? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    setUpChannel(binding.applicationContext, binding.binaryMessenger, null)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = null
    channel?.setMethodCallHandler(null)
    channel = null
    cardFormModule = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    cardFormModule?.binding = binding
  }

  override fun onDetachedFromActivity() {
    cardFormModule?.binding = null
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  /**
   * compatible embedding before Flutter v1.12
   *
   */
  private fun setUpChannel(
    applicationContext: Context,
    messenger: BinaryMessenger,
    register: Registrar?
  ) {
    this.applicationContext = applicationContext
    channel = MethodChannel(messenger, CHANNEL_NAME).also {
      it.setMethodCallHandler(this)
      cardFormModule = CardFormModule(it, register)
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) = when (call.method) {
    ChannelContracts.INITIALIZE -> {
      val publicKey = checkNotNull(call.argument<String>("publicKey"))
      val debugEnabled = checkNotNull(call.argument<Boolean>("debugEnabled"))
      val locale = call.argument<String>("locale")?.let { tag ->
        LocaleListCompat.forLanguageTags(tag).takeIf { it.size() > 0 }?.get(0)
      } ?: Locale.getDefault()
      val clientInfo = ClientInfo.Builder()
        .setPlugin("jp.pay.flutter/${BuildConfig.LIBRARY_VERSION_NAME}")
        .setPublisher("payjp")
        .build()
      val tdsRedirectKey = call.argument<String>("threeDSecureRedirectKey")
      activateModernTls(debugEnabled)
      Payjp.init(PayjpConfiguration.Builder(publicKey = publicKey)
        .setDebugEnabled(debugEnabled)
        .setTokenBackgroundHandler(cardFormModule)
        .setLocale(locale)
        .setCardScannerPlugin(PayjpCardScannerPlugin)
        .setClientInfo(clientInfo)
        .setThreeDSecureRedirectName(tdsRedirectKey)
        .build())
      result.success(null)
    }
    ChannelContracts.START_CARD_FORM -> {
      val tenantId = call.argument<String>("tenantId")?.let { TenantId(it) }
      var face = PayjpCardForm.FACE_MULTI_LINE
      call.argument<String>("cardFormType")?.let {
        if (it == "cardDisplay") {
          face = PayjpCardForm.FACE_CARD_DISPLAY
        }
      }
      cardFormModule?.startCardForm(result, tenantId, face) ?: result.pluginError("plugin not attached.")
    }
    ChannelContracts.SHOW_TOKEN_PROCESSING_ERROR -> {
      val message = checkNotNull(call.argument<String>("message"))
      cardFormModule?.showTokenProcessingError(result, message) ?: result.pluginError("plugin not attached.")
    }
    ChannelContracts.COMPLETE_CARD_FORM -> {
      cardFormModule?.completeCardForm(result) ?: result.pluginError("plugin not attached.")
    }
    else -> result.notImplemented()
  }

  private fun activateModernTls(debugEnabled: Boolean) {
    if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.KITKAT) {
      try {
        applicationContext?.let {
          ProviderInstaller.installIfNeeded(it)
        }
      } catch (e: GooglePlayServicesRepairableException) {
        if (debugEnabled) Log.e("payjp-android", "error ssl setup", e)
      } catch (e: GooglePlayServicesNotAvailableException) {
        if (debugEnabled) Log.e("payjp-android", "error ssl setup", e)
      }
    }
  }
}
