//
//  WebSocketControllerImpl.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 15.05.16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import Log

fileprivate protocol DispatchableEventHandler: class {
    func dispatch(_ event: Any)
}

fileprivate final class EventHandler<T>: DispatchableEventHandler {
    let eventClass: T.Type
    let handler: (T) -> Void
    
    init(_ eventClass: T.Type, handler: @escaping (T) -> Void) {
        self.eventClass = eventClass
        self.handler = handler
    }
    
    func dispatch(_ event: Any) {
        if let event = event as? T {
            self.handler(event)
        }
    }
}

fileprivate final class EventHandlerWrapper: WebSocketEventHandler {
    private weak var controller: WebSocketControllerImpl?
    private var eventHandler: DispatchableEventHandler
    
    fileprivate init(controller: WebSocketControllerImpl, eventHandler: DispatchableEventHandler) {
        self.controller = controller
        self.eventHandler = eventHandler
    }
    
    deinit {
        self.controller?.removeEventHandler(self.eventHandler)
    }
}

final class WebSocketControllerImpl: WebSocketController {
    fileprivate final class ObserverWeakContainer {
        weak var obj: WebSocketControllerObserver?
        init(_ obj: WebSocketControllerObserver) {
            self.obj = obj
        }
    }
    
    var logger: Log?
    
    var connected: Bool {
        if let webSocket = self.webSocket {
            return webSocket.connected && self.receivedConnectedMessage
        } else {
            return false
        }
    }
    
    fileprivate var connecting: Bool {
        return self.webSocket != nil && !self.connected
    }
    
    fileprivate var receivedConnectedMessage: Bool = false
    
    fileprivate let webSocketFactory: WebSocketFactory
    fileprivate let eventFactory: WebSocketEventFactory

    fileprivate var observers: [ObserverWeakContainer] = []
    fileprivate var eventHandlers: [DispatchableEventHandler] = []
    
    fileprivate var webSocket: WebSocket?
    
    init(webSocketFactory: WebSocketFactory, eventFactory: WebSocketEventFactory) {
        self.webSocketFactory = webSocketFactory
        self.eventFactory = eventFactory
    }
    
    deinit {
        self.disconnect()
    }
    
    func connect() {
        if self.connected || self.connecting {
            return
        }
        
        self.receivedConnectedMessage = false
        
        self.logger?.d("Connect [0/2]")
        
        var webSocket = self.webSocketFactory.webSocket()
        self.webSocket = webSocket
        
        webSocket.delegate = self
        webSocket.connect()
    }
    
    func disconnect() {
        if self.webSocket == nil {
            return
        }
        
        self.logger?.d("Disconnect")
        
        self.webSocket?.delegate = nil
        self.webSocket?.disconnect()
        self.webSocket = nil
        
        for weakContainer in self.observers {
            weakContainer.obj?.webSocketController(self, didDisconnectWithError: nil)
        }
    }
    
    func send(_ data: [String : Any]) throws {
        try self.send(JSONSerialization.data(withJSONObject: data, options: []))
    }
    
    func send(_ data: Data) throws {
        if !self.connected {
            self.connect()
            // TODO: throw
            return
        }
        
        guard let webSocket = self.webSocket else {
            // TODO: throw
            return
        }
        
        try webSocket.send(data)
    }
    
    func addObserver(_ observer: WebSocketControllerObserver) {
        for weakContainer in self.observers {
            if weakContainer.obj === observer {
                return
            }
        }
        
        self.observers.append(ObserverWeakContainer(observer))
    }
    
    func removeObserver(_ observer: WebSocketControllerObserver) {
        self.observers = self.observers.filter({ (weakContainer) -> Bool in
            weakContainer.obj != nil && weakContainer.obj !== observer
        })
    }
    
    func createEventHandler<T>(for eventType: WebSocketEventDescriptor<T>, handler: @escaping (T.StrongType) -> Void) -> WebSocketEventHandler {
        let eventHandler = EventHandler(T.StrongType.self, handler: handler)
        self.eventHandlers.append(eventHandler)
        
        return EventHandlerWrapper(controller: self, eventHandler: eventHandler)
    }
    
    fileprivate func removeEventHandler(_ eventHandler: DispatchableEventHandler) {
        if let index = self.eventHandlers.index(where: {$0 === eventHandler}) {
            self.eventHandlers.remove(at: index)
        }
    }
}

extension WebSocketControllerImpl: WebSocketDelegate {
    func webSocketDidConnect(_ webSocket: WebSocket) {
        self.logger?.d("Connect [1/2]")
    }
    
    func webSocket(_ webSocket: WebSocket, didDisconnectWithError error: Error?) {
        if let error = error {
            self.logger?.e("Error: \(error)")
        }
        self.disconnect()
    }
    
    func webSocket(_ webSocket: WebSocket, didReceiveMessage message: String) {
        let event: Any
        do {
            event = try self.eventFactory.event(fromJSONString: message)
        } catch {
            // TODO: handle error
            self.logger?.e("\(error)")
            self.logger?.e("\(message)")
            return
        }
        
        self.logger?.d("\(event)")
        
        if event is WebSocketConnectedEvent {
            self.logger?.d("Connect [2/2]")
            
            self.receivedConnectedMessage = true
            
            for weakContainer in self.observers {
                weakContainer.obj?.webSocketControllerDidConnect(self)
            }
        } else if event is WebSocketConnectionFailedEvent {
            self.disconnect()
            return
        }
        
        for eventHandler in self.eventHandlers {
            eventHandler.dispatch(event)
        }
    }
}
