//
//  ListCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 13/12/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

struct ListCreator<T: Creator>: Creator {
    typealias RawType = [Any]
    typealias StrongType = [T.StrongType]
    
    static func toRaw(from: [T.StrongType]) -> [Any] {
        return from.flatMap { T.toRaw(from: $0) }
    }
    
    static func from(_ rawValue: [Any]) throws -> [T.StrongType] {
        let result: [T.StrongType] = rawValue.flatMap {
            do {
                return try T.fromAny($0)
            } catch {
                // TODO: print error
                return nil
            }
        }
        
        return result
    }
}
