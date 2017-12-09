//
//  MarketListViewModel.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient

class MarketListViewModel: MarketListViewModelType {


  private let accessToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJyZWZyZXNoYWJsZSI6ZmFsc2UsInN1YiI6ImQ4ZTg3NWNjLTI0OTctNDQ4Mi05MTkxLWM1OTk4ZWUwYTQxZCIsImF1ZCI6ImRldi5nZXRidXguY29tIiwic2NwIjpbImNyeXB0bzpsb2dpbiIsImNyeXB0bzphZG1pbiJdLCJleHAiOjE1NDQxOTU5ODksImlhdCI6MTUxMjYzOTA2MywianRpIjoiNWY1MGY2ODctM2RjMS00YTE5LWFhZmEtMjM5NzIwMjZlMTBjIiwiY2lkIjoiODQ3MzYyMzgwNCJ9.IWGfd7tH_zVjhdQ_loUP349lbtpP33FCBPK3NBVBCK8"
  
  private lazy var client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: self.accessToken)
  
  private var cryptoMarkets = [CryptoMarket]() {
    didSet {
      cellViewModels = cryptoMarkets.map {MarketListCellViewModel(with: $0)}
    }
  }
  
  private var cellViewModels = [MarketListCellViewModel]()
  
  var cryptoMarketCount: Int { return cryptoMarkets.count }

  weak var managedList: CryptomarketList?
  
  func start() {
    
    self.client.connectToRealtimeFeed()
    self.client.cryptoMarketController.fetchCryptoMarkets { [weak self] (result) in
      
      guard let `self` = self else { return }
      
      switch result {
      case let .success(list):
        
        for item in list {
          print(String(describing: item))
        }
        
        self.cryptoMarkets = list
        self.client.cryptoMarketController.setObserver(self, forCryptos: list)
        self.managedList?.marketListTableView.reloadData()
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
    
  }
  
  
  func configureCell(_ cell: MarketListCell, indexPath: IndexPath) {
    
    guard indexPath.row <= cellViewModels.count - 1 else { return }
    
    cell.nameLabel.text = cellViewModels[indexPath.row].name
    
    cell.bidLabel.text = "Bid \(cellViewModels[indexPath.row].currentBid)"
    cell.askLabel.text = "Bid \(cellViewModels[indexPath.row].currentAsk)"
    
    cell.bestBidLabel.text = "Best bid \(cellViewModels[indexPath.row].bestBid)"
    cell.bestAskLabel.text = "Best ask \(cellViewModels[indexPath.row].bestAsk)"
    
  }

  
  deinit {
    self.client.cryptoMarketController.removeObserver()
    self.client.disconnectFromRealtimeFeed()
    
    print("\(self) dealloc")
  }
  
}

extension MarketListViewModel: CryptoMarketObserver {
  
  
  func cryptoMarketController(_ controller: CryptoMarketController,
                              didUpdatePriceOfCryptoMarket cryptoMarket: CryptoMarketQuoteUpdate) {
    
    print(String(describing: cryptoMarket))
    
    if let cellViewModelIndex = cellViewModels.index(where: { $0.name == cryptoMarket.marketName }) {
      
      cellViewModels[cellViewModelIndex].updateWith(update: cryptoMarket)

      managedList?.commitUpdateAt(.init(row: cellViewModelIndex, section: 0))
      
    }
    
  }
  
}
