//
//  ViewController.swift
//  BUXCryptoClientSample
//
//  Created by Ian Guedes Maia on 10/11/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit
import BUXCryptoClient

class ViewController: UIViewController {

    private static let accessToken: String = // TODO: add token
    
    private let client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: ViewController.accessToken)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.client.connectToRealtimeFeed()
        
//        self.client.cryptoMarketController.fetchCryptoMarkets { [weak self] (result) in
//            guard let `self` = self else { return }
//
//            switch result {
//            case .success(let list):
//                print(String(describing: list))
////                self.client.cryptoMarketController.setObserver(self, forCryptos: list)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
//        self.client.cryptoMarketController.fetchUserAccount { [weak self] (result) in
//            switch result {
//            case .success(let account):
//                print(account)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
//        let tradeSize = BigMoney(currency: "BTC", decimals: 8, amount: 0.0012)
//        let tradeOrder = TradeOrder(tradeSize: tradeSize,
//                                    limitPrice: 0.00238351)
//
//        self.client.cryptoMarketController.send(buyOrder: tradeOrder, forCrypto: "NEO") { (result) in
//            switch result {
//            case .success(let order):
//                print(String(describing: order))
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        
//        let tradeSize = BigMoney(currency: "NEO", decimals: 8, amount: 0.5)
//        let tradeOrder = TradeOrder(tradeSize: tradeSize,
//                                    limitPrice: 0.00233011)
//
//        self.client.cryptoMarketController.send(sellOrder: tradeOrder, forCrypto: "NEO") { (result) in
//            switch result {
//            case .success(let order):
//                print(String(describing: order))
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
//        self.client.cryptoMarketController.cancel(order: "----", forCrypto: "NEO") { (result) in
//            switch result {
//            case .success(let order):
//                print(String(describing: order))
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

extension ViewController: CryptoMarketObserver {
    func cryptoMarketController(_ controller: CryptoMarketController, didUpdatePriceOfCryptoMarket cryptoMarket: CryptoMarketQuoteUpdate) {
        print(String(describing: cryptoMarket))
    }
}
