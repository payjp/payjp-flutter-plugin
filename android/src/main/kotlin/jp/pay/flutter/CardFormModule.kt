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