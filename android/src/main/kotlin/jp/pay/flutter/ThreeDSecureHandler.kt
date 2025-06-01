package jp.pay.flutter

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import jp.pay.android.Payjp
import jp.pay.android.verifier.PayjpVerifier

internal class ThreeDSecureHandler(
    private val channel: MethodChannel
) {

    companion object {
        // REQUEST_CODE_VERIFY_LAUNCHER defined in PAY.JP Android SDK
        private const val PAYJP_REQUEST_CODE_THREE_D_SECURE = 10
    }

    var binding: ActivityPluginBinding? = null
        set(value) {
            field = value
            value?.addActivityResultListener { requestCode, resultCode, data ->
                onActivityResult(requestCode, resultCode, data)
            }
        }

    private fun currentActivity(): Activity? = binding?.activity

    private fun notifyCompletion(status: String) {
        channel.invokeMethod(ChannelContracts.ON_THREE_D_SECURE_PROCESS_FINISHED, status)
    }

    fun startThreeDSecure(result: MethodChannel.Result, resourceId: String) {
        currentActivity()?.let { activity ->
            PayjpVerifier.startThreeDSecureFlow(resourceId, activity)
            result.success(null)
        } ?: result.error("VIEW_CONTROLLER_NOT_FOUND", "Activity not found", null)
    }

    private fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != PAYJP_REQUEST_CODE_THREE_D_SECURE) {
            return false
        }
        
        Payjp.verifier().handleThreeDSecureResult(requestCode) { result ->
            when {
                result.isSuccess() -> {
                    notifyCompletion("completed")
                }
                result.isCanceled() -> {
                    notifyCompletion("canceled")
                }
                else -> {
                    notifyCompletion("failed")  
                }
            }
        }
        return true
    }
} 