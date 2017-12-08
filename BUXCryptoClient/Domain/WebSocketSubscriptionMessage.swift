//
//  WebSocketSubscriptionMessage.swift
//  BUXCryptoClient
//

import Foundation

final class WebSocketSubscriptionMessage {
    let subscribeTo: [WebSocketChannel]
    let unsubscribeFrom: [WebSocketChannel]
    
    init(subscribeTo: [WebSocketChannel], unsubscribeFrom: [WebSocketChannel]) {
        self.subscribeTo = subscribeTo
        self.unsubscribeFrom = unsubscribeFrom
    }
}

struct WebSocketSubscriptionMessageCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = WebSocketSubscriptionMessage

    static func toRaw(from: WebSocketSubscriptionMessage) -> [String: Any] {
        return [
            "subscribeTo": from.subscribeTo.map({ $0.stringValue }),
            "unsubscribeFrom": from.unsubscribeFrom.map({ $0.stringValue })
        ]
    }
    
    static func from(_ rawValue: [String: Any]) throws -> WebSocketSubscriptionMessage {
        fatalError("Not implemented")
    }
}
