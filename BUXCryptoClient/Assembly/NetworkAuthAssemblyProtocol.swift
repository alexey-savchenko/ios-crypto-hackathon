//
//  NetworkAuthAssemblyProtocol.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 06/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

protocol NetworkAuthAssemblyProtocol {
    var authenticator: HTTPRequestProcessor {get}
}
