//
//  AnonymousNetworkAuthAssembly.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

final class AnonymousNetworkAuthAssembly: NetworkAuthAssemblyProtocol {
    private unowned let rootAssembly: AnonymousAssembly
    
    init(_ rootAssembly: AnonymousAssembly) {
        self.rootAssembly = rootAssembly
    }
    
    var authenticator: HTTPRequestProcessor {
        return BUXBasicAuthenticator(credentials: self.rootAssembly.credentials)
    }
}
