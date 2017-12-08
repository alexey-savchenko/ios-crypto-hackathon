//
//  Creator.swift
//
//  Created by Evgeny Shurakov on 16/11/2016.
//  Copyright © 2016 BUX. All rights reserved.
//

import Foundation

enum CreatorError: LocalizedError, CustomStringConvertible {
    case unacceptableValue
    case missingRequiredValue
    
    case incorrectType(valueType: String, expectedType: String)
    
    case propagation(breadcrumbs: [String], error: Error)
    
    var errorDescription: String? {
        switch self {
        case .unacceptableValue:
            return "Unacceptable value"
        case .missingRequiredValue:
            return "Missing required value"
        case .incorrectType(let valueType, let expectedType):
            return "Expected \(expectedType), but got \(valueType)"
        case .propagation(let breadcrumbs, let error):
            return "\(breadcrumbs.reversed().joined(separator: ".")): \(error.localizedDescription)"
        }
    }
    
    var description: String {
        return self.errorDescription ?? ""
    }
}

protocol Creator {
    associatedtype RawType
    associatedtype StrongType
    
    static func toRaw(from: Self.StrongType) -> Self.RawType
    static func from(_ rawValue: Self.RawType) throws -> Self.StrongType
}

extension Creator {
    
    static func fromAny(_ rawDict: [String: Any], _ key: String) throws -> Self.StrongType {
        return try self.fromAny(rawDict[key], breadcrumb: key)
    }
    
    static func fromAny(_ rawValue: Any?, breadcrumb: @autoclosure () -> String? = nil) throws -> Self.StrongType {
        do {
            guard let typedValue = rawValue as? Self.RawType else {
                if let rawValue = rawValue {
                    throw CreatorError.incorrectType(valueType: String(describing: type(of: rawValue)), expectedType: String(describing: Self.RawType.self))
                } else {
                    throw CreatorError.missingRequiredValue
                }
            }
            
            return try self.from(typedValue)
        } catch CreatorError.propagation(var breadcrumbs, let error) {
            if let breadcrumb = breadcrumb() {
                breadcrumbs.append(breadcrumb)
            }
            throw CreatorError.propagation(breadcrumbs: breadcrumbs, error: error)
        } catch {
            let breadcrumbs: [String]
            if let breadcrumb = breadcrumb() {
                breadcrumbs = [breadcrumb]
            } else {
                breadcrumbs = []
            }
            throw CreatorError.propagation(breadcrumbs: breadcrumbs, error: error)
        }
    }
    
    static func optionalFromAny(_ rawDict: [String: Any], _ key: String) throws -> Self.StrongType? {
        return try self.optionalFromAny(rawDict[key], breadcrumb: key)
    }
    
    static func optionalFromAny(_ rawValue: Any?, breadcrumb: @autoclosure () -> String? = nil) throws -> Self.StrongType? {
        if rawValue == nil {
            return nil
        }
        
        return try self.fromAny(rawValue, breadcrumb: breadcrumb)
    }
}
