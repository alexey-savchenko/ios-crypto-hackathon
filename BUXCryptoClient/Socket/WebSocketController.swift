//
//  WebSocketController.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol WebSocketController {
    var connected: Bool {get}
    
    func connect()
    func disconnect()
    
    func send(_ data: [String: Any]) throws
    func send(_ data: Data) throws
    
    func addObserver(_ observer: WebSocketControllerObserver)
    func removeObserver(_ observer: WebSocketControllerObserver)
    
    func createEventHandler<T>(for eventType: WebSocketEventDescriptor<T>, handler: @escaping (T.StrongType) -> Void) -> WebSocketEventHandler
}
