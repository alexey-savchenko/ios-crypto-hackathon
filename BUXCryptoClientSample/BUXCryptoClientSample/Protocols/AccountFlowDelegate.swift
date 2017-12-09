//
//  AccountFlowDelegate.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient

protocol AccountFlowDelegate: class {
  
  func dissmisAcountFlow()
  func showTransactions(_ transactions: [Transaction])
  func showOrders(_ orders: [Order])
  
}
