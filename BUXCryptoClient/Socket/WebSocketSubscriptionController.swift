//
//  WebSocketSubscriptionController.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 17.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

class WebSocketSubscriptionController {
    private let webSocketController: WebSocketController
    fileprivate var channels: [WebSocketChannel: Int] = [:]
    
    init(webSocketController: WebSocketController) {
        self.webSocketController = webSocketController
        self.webSocketController.addObserver(self)
    }
    
    deinit {
        self.webSocketController.removeObserver(self)
    }
    
    func subscribe(_ subscribe: Set<WebSocketChannel>, unsubscribe: Set<WebSocketChannel>) {
        precondition(subscribe.isDisjoint(with: unsubscribe), "Cannot subscribe (\(subscribe)) and unsubscribe (\(unsubscribe)) to the same channels")
        
        var channelsToSubscribe: [WebSocketChannel] = []
        var channelsToUnsubscribe: [WebSocketChannel] = []
        
        for channel in subscribe {
            if let subscribersCount = self.channels[channel] {
                self.channels[channel] = subscribersCount + 1
            } else {
                self.channels[channel] = 1
                channelsToSubscribe.append(channel)
            }
        }
        
        for channel in unsubscribe {
            if let subscribersCount = self.channels[channel] {
                if subscribersCount < 2 {
                    self.channels.removeValue(forKey: channel)
                    channelsToUnsubscribe.append(channel)
                } else {
                    self.channels[channel] = subscribersCount - 1
                }
            }
        }
        
        if channelsToSubscribe.count > 0 || channelsToUnsubscribe.count > 0 {
            self.send(WebSocketSubscriptionMessage(subscribeTo: channelsToSubscribe, unsubscribeFrom: channelsToUnsubscribe))
        }
    }
    
    fileprivate func send(_ message: WebSocketSubscriptionMessage) {
        do {
            try self.webSocketController.send(WebSocketSubscriptionMessageCreator.toRaw(from: message))
        } catch {
            // TODO: handle error
            print(error)
        }
    }
}

extension WebSocketSubscriptionController: WebSocketControllerObserver {
    func webSocketControllerDidConnect(_ controller: WebSocketController) {
        if self.channels.count == 0 {
            return
        }
        
        self.send(WebSocketSubscriptionMessage(subscribeTo: Array(self.channels.keys), unsubscribeFrom: []))
    }
    
    func webSocketController(_ controller: WebSocketController, didDisconnectWithError error: Error?) {
        
    }
}
