//
//  CryptoMarketController.swift
//  BUXCryptoClient
//
//  Created by Ian Guedes Maia on 06/12/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import HTTPClient

public protocol CryptoMarketObserver: class {
    func cryptoMarketController(_ controller: CryptoMarketController, didUpdatePriceOfCryptoMarket cryptoMarket: CryptoMarketQuoteUpdate)
}

public final class CryptoMarketController {
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    fileprivate let httpService: BUXHTTPService
    fileprivate let webSocketController: WebSocketController
    fileprivate let webSocketSubscriptionHelper: WebSocketSubscriptionHelper
    
    fileprivate weak var observer: CryptoMarketObserver?
    fileprivate var observingCryptos: [CryptoMarket] = []
    
    fileprivate var cryptoQuoteEventHandler: WebSocketEventHandler?
    
    init(httpService: BUXHTTPService, webSocketController: WebSocketController, webSocketSubscriptionHelper: WebSocketSubscriptionHelper) {
        self.httpService = httpService
        self.webSocketController = webSocketController
        self.webSocketSubscriptionHelper = webSocketSubscriptionHelper
        
        self.webSocketController.addObserver(self)
    }
    
    deinit {
        self.webSocketController.removeObserver(self)
    }
    
    fileprivate func setupEventHandlers() {
        self.cryptoQuoteEventHandler = self.webSocketController.createEventHandler(for: WebSocketEvent.cryptoMarketQuote) { [weak self] (event) in
            self?.handleCryptoQuoteUpdate(event.quoteUpdate)
        }
    }
    
    fileprivate func removeEventHandlers() {
        self.cryptoQuoteEventHandler = nil
    }
}

extension CryptoMarketController {
    public func fetchUserAccount(completion: @escaping (Result<Account>) -> Void) {
        self.httpService.execute(R.query.cryptoAccount) { (response) in
            switch response {
            case .success(let cryptoList):
                completion(.success(cryptoList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchCryptoMarkets(completion: @escaping (Result<[CryptoMarket]>) -> Void) {
        self.httpService.execute(R.query.cryptoMarkets.fetch) { (response) in
            switch response {
            case .success(let cryptoList):
                completion(.success(cryptoList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func send(buyOrder order: TradeOrder, forCrypto crypto: String, completion: @escaping (Result<Order>) -> Void) {
        self.httpService.execute(R.query.cryptoMarkets.buy(crypto: crypto, withOrder: order)) { (response) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func send(sellOrder order: TradeOrder, forCrypto crypto: String, completion: @escaping (Result<Order>) -> Void) {
        self.httpService.execute(R.query.cryptoMarkets.sell(crypto: crypto, withOrder: order)) { (response) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func cancel(order: Order.Identifier, forCrypto crypto: String, completion: @escaping (Result<Order>) -> Void) {
        self.httpService.execute(R.query.cryptoMarkets.delete(order: order, forCrypto: crypto)) { (response) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension CryptoMarketController { // Crypto Market Quote Update
    public func setObserver(_ observer: CryptoMarketObserver, forCryptos cryptos: [CryptoMarket]) {
        self.observer = observer
        self.observingCryptos = cryptos
        
        self.setupEventHandlers()
        self.updateSubscription()
    }
    
    public func removeObserver() {
        self.observer = nil
        self.observingCryptos = []
        
        self.removeEventHandlers()
        self.updateSubscription()
    }
    
    fileprivate func handleCryptoQuoteUpdate(_ cryptoQuoteUpdate: CryptoMarketQuoteUpdate) {
        self.notifyAboutCryptoQuoteUpdate(forCrypto: cryptoQuoteUpdate)
    }
    
    fileprivate func notifyAboutCryptoQuoteUpdate(forCrypto cryptoQuoteUpdate: CryptoMarketQuoteUpdate) {
        self.observer?.cryptoMarketController(self, didUpdatePriceOfCryptoMarket: cryptoQuoteUpdate)
    }
}

extension CryptoMarketController { // Subscription
    fileprivate func updateSubscription() {
        var channels: Set<WebSocketChannel> = Set()
        for cryptoMarket in self.observingCryptos {
            channels.insert(.market(cryptoMarket.name))
        }
        
        self.webSocketSubscriptionHelper.channels = channels
    }
}

extension CryptoMarketController: WebSocketControllerObserver {
    func webSocketControllerDidConnect(_ controller: WebSocketController) {
        print("webSocketControllerDidConnect")
    }
    
    func webSocketController(_ controller: WebSocketController, didDisconnectWithError error: Error?) {
        print("didDisconnectWithError")
    }
}
