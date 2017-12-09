//
//  TransactionsViewModel.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient

class TransactionsViewModel: TransactionsViewModelType {
  
  var transactionsCount: Int {
    return transactions.count
  }
  
  private var transactions = [Transaction]()
  
  init(with transactions: [Transaction]) {
    self.transactions = transactions
  }
  
  func configureCell(_ cell: TransactionListCell, indexPath: IndexPath) {
    guard indexPath.row <= transactionsCount else { return }
    
    cell.transactionTypeLabel.text = transactions[indexPath.row].type.rawValue
    cell.transactionDescriptionLabel.text = transactions[indexPath.row].description
    cell.transactionIDLabel.text = transactions[indexPath.row].identifier
    cell.transactionAmountLabel.text = "\(transactions[indexPath.row].amount.amount) \(transactions[indexPath.row].amount.currency)"
    cell.transactionTimestamp.text = transactions[indexPath.row].dateCreated.timeAgoSinceNow()
  }

  deinit {
    print("\(self) dealloc")
  }
  
}
