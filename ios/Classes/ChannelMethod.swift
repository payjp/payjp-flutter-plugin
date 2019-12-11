//
//  ChannelContract.swift
//  payjp_flutter
//
//  Created by Tatsuya Kitagawa on 2019/12/11.
//

import Foundation

/// MethodCall to Native
enum ChannelMethodToNative: String {
    case configure,
    startCardForm,
    showTokenProcessingError,
    completeCardForm
}

/// MethodCall from Native
enum ChannelMethodFromNative: String {
    case onCardFormCompleted,
    onCardFormCanceled,
    onCardFormProducedToken
}
