//
//  Account.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 07/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation


public struct Account {
    public let baseBalance: BaseBalance
    public let portfolio: [Position]
}

struct AccountCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = Account
    
    static func toRaw(from: Account) -> [String: Any] {
        fatalError()
    }
    
    static func from(_ rawValue: [String: Any]) throws -> Account {
        let baseBalance = try BaseBalanceCreator.fromAny(rawValue, "baseBalance")
        let portfolio = try ListCreator<PositionCreator>.fromAny(rawValue, "portfolio")
        
        return Account(baseBalance: baseBalance, portfolio: portfolio)
    }
}
