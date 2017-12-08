//
//  BUXHTTPService.swift
//  BUXCryptoClient
//
//  Created by Evgeny Shurakov on 17/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation
import HTTPClient

final class BUXHTTPService {
    enum Error: BUXError {
        case notFound
        case forbidden
        case unauthorized
        case bux(APIError)
        
        var localizedDescription: String {
            switch self {
            case .bux(let apiError):
                return apiError.developerMessage ?? ""
            case .notFound:
                return "Not Found"
            case .unauthorized:
                return "Unauthorized"
            case .forbidden:
                return "Forbidden"
            }
            
        }
        
        var localizedFailureReason: String? {
            return nil
        }
    }
    
    private let httpClient: HTTPClient
    private let errorHandler: BUXErrorHandler?
    
    init(httpClient: HTTPClient, errorHandler: BUXErrorHandler? = nil) {
        self.httpClient = httpClient
        self.errorHandler = errorHandler
    }
    
    func execute<T: Query>(_ query: T, completion: @escaping (QueryResult<T.CreatorType.StrongType>) -> Void) {
        
        let request: HTTPRequest
        do {
            request = try query.request()
        } catch {
            completion(.failure(error))
            return
        }
        
        self.httpClient.execute(request) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let response):
                do {
                    if let error = try strongSelf.error(from: response) {
                        strongSelf.errorHandler?.handle(error: error)
                        completion(.failure(error))
                    } else {
                        let jsonObject = try JSONSerialization.jsonObject(with: response.data, options: [])
                        let result = try T.CreatorType.fromAny(jsonObject)
                        completion(.success(result))
                    }
                } catch {
                    completion(.failure(error))
                } 
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func execute<T: Query>(_ query: T, completion: @escaping (Swift.Error?) -> Void) where T.CreatorType.StrongType == Void {
        let request: HTTPRequest
        do {
            request = try query.request()
        } catch {
            completion(error)
            return
        }
        
        self.httpClient.execute(request) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let response):
                do {
                    if let error = try strongSelf.error(from: response) {
                        strongSelf.errorHandler?.handle(error: error)
                        completion(error)
                    } else {
                        completion(nil)
                    }
                } catch {
                    completion(error)
                }
                
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func error(from response: HTTPResponse) throws -> Error? {
        switch response.statusCode {
        case 200..<300:
            return nil
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        default:
            let jsonObject = try JSONSerialization.jsonObject(with: response.data, options: [])
            let apiError = try APIErrorCreator.fromAny(jsonObject)
            return .bux(apiError)
        }
    }
}
