//
//  RQuery.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 31/03/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

extension HTTPRequest {
    enum Endpoint: String {
        case crypto = "/crypto/1/"
    }
    
    convenience init(endpoint: Endpoint, path: String, method: HTTPRequest.Method = .GET) {
        self.init(path: endpoint.rawValue + path, method: method)
    }
}

enum RQuery {
    enum cryptoMarkets {
        static var fetch: GenericQuery<ListCreator<CryptoMarketCreator>> {
            let request = HTTPRequest(endpoint: .crypto, path: "markets", method: .GET)
            request.headers.accept = .json
            
            return GenericQuery(request: request)
        }
        
        static func buy(crypto: String, withOrder order: TradeOrder) -> GenericQuery<OrderCreator> {
            let request = HTTPRequest(endpoint: .crypto, path: "accounts/me/portfolio/\(crypto)/buy", method: .POST)
            request.body = HTTPRequestJSONBody(TradeOrderCreator.toRaw(from: order))
            request.headers.accept = .json
            return GenericQuery(request: request)
        }
        
        static func sell(crypto: String, withOrder order: TradeOrder) -> GenericQuery<OrderCreator> {
            let request = HTTPRequest(endpoint: .crypto, path: "accounts/me/portfolio/\(crypto)/sell", method: .POST)
            request.body = HTTPRequestJSONBody(TradeOrderCreator.toRaw(from: order))
            request.headers.accept = .json
            return GenericQuery(request: request)
        }
        
        static func delete(order: Order.Identifier, forCrypto crypto: String) -> GenericQuery<OrderCreator> {
            let request = HTTPRequest(endpoint: .crypto, path: "accounts/me/portfolio/\(crypto)/orders/\(order)", method: .DELETE)
            request.headers.accept = .json
            return GenericQuery(request: request)
        }
    }
    
    static var cryptoAccount: GenericQuery<AccountCreator> {
        let request = HTTPRequest(endpoint: .crypto, path: "accounts/me", method: .GET)
        request.headers.accept = .json
        
        return GenericQuery(request: request)
    }
}
