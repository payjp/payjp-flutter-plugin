import Flutter
import UIKit
import PAYJP

public class SwiftPayjpFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "payjp", binaryMessenger: registrar.messenger())
        let instance = SwiftPayjpFlutterPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    private let channel: FlutterMethodChannel
    private let cardFormModule: CardFormModuleType
    private let applePayModule: ApplePayModule

    init(channel: FlutterMethodChannel) {
        self.channel = channel
        self.cardFormModule = CardFormModule(channel: channel)
        self.applePayModule = ApplePayModule(channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = ChannelMethodToNative(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        let argsDictionary = call.arguments as? Dictionary<String, Any>
        switch method {
        case .configure:
            if let publicKey = argsDictionary?["publicKey"] as? String {
                PAYJPSDK.publicKey = publicKey
                if let localeString = argsDictionary?["locale"] as? String {
                    PAYJPSDK.locale = Locale.init(identifier: localeString)
                } else {
                    PAYJPSDK.locale = Locale.current
                }
            }
            result(nil)
            break
        case .startCardForm:
            let tenantId = argsDictionary?["tenantId"] as? String
            self.cardFormModule.startCardForm(result, with: tenantId)
            break
        case .showTokenProcessingError:
            if let message = argsDictionary?["message"] as? String {
                self.cardFormModule.showTokenProcessingError(result, with: message)
            }
            break
        case .completeCardForm:
            self.cardFormModule.completeCardForm(result)
            break
        case .isSupportedApplePay:
            self.applePayModule.isSupportedApplePay(result)
            break
        case .makeApplePayToken:
            if let appleMerchantId = argsDictionary?["appleMerchantId"] as? String,
                let currencyCode = argsDictionary?["currencyCode"] as? String,
                let countryCode = argsDictionary?["countryCode"] as? String,
                let summaryItemLabel = argsDictionary?["summaryItemLabel"] as? String,
                let summaryItemAmount = argsDictionary?["summaryItemAmount"] as? String,
                let requiredBillingAddress = argsDictionary?["requiredBillingAddress"] as? Bool {
                self.applePayModule.makeApplePayToken(
                    result,
                    appleMerchantId: appleMerchantId,
                    currencyCode: currencyCode,
                    countryCode: countryCode,
                    summaryItemLabel: summaryItemLabel,
                    summaryItemAmount: summaryItemAmount,
                    requiredBillingAddress: requiredBillingAddress
                )
            }
            break
        case .completeApplePay:
            if let isSuccess = argsDictionary?["isSuccess"] as? Bool {
                let errorMessage = argsDictionary?["errorMessage"] as? String
                self.applePayModule.completeApplePay(result,
                                                     isSuccess: isSuccess,
                                                     errorMessage: errorMessage)
            }
            break
        }
    }
}
