//
//  BUXCryptoClientPersistedData.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 27/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

final class APIClientPersistedData {
    let credentials: ServiceCredentials
    
    init(credentials: ServiceCredentials) {
        self.credentials = credentials
    }
}

struct APIClientPersistedDataCreator: Creator {
    private static let currentVersion: Int = 1
    
    typealias RawType = [String: Any]
    typealias StrongType = APIClientPersistedData
    
    static func toRaw(from: APIClientPersistedData) -> [String: Any] {
        return [
            "v": currentVersion,
            "credentials": ServiceCredentialsCreator.toRaw(from: from.credentials)
        ]
    }
    
    static func from(_ rawValue: [String: Any]) throws -> APIClientPersistedData {
        let version = try PrimitiveCreator<Int>.fromAny(rawValue, "v")
        
        switch version {
        case currentVersion:
            let credentials = try ServiceCredentialsCreator.fromAny(rawValue, "credentials")
            return APIClientPersistedData(credentials: credentials)
            
        default:
            throw CreatorError.unacceptableValue
        }
    }
}
