//
//  CryptoMarketList.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import UIKit

protocol CryptomarketList: class {
  
  var marketListTableView: UITableView { get set }
  
  func commitUpdateAt(_ indexPath: IndexPath)
  
}
