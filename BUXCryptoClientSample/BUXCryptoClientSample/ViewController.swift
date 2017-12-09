//
//  ViewController.swift
//  BUXCryptoClientSample
//
//  Created by Ian Guedes Maia on 10/11/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit
import BUXCryptoClient

class MarketListVC: UIViewController {
  
  private static let accessToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJyZWZyZXNoYWJsZSI6ZmFsc2UsInN1YiI6ImQ4ZTg3NWNjLTI0OTctNDQ4Mi05MTkxLWM1OTk4ZWUwYTQxZCIsImF1ZCI6ImRldi5nZXRidXguY29tIiwic2NwIjpbImNyeXB0bzpsb2dpbiIsImNyeXB0bzphZG1pbiJdLCJleHAiOjE1NDQxOTU5ODksImlhdCI6MTUxMjYzOTA2MywianRpIjoiNWY1MGY2ODctM2RjMS00YTE5LWFhZmEtMjM5NzIwMjZlMTBjIiwiY2lkIjoiODQ3MzYyMzgwNCJ9.IWGfd7tH_zVjhdQ_loUP349lbtpP33FCBPK3NBVBCK8"
  
  private let client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development)
    .build(withAccessToken: MarketListVC.accessToken)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("!")
    
    //    self.client.connectToRealtimeFeed()
    
    self.client.cryptoMarketController.fetchCryptoMarkets { [weak self] (result) in
      guard let `self` = self else { return }
      
      switch result {
      case let .success(list):
        
        print("________________")
        
        for item in list {
          print(item)
        }
        
        print("________________")
        
        self.client.cryptoMarketController.setObserver(self, forCryptos: list)
//        self.client.cryptoMarketController.removeObserver()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    //            self.client.cryptoMarketController.fetchUserAccount { [weak self] (result) in
    //                switch result {
    //                case .success(let account):
    //                    print(account)
    //
    //                  account.baseBalance.reservedAmount
    //                case .failure(let error):
    //                    print(error.localizedDescription)
    //                }
    //            }
    
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

extension MarketListVC: CryptoMarketObserver {
  func cryptoMarketController(_ controller: CryptoMarketController, didUpdatePriceOfCryptoMarket cryptoMarket: CryptoMarketQuoteUpdate) {
    print(String(describing: cryptoMarket))
  }
}
