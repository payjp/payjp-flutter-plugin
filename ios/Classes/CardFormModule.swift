//
//  CardFormModule.swift
//  payjp_flutter
//
//  Created by Tatsuya Kitagawa on 2019/12/11.
//

import Foundation
import PAYJP

protocol CardFormModuleType {
    func startCardForm(_ result: FlutterResult, with tenantId: String?)

    func showTokenProcessingError(_ result: FlutterResult, with message: String)

    func completeCardForm(_ result: FlutterResult)
}

struct CardFormModule : CardFormModuleType {
    let channel: FlutterMethodChannel
    
    func startCardForm(_ result: (Any?) -> Void, with tenantId: String?) {
        // TODO
        result(nil)
    }
    
    func showTokenProcessingError(_ result: (Any?) -> Void, with message: String) {
        // TODO
        result(nil)
    }
    
    func completeCardForm(_ result: (Any?) -> Void) {
        // TODO
        result(nil)
    }
}
