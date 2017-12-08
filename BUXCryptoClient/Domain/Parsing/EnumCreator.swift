//
//  EnumCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

struct EnumCreator<T: RawRepresentable>: Creator {
    typealias RawType = T.RawValue
    typealias StrongType = T
    
    static func toRaw(from: T) -> T.RawValue {
        return from.rawValue
    }
    
    static func from(_ rawValue: T.RawValue) throws -> T {
        if let value = T(rawValue: rawValue) {
            return value
        } else {
            throw CreatorError.unacceptableValue
        }
    }
}
