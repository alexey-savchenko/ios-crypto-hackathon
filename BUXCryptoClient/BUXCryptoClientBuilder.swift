//
//  BUXCryptoClientBuilder.swift
//  //  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 27/05/16.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import Log

public final class BUXCryptoClientBuilder {
    public enum Result {
        case success(BUXCryptoClient)
        case failure(Swift.Error)
    }
    
    public enum Error: Swift.Error {
        case persisterIsNotSet
        case persistedDataIsCorrupted
    }
    
    public var logger: Log?

    private let environment: BUXCryptoClient.Environment
    private let persister: BUXCryptoClientPersister?
    
    private var tmpAssembly: AnonymousAssembly?
    
    public init(environment: BUXCryptoClient.Environment, persister: BUXCryptoClientPersister? = nil) {
        self.environment = environment
        self.persister = persister
    }
    
    public func restore(completion: @escaping (Result) -> Void) {
        guard let persister = self.persister else {
            completion(.failure(Error.persisterIsNotSet))
            return
        }
        
        do {
            let data = try persister.retrive()
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let persistedData = try APIClientPersistedDataCreator.fromAny(jsonObject)
                
                completion(.success(self.build(withServiceCredentials: persistedData.credentials)))
            } catch {
                completion(.failure(Error.persistedDataIsCorrupted))
            }
            
        } catch {
            completion(.failure(error))
        }
    }
    
    public func build(withEmail email: String, password: String, clientToken: String, completion: @escaping (Result) -> Void) {
        let serviceCredentials = ServiceCredentials(type: "Basic", token: clientToken)
        let assembly = AnonymousAssembly(environment: self.environment, credentials: serviceCredentials, logger: self.logger)
        self.tmpAssembly = assembly
        
        assembly.restful.httpService.execute(LoginQuery(credentials: EmailCredentials(emailAddress: email, password: password))) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.tmpAssembly = nil
            
            switch result {
            case .success(let serviceCredentials):
                strongSelf.persist(credentials: serviceCredentials)
                completion(.success(strongSelf.build(withServiceCredentials: serviceCredentials)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    public func build(withAccessToken accessToken: String) -> BUXCryptoClient {
        let credentials = ServiceCredentials(type: "Bearer", token: accessToken)
        self.persist(credentials: credentials)
        return self.build(withServiceCredentials: credentials)
    }

    private func build(withServiceCredentials serviceCredentials: ServiceCredentials) -> BUXCryptoClient {
        let assembly = Assembly(environment: self.environment, credentials: serviceCredentials, logger: self.logger)
        return BUXCryptoClient(assembly: assembly)
    }
    
    private func persist(credentials: ServiceCredentials) {
        guard let persister = self.persister else { return }
        
        let apiClientData = APIClientPersistedDataCreator.toRaw(from: APIClientPersistedData(credentials: credentials))
        do {
            let data = try JSONSerialization.data(withJSONObject: apiClientData, options: [])
            persister.store(data: data)
        } catch {
            self.logger?.e("\(error)")
        }
    }
}
