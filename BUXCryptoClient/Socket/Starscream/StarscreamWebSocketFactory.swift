//
//  StarscreamWebSocketFactory.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

final class StarscreamWebSocketFactory: WebSocketFactory {
    private let environment: BUXCryptoClient.Environment
    private let credentials: ServiceCredentials
    
    init(environment: BUXCryptoClient.Environment, credentials: ServiceCredentials) {
        self.environment = environment
        self.credentials = credentials
    }

    func webSocket() -> WebSocket {
        let headers: [String: String] = ["Authorization": "\(self.credentials.type) \(self.credentials.token)"]
        return StarscreamWebSocket(withURL: self.environment.socketURL, headers: headers)
    }
}
