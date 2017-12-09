//
//  MarketListVC.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import UIKit
import BUXCryptoClient

class MarketListVC: UIViewController, CryptomarketList {
  
  var viewModel: MarketListViewModelType!
  
  init(viewModel: MarketListViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var marketListTableView = UITableView()
  
  
  //  private let accessToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJyZWZyZXNoYWJsZSI6ZmFsc2UsInN1YiI6ImQ4ZTg3NWNjLTI0OTctNDQ4Mi05MTkxLWM1OTk4ZWUwYTQxZCIsImF1ZCI6ImRldi5nZXRidXguY29tIiwic2NwIjpbImNyeXB0bzpsb2dpbiIsImNyeXB0bzphZG1pbiJdLCJleHAiOjE1NDQxOTU5ODksImlhdCI6MTUxMjYzOTA2MywianRpIjoiNWY1MGY2ODctM2RjMS00YTE5LWFhZmEtMjM5NzIwMjZlMTBjIiwiY2lkIjoiODQ3MzYyMzgwNCJ9.IWGfd7tH_zVjhdQ_loUP349lbtpP33FCBPK3NBVBCK8"
  //
  //  private lazy var client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: self.accessToken)
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    view.backgroundColor = .white
    setUp()
    
    viewModel.start()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    self.client.connectToRealtimeFeed()
    //
    //    self.client.cryptoMarketController.fetchCryptoMarkets { [weak self] (result) in
    //      guard let `self` = self else { return }
    //
    //      switch result {
    //      case .success(let list):
    //        print(String(describing: list))
    //        self.client.cryptoMarketController.setObserver(self, forCryptos: list)
    //      case .failure(let error):
    //        print(error.localizedDescription)
    //      }
    //    }
    
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
  
  private func setUp() {
    
    marketListTableView.delegate = self
    marketListTableView.dataSource = self
    
    marketListTableView.register(UINib.init(nibName: "MarketListCell", bundle: nil), forCellReuseIdentifier: "MarketListCell")
    
    view.addSubview(marketListTableView)
    marketListTableView.translatesAutoresizingMaskIntoConstraints = false
    
    let safeArea = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([marketListTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                 marketListTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                 marketListTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                                 marketListTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
    
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}

extension MarketListVC: UITableViewDataSource, UITableViewDelegate {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//    return viewModel?.cryptoMarketCount ?? 0
    return 10
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MarketListCell", for: indexPath) as! MarketListCell
    viewModel.configureCell(cell, indexPath: indexPath)
    return cell
    
  }
  
  
}

