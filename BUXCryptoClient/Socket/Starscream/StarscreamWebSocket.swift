//
//  StarscreamWebSocket.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import Starscream

final class StarscreamWebSocket: WebSocket {
    weak var delegate: WebSocketDelegate?
    
    var connected: Bool {
        return webSocket.isConnected
    }
    
    private let webSocket: Starscream.WebSocket
    
    init(withURL url: URL, headers: [String: String]? = nil) {
        var request = URLRequest(url: url)
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }

        self.webSocket = Starscream.WebSocket(request: request)
        self.webSocket.delegate = self
    }
    
    func connect() {
        self.webSocket.connect()
    }
    
    func disconnect() {
        self.webSocket.disconnect()
    }
    
    func send(_ data: String) throws {
        self.webSocket.write(string: data)
    }
    
    func send(_ data: Data) throws {
        self.webSocket.write(data: data)
    }
    
}

extension StarscreamWebSocket: Starscream.WebSocketDelegate {
    func websocketDidConnect(socket: Starscream.WebSocketClient) {
        self.delegate?.webSocketDidConnect(self)
    }
    
    func websocketDidDisconnect(socket: Starscream.WebSocketClient, error: Error?) {
        self.delegate?.webSocket(self, didDisconnectWithError: error)
    }
    
    func websocketDidReceiveMessage(socket: Starscream.WebSocketClient, text: String) {
        self.delegate?.webSocket(self, didReceiveMessage: text)
    }
    
    func websocketDidReceiveData(socket: Starscream.WebSocketClient, data: Data) {
        // not using data, so just ignoring it
    }
}
