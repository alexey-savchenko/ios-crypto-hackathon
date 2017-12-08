//
//  BaseBalance.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 07/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public struct BaseBalance {
    public let quoteCurrency: String
    public let baseCurrency: String
    public let quantity: BigMoney
    public let reservedAmount:  BigMoney
    public let transactions: [Transaction]
    public let orders: [Order]
    public let currentValue: BigMoney
}

struct BaseBalanceCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = BaseBalance
    
    static func toRaw(from: BaseBalance) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> BaseBalance {
        let position = try PositionCreator.fromAny(rawValue)
        let currentValue = try BigMoneyCreator.fromAny(rawValue, "currentValue")

        return BaseBalance(quoteCurrency: position.quoteCurrency,
                        baseCurrency: position.baseCurrency,
                        quantity: position.quantity,
                        reservedAmount: position.reservedAmount,
                        transactions: position.transactions,
                        orders: position.orders,
                        currentValue: currentValue)
    }
}
