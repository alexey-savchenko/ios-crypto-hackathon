//
//  TransactionListCell.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit
import BUXCryptoClient
class TransactionListCell: UITableViewCell {
  
  @IBOutlet weak var transactionTypeLabel: UILabel!
  @IBOutlet weak var transactionIDLabel: UILabel!
  @IBOutlet weak var transactionDescriptionLabel: UILabel!
  @IBOutlet weak var transactionAmountLabel: UILabel!
  @IBOutlet weak var transactionTimestamp: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func configureCell(_ transaction: Transaction) {
    transactionTypeLabel.text = transaction.type.rawValue
    transactionDescriptionLabel.text = transaction.description
    transactionIDLabel.text = transaction.identifier
    transactionAmountLabel.text = "\(transaction.amount.amount) \(transaction.amount.currency)"
    transactionTimestamp.text = transaction.dateCreated.timeAgoSinceNow()
  }
  
}
