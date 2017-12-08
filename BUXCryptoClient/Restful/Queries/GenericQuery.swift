//
//  GenericQuery.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 31/03/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

final class GenericQuery<T: Creator>: Query {
    typealias CreatorType = T
    
    private let _request: HTTPRequest
    
    init(request: HTTPRequest) {
        self._request = request
    }
    
    func request() throws -> HTTPRequest {
        return self._request
    }
    
}
