//
//  ChannelContract.swift
//  payjp_flutter
//
//  Created by Tatsuya Kitagawa on 2019/12/11.
//

import Foundation

/// MethodCall to Native
enum ChannelMethodToNative: String {
    case initialize,
    startCardForm,
    showTokenProcessingError,
    completeCardForm,
    setFormStyle,
    isApplePayAvailable,
    makeApplePayToken,
    completeApplePay,
    startThreeDSecureProcess
}

/// MethodCall from Native
enum ChannelMethodFromNative: String {
    case onCardFormCompleted,
    onCardFormCanceled,
    onCardFormProducedToken,
    onApplePayProducedToken,
    onApplePayFailedRequestToken,
    onApplePayCompleted,
    onThreeDSecureProcessFinished
}
