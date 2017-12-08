//
//  BUXCryptoClient.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 13/05/16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

public final class BUXCryptoClient {
    public enum Environment {
        case development
        
        var appURL: URL {
            switch self {
            case .development:
                return URL(string: "https://api.dev.getbux.com/crypto")!
            }
        }
        
        var socketURL: URL {
            switch self {
            case .development:
                return URL(string: "https://api.dev.getbux.com/crypto/1/subscriptions/me")!
            }
        }
    }
    
    public lazy var cryptoMarketController: CryptoMarketController = { [unowned self] in
        return self.assembly.cryptoMarketController
    }()
    
    fileprivate let assembly: Assembly
        
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}

extension BUXCryptoClient {
    public func connectToRealtimeFeed() {
        self.assembly.webSocket.controller.connect()
    }
    
    public func disconnectFromRealtimeFeed() {
        self.assembly.webSocket.controller.disconnect()
    }
}
