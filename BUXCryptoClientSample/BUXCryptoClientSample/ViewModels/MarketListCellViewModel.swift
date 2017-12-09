//
//  MarketListCellViewModel.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient

struct MarketListCellViewModel {
  
  let name: String
  
  let bestAsk: Decimal
  let bestBid: Decimal
  
  var currentAsk: Decimal = 0.00000000
  var currentBid: Decimal = 0.00000000
  
  init(with market: CryptoMarket) {
    
    self.name = market.name
    self.bestAsk = market.bestAsk
    self.bestBid = market.bestBid
    
  }
  
  mutating func updateWith(update: CryptoMarketQuoteUpdate) {
    self.currentAsk = update.ask
    self.currentBid = update.bid
  }
  
}
