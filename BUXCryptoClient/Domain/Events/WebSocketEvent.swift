//
//  WebSocketEvent.swift
//  BUXCryptoClient
//

import Foundation

struct WebSocketEvent {
    static let connected = WebSocketEventDescriptor<WebSocketConnectedEventCreator>("connect.connected")
    static let connectionFailed = WebSocketEventDescriptor<WebSocketConnectionFailedEventCreator>("connect.failed")
    
    static let cryptoMarketQuote = WebSocketEventDescriptor<WebSocketCryptoMarketQuoteEventCreator>("crypto.quote")
    
    static let allEvents: [WebSocketEventDescriptorHelper] = [
        connected,
        connectionFailed,
        
        cryptoMarketQuote,
    ]
    
    private init() {
        
    }
}

struct WebSocketEventCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = Any
    
    static func toRaw(from: Any) -> [String: Any] {
        fatalError("Not supported")
    }
    
    static func from(_ rawValue: [String: Any]) throws -> Any {
        let eventType = try PrimitiveCreator<String>.fromAny(rawValue, "t")
        
        for descriptor in WebSocketEvent.allEvents {
            if descriptor.type == eventType {
                return try descriptor.event(from: rawValue)
            }
        }
        
        throw CreatorError.unacceptableValue
    }
}
