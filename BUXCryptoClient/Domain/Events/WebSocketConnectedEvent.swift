//
//  WebSocketConnectedEvent.swift
//  BUXCryptoClient
//

import Foundation

final class WebSocketConnectedEvent {
    
}

struct WebSocketConnectedEventCreator: Creator {
    typealias RawType = Any
    typealias StrongType = WebSocketConnectedEvent
    
    static func toRaw(from: WebSocketConnectedEvent) -> Any {
        fatalError("Not implemented")
    }
    
    static func from(_ rawValue: Any) throws -> WebSocketConnectedEvent {
        return WebSocketConnectedEvent()
    }
    
}
