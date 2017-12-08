//
//  EmailCredentials.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 16/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

final class EmailCredentials {
    let emailAddress: String
    let password: String
    
    init(emailAddress: String, password: String) {
        self.emailAddress = emailAddress
        self.password = password
    }
}

struct EmailCredentialsCreator: Creator {
    typealias RawType = [String: Any]
    typealias StrongType = EmailCredentials
    
    static func toRaw(from: EmailCredentials) -> [String: Any] {
        return [
            "email_address": from.emailAddress,
            "password": from.password
        ]
    }
    
    static func from(_ rawValue: [String: Any]) throws -> EmailCredentials {
        fatalError("Not implemented")
    }
}
