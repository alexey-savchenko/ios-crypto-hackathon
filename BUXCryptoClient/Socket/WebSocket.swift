//
//  WebSocket.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol WebSocket {
    weak var delegate: WebSocketDelegate? {get set}
    
    var connected: Bool {get}
    
    func connect()
    func disconnect()
    
    func send(_ data: String) throws
    func send(_ data: Data) throws
}
