//
//  ApplePayModule.swift
//  payjp_flutter
//
//  Created by Tatsuya Kitagawa on 2019/12/27.
//

import Foundation
import PAYJP
import PassKit

// MARK: - ApplePayModuleType

protocol ApplePayModuleType {
    func isSupportedApplePay(_ result: FlutterResult)

    func makeApplePayToken(
        _ result: FlutterResult,
        appleMerchantId: String,
        currencyCode: String,
        countryCode: String,
        summaryItemLabel: String,
        summaryItemAmount: String,
        requiredBillingAddress: Bool)

    func completeApplePay(
        _ result: FlutterResult,
        isSuccess: Bool,
        errorMessage: String?)
}

// MARK: - ApplePayModule

class ApplePayModule: NSObject, ApplePayModuleType {

    private let channel: FlutterMethodChannel
    private var completionHandler: ((Any) -> Void)?

    init(channel: FlutterMethodChannel) {
        self.channel = channel
        self.completionHandler = nil
    }

    func isSupportedApplePay(_ result: FlutterResult) {
        let canMakePayments = PKPaymentAuthorizationViewController.canMakePayments()
        result(canMakePayments)
    }

    func makeApplePayToken(
        _ result: FlutterResult,
        appleMerchantId: String,
        currencyCode: String,
        countryCode: String,
        summaryItemLabel: String,
        summaryItemAmount: String,
        requiredBillingAddress: Bool
    ) {
        let request = PKPaymentRequest()
        request.merchantIdentifier = appleMerchantId
        request.currencyCode = currencyCode
        request.countryCode = countryCode
        let item = PKPaymentSummaryItem(
            label: summaryItemLabel,
            amount: NSDecimalNumber(string: summaryItemAmount)
        )
        request.paymentSummaryItems = [item]
        request.supportedNetworks = self.supportedPaymentNetworks
        request.merchantCapabilities = .capability3DS
        if requiredBillingAddress {
            request.requiredBillingAddressFields = .postalAddress
        }
        if let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request),
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            authorizationViewController.delegate = self
            rootViewController.present(authorizationViewController, animated: true, completion: nil)
        }
        result(nil)
    }

    func completeApplePay(
        _ result: FlutterResult,
        isSuccess: Bool,
        errorMessage: String?
    ) {
        if let completionHandler = self.completionHandler {
            if #available(iOS 11.0, *) {
                if isSuccess {
                    completionHandler(PKPaymentAuthorizationResult.init(status: .success, errors: nil))
                } else {
                    let errors: [Error]?
                    if let errorMessage = errorMessage {
                        let error = TokenStoringError(errorDescription: errorMessage)
                        errors = [error]
                    } else {
                        errors = nil
                    }
                    completionHandler(PKPaymentAuthorizationResult.init(status: .failure, errors: errors))
                }
            } else {
                if isSuccess {
                    completionHandler(PKPaymentAuthorizationStatus.success)
                } else {
                    completionHandler(PKPaymentAuthorizationStatus.failure)
                }
            }
            self.completionHandler = nil
        }
        result(nil)
    }

    // MARK: - Utility

    private var supportedPaymentNetworks: [PKPaymentNetwork] {
        get {
            if #available(iOS 10.0, *) {
                return PKPaymentRequest.availableNetworks()
            } else {
                // .JCB only available >= 10.1
                return [.visa, .masterCard, .amex, .discover]
            }
        }
    }
}

// MARK: - PKPaymentAuthorizationViewControllerDelegate

extension ApplePayModule: PKPaymentAuthorizationViewControllerDelegate {

    func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        completion: @escaping (PKPaymentAuthorizationStatus) -> Void
    ) {
        if #available(iOS 11.0, *) {/* nothing */} else {
            self.completionHandler = (completion as! ((Any) -> Void))
            self.createToken(with: payment.token)
        }
    }

    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        self.completionHandler = (completion as! ((Any) -> Void))
        self.createToken(with: payment.token)
    }

    func paymentAuthorizationViewControllerDidFinish(
        _ controller: PKPaymentAuthorizationViewController
    ) {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.dismiss(animated: true) { [weak self] in
                let method = ChannelMethodFromNative.onApplePayCompleted
                self?.channel.invokeMethod(method.rawValue, arguments: nil)
            }
        }
    }

    private func createToken(with paymentToken: PKPaymentToken) {
        APIClient.shared.createToken(with: paymentToken) { [weak self] result in
            let method: ChannelMethodFromNative
            switch result {
            case .success(let token):
                method = .onApplePayProducedToken
                self?.channel.invokeMethod(method.rawValue, arguments: token.rawValue)
                break
            case .failure(let error):
                method = .onApplePayFailedRequestToken
                // TODO: error message strategy
                let errorObject: [String: Any] = [
                    "errorCode": error.errorCode,
                    "errorMessage": error.localizedDescription
                ]
                self?.channel.invokeMethod(method.rawValue, arguments: errorObject)
                break
            }
        }
    }
}
