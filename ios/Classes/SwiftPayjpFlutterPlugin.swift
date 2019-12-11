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

  init(channel: FlutterMethodChannel) {
    self.channel = channel
    self.cardFormModule = CardFormModule(channel: channel)
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
        }
        result(nil)
        break;
    case .startCardForm:
        break;
    case .showTokenProcessingError:
        break;
    case .completeCardForm:
        break;
    }
  }
}
