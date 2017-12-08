//
//  LoginQuery.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 20/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

final class LoginQuery: Query {
    typealias CreatorType = ServiceCredentialsCreator
    
    private let credentials: EmailCredentials
    
    init(credentials: EmailCredentials) {
        self.credentials = credentials
    }
    
    func request() throws -> HTTPRequest {
        let request = HTTPRequest(path: "auth/3/authorize", method: .POST)
        
        let rawCredentials = EmailCredentialsCreator.toRaw(from: self.credentials)
        request.body = HTTPRequestJSONBody(["type": "email", "credentials": rawCredentials])
        
        return request
    }
}
