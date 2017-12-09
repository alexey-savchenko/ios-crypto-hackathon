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
  
  
  private let accessToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJyZWZyZXNoYWJsZSI6ZmFsc2UsInN1YiI6ImQ4ZTg3NWNjLTI0OTctNDQ4Mi05MTkxLWM1OTk4ZWUwYTQxZCIsImF1ZCI6ImRldi5nZXRidXguY29tIiwic2NwIjpbImNyeXB0bzpsb2dpbiIsImNyeXB0bzphZG1pbiJdLCJleHAiOjE1NDQxOTU5ODksImlhdCI6MTUxMjYzOTA2MywianRpIjoiNWY1MGY2ODctM2RjMS00YTE5LWFhZmEtMjM5NzIwMjZlMTBjIiwiY2lkIjoiODQ3MzYyMzgwNCJ9.IWGfd7tH_zVjhdQ_loUP349lbtpP33FCBPK3NBVBCK8"
  
  private lazy var client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: self.accessToken)
  
  
  var viewModel: ProfileViewModelType!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.title = "Profile"

    
    
    
//    self.client.cryptoMarketController.fetchUserAccount { [weak self] (result) in
//      switch result {
//      case .success(let account):
//
//        print(account)
//
//      case .failure(let error):
//        print(error.localizedDescription)
//      }
//    }
  }
  
  
}
