//
//  BUXCryptoClientPersister.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 28/01/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

public protocol BUXCryptoClientPersister {
    func store(data: Data)
    func retrive() throws -> Data
}
