//
//  DateCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 28/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

struct DateCreator: Creator {
    typealias RawType = Int
    typealias StrongType = Date
    
    static func toRaw(from: Date) -> Int {
        return Int(from.timeIntervalSinceReferenceDate * 1000)
    }
    
    static func from(_ rawValue: Int) throws -> Date {
        return Date(timeIntervalSince1970: TimeInterval(rawValue) / 1000)
    }
}
