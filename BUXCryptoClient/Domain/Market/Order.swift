//
//  Order.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 07/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public struct Order {
    public typealias Identifier = String
    
    public enum OrderType: String {
        case limitSell = "LIMIT_SELL"
        case limitBuy = "LIMIT_BUY"
    }
    
    public enum Status: String {
        case created = "CREATED"
        case cancelled = "CANCELLED"
    }
    
    public let identifier: Identifier
    public let type: OrderType
    public let limit: BigMoney
    public let quantity: BigMoney
    public let status: Status
}

struct OrderCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = Order
    
    static func toRaw(from: Order) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> Order {
        let identifier = try PrimitiveCreator<String>.fromAny(rawValue, "id")
        let type = try EnumCreator<Order.OrderType>.fromAny(rawValue, "type")
        let limit = try BigMoneyCreator.fromAny(rawValue, "limit")
        let quantity = try BigMoneyCreator.fromAny(rawValue, "quantity")
        let status = try EnumCreator<Order.Status>.fromAny(rawValue, "status")

        return Order(identifier: identifier,
                     type: type,
                     limit: limit,
                     quantity: quantity,
                     status: status)
    }
}
