//
//  CryptoMarketQuoteUpdate.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 07/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public struct CryptoMarketQuoteUpdate {
    public let marketName: String
    public let baseCurrency: String
    public let quoteCurrency: String
    public let bid: Decimal
    public let ask: Decimal
    public let timestamp: Date
}

struct CryptoMarketQuoteUpdateCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = CryptoMarketQuoteUpdate
    
    static func toRaw(from: CryptoMarketQuoteUpdate) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> CryptoMarketQuoteUpdate {
        let marketName = try PrimitiveCreator<String>.fromAny(rawValue, "marketName")
        let baseCurrency = try PrimitiveCreator<String>.fromAny(rawValue, "baseCurrency")
        let quoteCurrency = try PrimitiveCreator<String>.fromAny(rawValue, "quoteCurrency")
        
        let bid = try DecimalCreator.fromAny(rawValue, "bid")
        let ask = try DecimalCreator.fromAny(rawValue, "ask")
        
        let timestamp = try DateCreator.fromAny(rawValue, "timestamp")

        return CryptoMarketQuoteUpdate(marketName: marketName,
                                       baseCurrency: baseCurrency,
                                       quoteCurrency: quoteCurrency,
                                       bid: bid,
                                       ask: ask,
                                       timestamp: timestamp)
    }
}
