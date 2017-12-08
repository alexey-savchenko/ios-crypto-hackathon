//
//  ServiceCredentials.swift
//  Cockpit
//
//  Created by Evgeny Shurakov on 16/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

final class ServiceCredentials {
    let type: String
    let token: String
    
    let refreshToken: String?
    let refreshDate: Date?
    
    init(type: String, token: String, refreshToken: String? = nil, refreshDate: Date? = nil) {
        self.type = type
        self.token = token
        
        self.refreshToken = refreshToken
        self.refreshDate = refreshDate
    }
}

struct ServiceCredentialsCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = ServiceCredentials
    
    static func toRaw(from: ServiceCredentials) -> [String: Any] {
        var result: [String: Any] = [
            "token_type" : from.type,
            "access_token" : from.token,
        ]
        
        if let refreshToken = from.refreshToken, let refreshDate = from.refreshDate {
            result["refresh_token"] = refreshToken
            result["refresh_date"] = DateCreator.toRaw(from: refreshDate)
        }
        
        return result
    }
    
    static func from(_ rawValue: [String: Any]) throws -> ServiceCredentials {
        let type = try PrimitiveCreator<String>.fromAny(rawValue, "token_type")
        let token = try PrimitiveCreator<String>.fromAny(rawValue, "access_token")
        
        var refreshToken = try PrimitiveCreator<String>.optionalFromAny(rawValue, "refresh_token")
        var refreshDate = try DateCreator.optionalFromAny(rawValue, "refresh_date")
        if refreshDate == nil, let expiresIn = try PrimitiveCreator<Int>.optionalFromAny(rawValue, "expires_in") {
            
            var refreshInterval = TimeInterval(expiresIn) * 0.1
            refreshInterval = max(refreshInterval, 60 * 60 * 24 * 14);
            
            refreshDate = Date(timeIntervalSinceNow: TimeInterval(expiresIn) - refreshInterval)
        }
        
        if refreshDate == nil {
            refreshToken = nil
        }
        
        return ServiceCredentials(type: type,
                                  token: token,
                                  refreshToken: refreshToken,
                                  refreshDate: refreshDate)
    }
}
