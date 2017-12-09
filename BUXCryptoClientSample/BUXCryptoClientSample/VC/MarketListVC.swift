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
  
  var marketListTableView = UITableView()
  
  var viewModel: MarketListViewModelType!
  
  weak var delegate: CryptomarketListDelegate?
  
  init(viewModel: MarketListViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @objc func profileItemTap(_ sender: UIBarButtonItem){
    delegate?.goToProfile()
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    navigationItem.title = "Market List"
    
    view.backgroundColor = .white
    
    listSetUp()
    
    viewModel.start()
    
    let profileItem = UIBarButtonItem(title: "Profile",
                                      style: .plain,
                                      target: self,
                                      action: #selector(profileItemTap(_:)))
    
    navigationItem.rightBarButtonItems = [profileItem]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    
//            self.client.cryptoMarketController.fetchUserAccount { [weak self] (result) in
//                switch result {
//                case .success(let account):
//                    print(account)
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
  
  private func listSetUp() {
    
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
  
  func commitUpdateAt(_ indexPath: IndexPath) {
    
    marketListTableView.beginUpdates()
    
    marketListTableView.reloadRows(at: [indexPath], with: .fade)
    
    marketListTableView.endUpdates()
    
  }
  
  deinit {
    print("\(self) dealloc")
  }
  
}

extension MarketListVC: UITableViewDataSource, UITableViewDelegate {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cryptoMarketCount
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MarketListCell", for: indexPath) as! MarketListCell
    
    viewModel.configureCell(cell, indexPath: indexPath)
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
  
  
}

