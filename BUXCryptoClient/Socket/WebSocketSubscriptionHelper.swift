//
//  WebSocketSubscriptionHelper.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 17.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

class WebSocketSubscriptionHelper {
    private let subscriptionController: WebSocketSubscriptionController
    
    var channels = Set<WebSocketChannel>() {
        didSet {
            let subscribe = self.channels.subtracting(oldValue)
            let unsubscribe = oldValue.subtracting(self.channels)
            
            self.subscriptionController.subscribe(subscribe, unsubscribe: unsubscribe)
        }
    }
    
    init(subscriptionController: WebSocketSubscriptionController) {
        self.subscriptionController = subscriptionController
    }
    
    deinit {
        self.subscriptionController.subscribe(Set<WebSocketChannel>(), unsubscribe: self.channels)
    }
}
