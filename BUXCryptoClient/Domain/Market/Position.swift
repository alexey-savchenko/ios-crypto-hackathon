//
//  Position.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 07/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public struct Position {
    public let quoteCurrency: String
    public let baseCurrency: String
    public let quantity: BigMoney
    public let reservedAmount: BigMoney
    public let transactions: [Transaction]
    public let orders: [Order]
}

struct PositionCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = Position
    
    static func toRaw(from: Position) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> Position {
        let quoteCurrency = try PrimitiveCreator<String>.fromAny(rawValue, "quoteCurrency")
        let baseCurrency = try PrimitiveCreator<String>.fromAny(rawValue, "baseCurrency")
        let quantity = try BigMoneyCreator.fromAny(rawValue, "quantity")
        let reservedAmount = try BigMoneyCreator.fromAny(rawValue, "reservedAmount")
        let transactions = try ListCreator<TransactionCreator>.fromAny(rawValue, "transactions")
        let orders = try ListCreator<OrderCreator>.fromAny(rawValue, "orders")
        
        return Position(quoteCurrency: quoteCurrency,
                        baseCurrency: baseCurrency,
                        quantity: quantity,
                        reservedAmount: reservedAmount,
                        transactions: transactions,
                        orders: orders)
    }
}
