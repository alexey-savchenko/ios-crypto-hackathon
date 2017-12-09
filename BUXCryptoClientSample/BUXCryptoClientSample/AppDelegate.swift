//
//  AppDelegate.swift
//  BUXCryptoClientSample
//
//  Created by Ian Guedes Maia on 10/11/2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var appCoordinator: Coordinator!
  
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    appCoordinator = AppCoordinator(window: window!)
    appCoordinator.start()
    
    return true
  }
  

}

