//
//  MarketListCell.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit

class MarketListCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var askLabel: UILabel!
  @IBOutlet weak var bidLabel: UILabel!
  
  @IBOutlet weak var bestAskLabel: UILabel!
  @IBOutlet weak var bestBidLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  
  
}
