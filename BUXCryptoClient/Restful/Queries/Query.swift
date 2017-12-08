//
//  Query.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 17/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import HTTPClient

protocol Query {
    associatedtype CreatorType: Creator
    
    func request() throws -> HTTPRequest
}

enum QueryResult<T> {
    case success(T)
    case failure(Error)
}
