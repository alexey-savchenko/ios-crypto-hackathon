//
//  Transaction.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 07/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public struct Transaction {
    public enum TransactionType: String {
        case buy = "BUY"
        case sell = "SELL"
        case reward = "REWARD"
        case fee = "FEE"
    }
    
    public let identifier: String
    public let type: TransactionType
    public let amount: BigMoney
    public let description: String
    public let dateCreated: Date
}

struct TransactionCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = Transaction
    
    static func toRaw(from: Transaction) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> Transaction {
        let identifier = try PrimitiveCreator<String>.fromAny(rawValue, "id")
        let type = try EnumCreator<Transaction.TransactionType>.fromAny(rawValue, "type")
        let amount = try BigMoneyCreator.fromAny(rawValue, "amount")
        let description = try PrimitiveCreator<String>.fromAny(rawValue, "description")
        let dateCreated = try DateCreator.fromAny(rawValue, "dateCreated")
        
        return Transaction(identifier: identifier,
                           type: type,
                           amount: amount,
                           description: description,
                           dateCreated: dateCreated)
    }
}
