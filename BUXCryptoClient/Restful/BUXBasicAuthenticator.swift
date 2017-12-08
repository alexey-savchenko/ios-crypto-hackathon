//
//  BUXBasicAuthenticator.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 24/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import HTTPClient

final class BUXBasicAuthenticator: HTTPRequestProcessor {
    private let credentials: ServiceCredentials
    
    init(credentials: ServiceCredentials) {
        self.credentials = credentials
    }
    
    func process(_ request: HTTPRequest) throws -> HTTPRequest {
        request.headers.authorization = "\(self.credentials.type) \(self.credentials.token)"
        return request
    }
}
