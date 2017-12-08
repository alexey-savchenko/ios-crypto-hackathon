//
//  WebSocketControllerObserver.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol WebSocketControllerObserver: class {
    func webSocketControllerDidConnect(_ controller: WebSocketController)
    func webSocketController(_ controller: WebSocketController, didDisconnectWithError error: Error?)
}
