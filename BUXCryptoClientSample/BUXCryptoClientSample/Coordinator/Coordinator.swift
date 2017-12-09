//
//  Coordinator.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
  
  var rootViewController: UIViewController { get }
  var childCoordinators: [Coordinator] { get set }
  func start()
  
}

extension Coordinator {
  func addChildCoordinator(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  func removeChildCoordinator(_ coordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
  }
}
