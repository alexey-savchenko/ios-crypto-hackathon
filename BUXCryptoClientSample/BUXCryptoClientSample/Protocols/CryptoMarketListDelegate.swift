//
//  CryptoMarketListDelegate.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient

protocol CryptomarketListDelegate: class {
  
  func goToProfile()
  
  func didSelectMarketInList(_ market: CryptoMarket)
  
}
