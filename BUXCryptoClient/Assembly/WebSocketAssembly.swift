//
//  WebSocketAssembly.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import Log

final class WebSocketAssembly {
    private let environment: BUXCryptoClient.Environment
    private let credentials: ServiceCredentials
    private let logger: Log?
    
    init(environment: BUXCryptoClient.Environment, credentials: ServiceCredentials, logger: Log?) {
        self.environment = environment
        self.credentials = credentials
        self.logger = logger
    }
    
    lazy var controller: WebSocketController = { [unowned self] in
        let webSocketFactory = StarscreamWebSocketFactory(environment: self.environment, credentials: self.credentials)
        let eventFactory = BUXWebSocketEventFactory()
        
        let webSocket = WebSocketControllerImpl(webSocketFactory: webSocketFactory, eventFactory: eventFactory)
        webSocket.logger = self.logger?.subloggerWithTag(tag: "WS")
        return webSocket
        }()
    
    private lazy var subscriptionController: WebSocketSubscriptionController = {
        return WebSocketSubscriptionController(webSocketController: self.controller)
    }()
    
    func subscriptionHelper() -> WebSocketSubscriptionHelper {
        return WebSocketSubscriptionHelper(subscriptionController: self.subscriptionController)
    }
}
