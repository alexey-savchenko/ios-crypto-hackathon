//
//  AuthAssembly.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

final class NetworkAuthAssembly: NetworkAuthAssemblyProtocol {
    private unowned let rootAssembly: Assembly
    
    init(_ rootAssembly: Assembly) {
        self.rootAssembly = rootAssembly
    }
    
    var authenticator: HTTPRequestProcessor {
        return BUXAuthenticator(credentials: self.rootAssembly.credentials)
    }
}
