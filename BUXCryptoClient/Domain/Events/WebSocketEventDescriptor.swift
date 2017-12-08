//
//  WebSocketEventDescriptor.swift
//  BUXCryptoClient
//

import Foundation

final class WebSocketEventDescriptor<C: Creator>: WebSocketEventDescriptorHelper {
    let type: String
    
    init(_ type: String) {
        self.type = type
    }
    
    func event(from rawValue: Any) throws -> Any {
        return try C.fromAny(rawValue)
    }
}

protocol WebSocketEventDescriptorHelper {
    var type: String {get}
    func event(from rawValue: Any) throws -> Any
}
