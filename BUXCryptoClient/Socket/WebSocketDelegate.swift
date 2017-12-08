//
//  WebSocketDelegate.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol WebSocketDelegate: class {
    func webSocketDidConnect(_ webSocket: WebSocket)
    func webSocket(_ webSocket: WebSocket, didDisconnectWithError error: Error?)
    
    func webSocket(_ webSocket: WebSocket, didReceiveMessage message: String)
}
