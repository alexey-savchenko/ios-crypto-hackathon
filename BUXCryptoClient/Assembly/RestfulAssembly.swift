//
//  RestfulAssembly.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 23/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import HTTPClient
import Log

extension Log: HTTPLoggerEngine {
    
}

final class RestfulAssembly {
    fileprivate let networkAuthAssembly: NetworkAuthAssemblyProtocol
    fileprivate let errorHandler: BUXErrorHandler?
    fileprivate let logger: Log?
    fileprivate let environment: BUXCryptoClient.Environment
    
    init(environment: BUXCryptoClient.Environment, networkAuthAssembly: NetworkAuthAssemblyProtocol, errorHandler: BUXErrorHandler?, logger: Log?) {
        self.environment = environment
        self.networkAuthAssembly = networkAuthAssembly
        self.errorHandler = errorHandler
        self.logger = logger
    }
    
    // MARK: - HTTP
    
    lazy var httpService: BUXHTTPService = { [unowned self] in
        return BUXHTTPService(httpClient: self.httpClient, errorHandler: self.errorHandler)
    }()
    
    private lazy var httpClient: HTTPClient = { [unowned self] in
        let requestTransformer = self.requestTransformer()
        requestTransformer.requestPreProcessor = self.networkAuthAssembly.authenticator
        
        return DefaultHTTPClient(session: self.httpSession(), requestTransformer: requestTransformer)
    }()
    
    private func httpLogger() -> HTTPLogger? {
        guard let logger = self.logger?.subloggerWithTag(tag: "HTTP") else {
            return nil
        }
        
        return HTTPDevLogger(logger: logger)
    }
    
    private func httpSession() -> HTTPSession {
        let sessionFactory = HTTPNSURLSessionFactory(configuration: URLSessionConfiguration.default)
        let session = DefaultHTTPSession(sessionFactory: sessionFactory)
        session.logger = self.httpLogger()
        
        return session
    }
    
    private func requestTransformer() -> HTTPRequestTransformer {
        let requestTransformer = HTTPRequestTransformer()
        requestTransformer.baseURL = self.environment.appURL
        return requestTransformer
    }
    
}

