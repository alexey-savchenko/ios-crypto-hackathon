//
//  WebSocketEventFactory.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 16.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol WebSocketEventFactory {
    func event(fromJSONString: String) throws -> Any
}
