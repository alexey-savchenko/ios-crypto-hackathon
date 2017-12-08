//
//  BUXErrorHandler.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 24/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

final class BUXErrorHandler {
    func handle(error: BUXHTTPService.Error) {
        switch error {
        case .unauthorized:
            print(error)
            //self.userSession.terminate()
        default:
            print(error)
        }
        
    }
}
