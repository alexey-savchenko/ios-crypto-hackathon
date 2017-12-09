//
//  AccountCoordinator.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import UIKit


class AccountCoordinator: Coordinator, AccountFlowDelegate {
  
  var childCoordinators = [Coordinator]()
  
  weak var coordinatorDelegate: AccountCoordinatorDelegate?
  
  func start() {
    
    if let accountVC = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AccountVC") as? AccountVC {
      
      let viewModel = ProfileViewModel()
      viewModel.updateDelegate = accountVC
      accountVC.viewModel = viewModel
      accountVC.flowDelegate = self
      
      navigationController.viewControllers = [accountVC]
      
    }
    
  }
  
  var rootViewController: UIViewController {
    return self.navigationController
  }
  
  private lazy var navigationController: UINavigationController = {
    let navigationController = UINavigationController()
    return navigationController
  }()
  
  func dissmisAcountFlow() {
    coordinatorDelegate?.dissmisAccountFlow(self)
  }
  
}
