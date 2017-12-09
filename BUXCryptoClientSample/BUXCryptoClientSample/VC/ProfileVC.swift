//
//  ProfileVC.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit
import BUXCryptoClient

class ProfileVC: UIViewController {
  
  private lazy var client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: Store.token)
  
  @IBOutlet weak var baseCurrencyValueLabel: UILabel!
  @IBOutlet weak var baseCurrencyNameLabel: UILabel!
  
  @IBOutlet weak var quoteCurrencyValueLabel: UILabel!
  @IBOutlet weak var quoteCurrencyNameLabel: UILabel!
  
  var viewModel: ProfileViewModelType!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.title = "Profile"
    
    viewModel.start()
    
  }
  
  @IBAction func pastTransactionsButtonTap(_ sender: UIButton) {
    
    
  }
  
  @IBAction func ordersButtonTap(_ sender: UIButton) {
    
    
    
  }
  
  
  
  
  deinit {
    print("\(self) dealloc")
  }
  
}

extension ProfileVC: ProfileUpdateDelegate {
  
  func didReceiveProfileData(_ data: Account) {
    
    print(data)
    
    baseCurrencyNameLabel.text = data.baseBalance.quantity.currency
    baseCurrencyValueLabel.text = "\(data.baseBalance.quantity.amount)"
    
    quoteCurrencyNameLabel.text = data.baseBalance.currentValue.currency
    quoteCurrencyValueLabel.text = "\(data.baseBalance.currentValue.amount)"
    
  }
  
}
