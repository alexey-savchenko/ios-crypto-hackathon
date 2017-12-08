//
//  WebSocketCryptoMarketQuoteEvent.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 06/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

final class WebSocketCryptoMarketQuoteEvent {
    let quoteUpdate: CryptoMarketQuoteUpdate
    
    init(quoteUpdate: CryptoMarketQuoteUpdate) {
        self.quoteUpdate = quoteUpdate
    }
}

struct WebSocketCryptoMarketQuoteEventCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = WebSocketCryptoMarketQuoteEvent
    
    static func toRaw(from: WebSocketCryptoMarketQuoteEvent) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> WebSocketCryptoMarketQuoteEvent {
        let quoteUpdate = try CryptoMarketQuoteUpdateCreator.fromAny(rawValue, "body")
        
        return WebSocketCryptoMarketQuoteEvent(quoteUpdate: quoteUpdate)
    }
}
