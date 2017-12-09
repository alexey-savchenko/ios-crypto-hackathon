//
//  AppCoordinator.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import UIKit
import BUXCryptoClient

class AppCoordinator: Coordinator {

  // MARK: - Properties
  
  var childCoordinators = [Coordinator]()
  
  var rootViewController: UIViewController {
    return self.navigationController
  }
  
  /// Window to manage
  let window: UIWindow
  
  private lazy var navigationController: UINavigationController = {
    let navigationController = UINavigationController()
    return navigationController
  }()
  
  // MARK: - Init
  public init(window: UIWindow) {
    self.window = window
    
    self.window.rootViewController = self.rootViewController
    self.window.makeKeyAndVisible()
  }
  
  // MARK: - Functions
  
  /// Starts the coordinator
  public func start() {
    
    let vm = MarketListViewModel()
    let vc = MarketListVC(viewModel: vm)
    vm.managedList = vc
    vc.delegate = self
    
    navigationController.viewControllers = [vc]
    
  }
  
}

extension AppCoordinator: CryptomarketListDelegate {
  
  func goToProfile() {
    
    let accountCoordinator = AccountCoordinator()
    
    accountCoordinator.coordinatorDelegate = self
    
    addChildCoordinator(accountCoordinator)
    
    accountCoordinator.start()
    
    rootViewController.present(accountCoordinator.rootViewController, animated: true, completion: nil)
    
  }
  
  func didSelectMarketInList(_ market: CryptoMarket) {
    print(market)
  }
  
}

extension AppCoordinator: AccountCoordinatorDelegate {
  
  func dissmisAccountFlow(_ coordinator: Coordinator) {
    
    coordinator.rootViewController.dismiss(animated: true, completion: nil)
    removeChildCoordinator(coordinator)
  
  }
  
}
