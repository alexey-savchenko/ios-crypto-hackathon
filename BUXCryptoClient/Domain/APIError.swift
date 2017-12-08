//
//  APIError.swift
//  BUXCryptoClient
//

import Foundation

final class APIError {
    let developerMessage: String?
    let errorCode: String
    
    init(errorCode: String, developerMessage: String?) {
        self.errorCode = errorCode
        self.developerMessage = developerMessage
    }
}

struct APIErrorCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = APIError
    
    static func toRaw(from: APIError) -> [String: Any] {
        fatalError("Not implemented")
    }
    
    static func from(_ rawValue: [String: Any]) throws -> APIError {
        let errorCode = try PrimitiveCreator<String>.fromAny(rawValue, "errorCode")
        let developerMessage: String? = try PrimitiveCreator<String>.optionalFromAny(rawValue, "developerMessage")
        
        return APIError(errorCode: errorCode, developerMessage: developerMessage)
    }
}
