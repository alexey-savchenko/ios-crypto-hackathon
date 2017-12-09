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
  
  func startObservation() {
    guard !cryptoMarkets.isEmpty else { return }
    
    self.client.cryptoMarketController.setObserver(self, forCryptos: cryptoMarkets)
    
  }
  
  func endObservation() {
    self.client.cryptoMarketController.removeObserver()
    
  }
  
  
  private lazy var client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: Store.token)
  
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
        
        self.cryptoMarkets = list

        self.startObservation()
        
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
    cell.askLabel.text = "Ask \(cellViewModels[indexPath.row].currentAsk)"
    
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
    
    if let cellViewModelIndex = cellViewModels.index(where: { $0.name == cryptoMarket.marketName }) {
      
      cellViewModels[cellViewModelIndex].updateWith(update: cryptoMarket)
  
      self.managedList?.commitUpdateAt(.init(row: cellViewModelIndex, section: 0))
    
    }
    
  }
  
}
