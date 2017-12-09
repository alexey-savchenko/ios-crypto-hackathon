//
//  TransactionListCell.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit

class TransactionListCell: UITableViewCell {
  
  @IBOutlet weak var transactionTypeLabel: UILabel!
  @IBOutlet weak var transactionIDLabel: UILabel!
  @IBOutlet weak var transactionDescriptionLabel: UILabel!
  @IBOutlet weak var transactionAmountLabel: UILabel!
  @IBOutlet weak var transactionTimestamp: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
}
