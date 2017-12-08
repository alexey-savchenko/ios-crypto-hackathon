//
//  URLCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 08/02/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

struct URLCreator: Creator {
    typealias RawType = String
    typealias StrongType = URL
    
    static func toRaw(from: URL) -> String {
        return from.absoluteString
    }
    
    static func from(_ rawValue: String) throws -> URL {
        if let result = URL(string: rawValue) {
            return result
        }
        
        throw CreatorError.unacceptableValue
    }
}
