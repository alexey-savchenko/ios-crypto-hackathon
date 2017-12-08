//
//  VoidCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 31/03/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

struct VoidCreator: Creator {
    typealias RawType = Any
    typealias StrongType = Void
    
    static func toRaw(from: Void) -> Any {
        fatalError()
    }
    
    static func from(_ rawValue: Any) throws -> Void {
        fatalError()
    }
}
