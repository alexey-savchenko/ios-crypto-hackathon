//
//  WebSocketEventListCreator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 16/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

struct WebSocketEventListCreator<T>: Creator {
    typealias RawType = [Any]
    typealias StrongType = [T]
    
    static func toRaw(from: [T]) -> [Any] {
        fatalError("Unsupported")
    }
    
    static func from(_ rawValue: [Any]) throws -> [T] {
        let result: [T] = try rawValue.flatMap {
            do {
                return try WebSocketEventCreator.fromAny($0) as? T
            } catch (CreatorError.unacceptableValue) { // TODO: specific web socket event creator error?
                return nil
            } catch {
                throw error
            }
        }
        
        return result
    }
}
