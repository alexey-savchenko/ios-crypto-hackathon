//
//  DecimalCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 28/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

struct DecimalCreator: Creator {
    typealias RawType = String
    typealias StrongType = Decimal
    
    static func toRaw(from: Decimal) -> String {
        fatalError("Not implemented")
    }
    
    static func from(_ rawValue: String) throws -> Decimal {
        if let result = Decimal(string: rawValue) {
            return result
        }
        
        throw CreatorError.unacceptableValue
    }
}

