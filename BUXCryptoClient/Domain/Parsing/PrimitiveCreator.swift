//
//  PrimitiveCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

struct PrimitiveCreator<T>: Creator {
    typealias RawType = T
    typealias StrongType = T
    
    static func toRaw(from: T) -> T {
        return from
    }
    
    static func from(_ rawValue: T) throws -> T {
        return rawValue
    }
}
