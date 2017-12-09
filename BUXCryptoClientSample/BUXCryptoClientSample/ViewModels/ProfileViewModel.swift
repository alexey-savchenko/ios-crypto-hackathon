//
//  ProfileViewModel.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import BUXCryptoClient

class ProfileViewModel: ProfileViewModelType {
  
  private lazy var client: BUXCryptoClient = BUXCryptoClientBuilder(environment: .development).build(withAccessToken: Store.token)
  
  weak var updateDelegate: ProfileUpdateDelegate?
  
  func start() {
    
    self.client.cryptoMarketController.fetchUserAccount { [weak self] (result) in
      guard let `self` = self else { return }
      
      switch result {
      case .success(let account):
        
        self.updateDelegate?.didReceiveProfileData(account)
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
  }
  
  
  deinit {
    print("\(self) dealloc")
  }
  
}
