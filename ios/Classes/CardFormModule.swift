//
//  CardFormModule.swift
//  payjp_flutter
//
//  Created by Tatsuya Kitagawa on 2019/12/11.
//

import Foundation
import PAYJP

// MARK: - CardFormModuleType

protocol CardFormModuleType {
    func startCardForm(_ result: FlutterResult, with tenantId: String?)

    func showTokenProcessingError(_ result: FlutterResult, with message: String)

    func completeCardForm(_ result: FlutterResult)
}

// MARK: - CardFormModule

class CardFormModule: CardFormModuleType {
    private let channel: FlutterMethodChannel
    private var completionHandler: ((Error?) -> Void)?

    init(channel: FlutterMethodChannel) {
        self.channel = channel
        self.completionHandler = nil
    }

    func startCardForm(_ result: FlutterResult, with tenantId: String?) {
        // validate Info.plist for scanner
        let description = Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String
        assert(description?.isEmpty == false, "The app's Info.plist must contain an NSCameraUsageDescription key to use scanner in card form.")
        let cardForm = CardFormViewController.createCardFormViewController()
        cardForm.delegate = self
        // get host ViewController
        if let hostViewController = UIApplication.shared.keyWindow?.rootViewController {
            if let navigationController = hostViewController as? UINavigationController {
                navigationController.pushViewController(cardForm, animated: true)
            } else {
                let navigationController = UINavigationController.init(rootViewController: cardForm)
                hostViewController.present(navigationController, animated: true, completion: nil)
            }
        }
        result(nil)
    }

    func showTokenProcessingError(_ result: FlutterResult, with message: String) {
        if let completionHandler = self.completionHandler {
            completionHandler(TokenStoringError(errorDescription: message))
            self.completionHandler = nil
        }
        result(nil)
    }

    func completeCardForm(_ result: FlutterResult) {
        if let completionHandler = self.completionHandler {
            completionHandler(nil)
            self.completionHandler = nil
        }
        result(nil)
    }
}

// MARK: - CardFormViewControllerDelegate

extension CardFormModule: CardFormViewControllerDelegate {
    func cardFormViewController(_: CardFormViewController,
                                didCompleteWith result: CardFormResult) {
        let method: ChannelMethodFromNative
        switch result {
        case .cancel:
            method = .onCardFormCanceled
            break
        case .success:
            method = .onCardFormCompleted
            break
        }
        if let hostViewController = UIApplication.shared.keyWindow?.rootViewController {
            if let navigationController = hostViewController as? UINavigationController {
                navigationController.popViewController(animated: true)
                self.channel.invokeMethod(method.rawValue, arguments: nil)
            } else {
                hostViewController.dismiss(animated: true) { [weak self] in
                    self?.channel.invokeMethod(method.rawValue, arguments: nil)
                }
            }
        }
    }

    func cardFormViewController(_: CardFormViewController,
                                didProduced token: Token,
                                completionHandler: @escaping (Error?) -> Void) {
        self.completionHandler = completionHandler
        let method = ChannelMethodFromNative.onCardFormProducedToken
        self.channel.invokeMethod(method.rawValue, arguments: token.rawValue)
    }

}
