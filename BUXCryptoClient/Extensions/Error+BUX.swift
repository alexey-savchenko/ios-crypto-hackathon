//
//  Error+BUX.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 18/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

protocol BUXError: Error {
    var localizedDescription: String {get}
    var localizedFailureReason: String? {get}
}

extension NSError: BUXError {
    
}
