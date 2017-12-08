//
//  BUXHTTPServiceProvider.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 18/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol BUXHTTPServiceProvider {
    func httpService(with: ServiceCredentials) -> BUXHTTPService
}
