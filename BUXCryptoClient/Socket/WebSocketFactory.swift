//
//  WebSocketFactory.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol WebSocketFactory {
    func webSocket() -> WebSocket
}
