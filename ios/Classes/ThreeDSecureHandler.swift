//
//  ThreeDSecureHandler.swift
//  payjp_flutter
//

import Foundation
import PAYJP

protocol ThreeDSecureHandlerDelegate: AnyObject {
    func threeDSecureHandlerDidFinish(status: ThreeDSecureProcessStatus)
}

class ThreeDSecureHandler: NSObject {
    weak var delegate: ThreeDSecureHandlerDelegate?
    private let channel: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
    }
    
    private func notifyCompletion(status: ThreeDSecureProcessStatus) {
        let statusString: String
        switch status {
        case .completed:
            statusString = "completed"
        case .canceled:
            statusString = "canceled"
        @unknown default:
            statusString = "failed"
        }
        self.channel.invokeMethod(ChannelMethodFromNative.onThreeDSecureProcessFinished.rawValue, 
                                 arguments: statusString)
        delegate?.threeDSecureHandlerDidFinish(status: status)
    }
}

extension ThreeDSecureHandler: ThreeDSecureProcessHandlerDelegate {
    func threeDSecureProcessHandlerDidFinish(_ handler: ThreeDSecureProcessHandler, status: ThreeDSecureProcessStatus) {
        notifyCompletion(status: status)
    }
}