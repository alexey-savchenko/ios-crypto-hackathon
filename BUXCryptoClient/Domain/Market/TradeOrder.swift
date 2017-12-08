//
//  TradeOrder.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 08/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public struct TradeOrder {
    public let tradeSize: BigMoney
    public let limitPrice: Decimal
    
    public init(tradeSize: BigMoney, limitPrice: Decimal) {
        self.tradeSize = tradeSize
        self.limitPrice = limitPrice
    }
}

struct TradeOrderCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = TradeOrder
    
    static func toRaw(from: TradeOrder) -> [String: Any] {
        var result: [String: Any] = [:]
        result["tradeSize"] = BigMoneyCreator.toRaw(from: from.tradeSize)
        result["limitPrice"] = from.limitPrice
        return result
    }
    
    static func from(_ rawValue: [String: Any]) throws -> TradeOrder {
        fatalError()
    }
}
