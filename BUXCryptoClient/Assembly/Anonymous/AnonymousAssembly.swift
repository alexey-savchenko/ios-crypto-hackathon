//
//  AnonymousAssembly.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import Log

final class AnonymousAssembly {
    let credentials: ServiceCredentials
    let logger: Log?
    private let environment: BUXCryptoClient.Environment
    
    init(environment: BUXCryptoClient.Environment, credentials: ServiceCredentials, logger: Log? = nil) {
        self.environment = environment
        self.credentials = credentials
        self.logger = logger
    }
    
    lazy var restful: RestfulAssembly = { [unowned self] in
        let auth = AnonymousNetworkAuthAssembly(self)
        return RestfulAssembly(environment: self.environment, networkAuthAssembly: auth, errorHandler: nil, logger: self.logger)
    }()
    
}
