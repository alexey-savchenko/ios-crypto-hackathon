//
//  TransactionsViewModelType.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation

protocol TransactionsViewModelType: class {
  
  var transactionsCount: Int { get }
  
  func configureCell(_ cell: TransactionListCell, indexPath: IndexPath)
  
}
