//
//  WebSocketChannel.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 17.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

enum WebSocketChannel {
    case market(String)
    
    var stringValue: String {
        switch self {
        case .market(let marketName):
            return "crypto.quote.\(marketName)"
        }
    }
}

extension WebSocketChannel: Hashable {
    var hashValue: Int {
        return self.stringValue.hashValue
    }
}

func ==(lhs: WebSocketChannel, rhs: WebSocketChannel) -> Bool {
    return lhs.stringValue == rhs.stringValue
}
