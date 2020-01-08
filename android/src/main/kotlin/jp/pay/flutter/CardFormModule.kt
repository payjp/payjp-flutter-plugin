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

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import jp.pay.android.Payjp
import jp.pay.android.PayjpTokenBackgroundHandler
import jp.pay.android.PayjpTokenBackgroundHandler.CardFormStatus
import jp.pay.android.model.TenantId
import jp.pay.android.model.Token
import jp.pay.android.ui.PayjpCardFormResultCallback
import java.lang.RuntimeException
import java.util.concurrent.CountDownLatch
import java.util.concurrent.atomic.AtomicReference

internal class CardFormModule(
    registrar: PluginRegistry.Registrar,
    private val channel: MethodChannel
) : PayjpTokenBackgroundHandler {

    private val currentActivity = registrar.activity()
    private val reference: AtomicReference<CardFormStatus> = AtomicReference()
    @Volatile
    private var countDownLatch: CountDownLatch? = null

    init {
        registrar.addActivityResultListener { _, _, data ->
            Payjp.cardForm().handleResult(data, PayjpCardFormResultCallback { result ->
                if (result.isSuccess()) {
                    channel.invokeMethod(ChannelContracts.ON_CARD_FORM_COMPLETED, null)
                } else if (result.isCanceled()) {
                    channel.invokeMethod(ChannelContracts.ON_CARD_FORM_CANCELED, null)
                }
            })
            false
        }
    }

    // handle MethodCall

    fun startCardForm(result: MethodChannel.Result, tenantId: TenantId?) {
        Payjp.cardForm().start(currentActivity, tenant = tenantId)
        result.success(null)
    }

    fun showTokenProcessingError(result: MethodChannel.Result, message: String) {
        reference.set(CardFormStatus.Error(message = message))
        countDownLatch?.countDown()
        result.success(null)
    }
    
    fun completeCardForm(result: MethodChannel.Result) {
        reference.set(CardFormStatus.Complete())
        countDownLatch?.countDown()
        result.success(null)
    }

    // PayjpTokenBackgroundHandler

    override fun handleTokenInBackground(token: Token): CardFormStatus {
        countDownLatch = CountDownLatch(1)
        // `handleTokenInBackground` runs on worker thread.
        val tokenMap = token.toMap()
        currentActivity.runOnUiThread {
            channel.invokeMethod(ChannelContracts.ON_CARD_FORM_PRODUCED_TOKEN, tokenMap)
        }
        try {
            countDownLatch?.await()
        } catch (e: InterruptedException) {
            throw RuntimeException(e)
        }
        return reference.get()
    }
}