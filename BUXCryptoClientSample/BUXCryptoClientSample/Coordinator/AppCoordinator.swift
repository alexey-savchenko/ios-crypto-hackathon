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
    
    if let vc = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
  }
  
  func didSelectMarketInList(_ market: CryptoMarket) {
      print(market)
  }
  
}
