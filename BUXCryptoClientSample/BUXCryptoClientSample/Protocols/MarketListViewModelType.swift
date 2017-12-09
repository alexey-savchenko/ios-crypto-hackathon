//
//  MarketListViewModelType.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient


protocol MarketListViewModelType: DataFetcher {
  
  var cryptoMarketCount: Int { get }
  
  func configureCell(_ cell: MarketListCell, indexPath: IndexPath)
  
  func start()
  
  var managedList: CryptomarketList? { get set }
  
}
