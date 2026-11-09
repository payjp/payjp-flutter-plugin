import UIKit
import PAYJP
#if canImport(GoogleUtilities_AppDelegateSwizzler)
import GoogleUtilities_AppDelegateSwizzler
#else
import GoogleUtilities
#endif

final class PayjpAppDelegateInterceptor: NSObject, UIApplicationDelegate {
    static let sharedInstance: PayjpAppDelegateInterceptor = {
        let instance = PayjpAppDelegateInterceptor()
        GULAppDelegateSwizzler.proxyOriginalDelegate()
        GULAppDelegateSwizzler.registerAppDelegateInterceptor(instance)
        return instance
    }()

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return ThreeDSecureProcessHandler.shared.completeThreeDSecureProcess(url: url)
    }

    // AppDelegate が application(_:open:options:) を実装していない場合、GULAppDelegateSwizzler は
    // こちらのみを転送するため、旧 API も受ける
    func application(
        _ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any
    ) -> Bool {
        return ThreeDSecureProcessHandler.shared.completeThreeDSecureProcess(url: url)
    }
}
