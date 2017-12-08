//
//  BUXWebSocketEventFactory.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 17.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

final class BUXWebSocketEventFactory: WebSocketEventFactory {
    enum SocketError: Error {
        case invalidInput
    }
    
    func event(fromJSONString jsonString: String) throws -> Any {
        guard let data = jsonString.data(using: String.Encoding.utf8), data.count > 0 else {
            throw SocketError.invalidInput
        }
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        
        return try WebSocketEventCreator.fromAny(jsonObject)
    }
}
