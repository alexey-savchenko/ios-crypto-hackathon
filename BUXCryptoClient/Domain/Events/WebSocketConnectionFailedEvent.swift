//
//  WebSocketConnectionFailedEvent.swift
//  BUXCryptoClient
//

import Foundation

final class WebSocketConnectionFailedEvent {
    let error: APIError
    
    init(error: APIError) {
        self.error = error
    }
}

struct WebSocketConnectionFailedEventCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = WebSocketConnectionFailedEvent
    
    static func toRaw(from: WebSocketConnectionFailedEvent) -> [String: Any] {
        fatalError("Not implemented")
    }
    
    static func from(_ rawValue: [String: Any]) throws -> WebSocketConnectionFailedEvent {
        let error = try APIErrorCreator.fromAny(rawValue, "body")
        return WebSocketConnectionFailedEvent(error: error)
    }
    
}
