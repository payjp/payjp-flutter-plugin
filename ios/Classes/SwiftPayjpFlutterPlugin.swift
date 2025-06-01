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
    private let threeDSecureHandler: ThreeDSecureHandler

    init(channel: FlutterMethodChannel) {
        self.channel = channel
        self.cardFormModule = CardFormModule(channel: channel)
        self.applePayModule = ApplePayModule(channel: channel)
        self.threeDSecureHandler = ThreeDSecureHandler(channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = ChannelMethodToNative(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        let argsDictionary = call.arguments as? Dictionary<String, Any>
        switch method {
        case .initialize:
            if let publicKey = argsDictionary?["publicKey"] as? String {
                PAYJPSDK.publicKey = publicKey
                if let localeString = argsDictionary?["locale"] as? String {
                    PAYJPSDK.locale = Locale.init(identifier: localeString)
                } else {
                    PAYJPSDK.locale = Locale.current
                }
                PAYJPSDK.clientInfo = ClientInfo.makeInfo(plugin: "jp.pay.flutter/\(PayjpPluginConstant.PluginVersion)", publisher: "payjp")
                if let tdsRedirectURL = argsDictionary?["threeDSecureRedirectUrl"] as? String,
                    let tdsRedirectKey = argsDictionary?["threeDSecureRedirectKey"] as? String {
                    PAYJPSDK.threeDSecureURLConfiguration =
                        ThreeDSecureURLConfiguration(redirectURL: URL(string: tdsRedirectURL)!,
                                                     redirectURLKey: tdsRedirectKey)
                }
            }
            PayjpAppDelegateInterceptor.sharedInstance()
            result(nil)
            break
        case .startCardForm:
            let tenantId = argsDictionary?["tenantId"] as? String
            var viewType: CardFormViewType = .labelStyled
            if let formType = argsDictionary?["cardFormType"] as? String {
                switch formType {
                case "cardDisplay":
                    viewType = .displayStyled
                default:
                    break
                }
            }
            var extraAttributes: [ExtraAttribute] = []
            if argsDictionary?["extraAttributesEmailEnabled"] as? Bool ?? false {
                extraAttributes.append(
                    ExtraAttributeEmail(preset: argsDictionary?["extraAttributesEmailPreset"] as? String)
                )
            }
            if argsDictionary?["extraAttributesPhoneEnabled"] as? Bool ?? false {
                extraAttributes.append(
                    ExtraAttributePhone(
                        presetNumber: argsDictionary?["extraAttributesPhonePresetNumber"] as? String,
                        presetRegion: argsDictionary?["extraAttributesPhonePresetRegion"] as? String
                    )
                )
            }
            let useThreeDSecure = argsDictionary?["useThreeDSecure"] as? Bool ?? false
            self.cardFormModule.startCardForm(result, with: tenantId, viewType: viewType, extraAttributes: extraAttributes, useThreeDSecure: useThreeDSecure)
            break
        case .showTokenProcessingError:
            if let message = argsDictionary?["message"] as? String {
                self.cardFormModule.showTokenProcessingError(result, with: message)
            }
            break
        case .completeCardForm:
            self.cardFormModule.completeCardForm(result)
            break
        case .setFormStyle:
            var labelTextColor: UIColor?
            var inputTextColor: UIColor?
            var errorTextColor: UIColor?
            var tintColor: UIColor?
            var inputFieldBackgroundColor: UIColor?
            var submitButtonColor: UIColor?
            var highlightColor: UIColor?

            if let labelText = argsDictionary?["labelTextColor"] as? NSNumber {
                labelTextColor = self.color(with: labelText.uintValue)
            }
            if let inputText = argsDictionary?["inputTextColor"] as? NSNumber {
                inputTextColor = self.color(with: inputText.uintValue)
            }
            if let errorText = argsDictionary?["errorTextColor"] as? NSNumber {
                errorTextColor = self.color(with: errorText.uintValue)
            }
            if let tint = argsDictionary?["tintColor"] as? NSNumber {
                tintColor = self.color(with: tint.uintValue)
            }
            if let inputFieldBackground = argsDictionary?["inputFieldBackgroundColor"] as? NSNumber {
                inputFieldBackgroundColor = self.color(with: inputFieldBackground.uintValue)
            }
            if let submitButton = argsDictionary?["submitButtonColor"] as? NSNumber {
                submitButtonColor = self.color(with: submitButton.uintValue)
            }
            if let highlight = argsDictionary?["highlightColor"] as? NSNumber {
                highlightColor = self.color(with: highlight.uintValue)
            }
            let style = FormStyle(labelTextColor: labelTextColor,
                                  inputTextColor: inputTextColor,
                                  errorTextColor: errorTextColor,
                                  tintColor: tintColor,
                                  inputFieldBackgroundColor: inputFieldBackgroundColor,
                                  submitButtonColor: submitButtonColor,
                                  highlightColor: highlightColor)
            self.cardFormModule.setFormStyle(result, with: style)
            break
        case .isApplePayAvailable:
            self.applePayModule.isApplePayAvailable(result)
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
        case .startThreeDSecureProcess:
            guard let resourceId = argsDictionary?["resourceId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", 
                                   message: "resourceId is required", 
                                   details: nil))
                return
            }
            
            let viewController: UIViewController?
            
            if #available(iOS 13.0, *) {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                    result(FlutterError(code: "VIEW_CONTROLLER_NOT_FOUND", 
                                       message: "Could not find root view controller", 
                                       details: nil))
                    return
                }
                viewController = window.rootViewController
            } else {
                guard let window = UIApplication.shared.keyWindow else {
                    result(FlutterError(code: "VIEW_CONTROLLER_NOT_FOUND", 
                                       message: "Could not find root view controller", 
                                       details: nil))
                    return
                }
                viewController = window.rootViewController
            }
            
            guard let rootViewController = viewController else {
                result(FlutterError(code: "VIEW_CONTROLLER_NOT_FOUND", 
                                   message: "Could not find root view controller", 
                                   details: nil))
                return
            }
            
            let handler = ThreeDSecureProcessHandler.shared
            handler.startThreeDSecureProcess(viewController: rootViewController, 
                                          delegate: threeDSecureHandler, 
                                          resourceId: resourceId)
            break
        }
    }

    private func color(with hex: UInt) -> UIColor {
        let a = CGFloat((hex & 0xFF000000) >> 24) / 255.0
        let r = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x0000FF00) >>  8) / 255.0
        let b = CGFloat(hex & 0x000000FF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
