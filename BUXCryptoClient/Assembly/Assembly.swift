//
//  Assembly.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 30/09/16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import HTTPClient
import Log

class Assembly {
    fileprivate let logger: Log?
    fileprivate let environment: BUXCryptoClient.Environment

    let credentials: ServiceCredentials

    init(environment: BUXCryptoClient.Environment, credentials: ServiceCredentials, logger: Log? = nil) {
        self.environment = environment
        self.logger = logger
        self.credentials = credentials
    }

    lazy var restful: RestfulAssembly = { [unowned self] in
        let auth = NetworkAuthAssembly(self)
        let errorHandler = BUXErrorHandler()
        return RestfulAssembly(environment: self.environment, networkAuthAssembly: auth, errorHandler: errorHandler, logger: self.logger)
    }()
    
    lazy var webSocket: WebSocketAssembly = { [unowned self] in
        return WebSocketAssembly(environment: self.environment, credentials: self.credentials, logger: self.logger)
    }()
    
    // --
    
    var cryptoMarketController: CryptoMarketController {
        return CryptoMarketController(httpService: self.restful.httpService,
                                     webSocketController: self.webSocket.controller,
                                     webSocketSubscriptionHelper: self.webSocket.subscriptionHelper())
    }
}
