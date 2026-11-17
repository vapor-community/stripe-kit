//
//  StripeExpandable.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import Foundation

// MARK: - Decoder Helpers

extension KeyedDecodingContainer {
    public func decode<U>(_ type: ExpandableCollection<U>.Type, forKey key: Self.Key) throws -> ExpandableCollection<U> where U: Codable & Sendable {
       return try decodeIfPresent(type, forKey: key) ?? ExpandableCollection<U>()
    }
    
    public func decode<U>(_ type: Expandable<U>.Type, forKey key: Self.Key) throws -> Expandable<U> where U: Codable & Sendable {
       return try decodeIfPresent(type, forKey: key) ?? Expandable<U>()
    }
}

// MARK: - @Expandable<T>
// Decodes a field that is either a string ID or a fully expanded Codable object.
// wrappedValue → String? (the ID)
// projectedValue ($prop) → T? (the expanded object)

@propertyWrapper
public struct Expandable<Model: Codable & Sendable>: Codable, Sendable {
    
    private enum ExpandableState: Sendable {
        case unexpanded(String)
        indirect case expanded(Model)
        case empty
    }
    
    public init(model: Model) {
        self._state = .expanded(model)
    }
    
    public init(id: String?) {
        if let id {
            self._state = .unexpanded(id)
        } else {
            self._state = .empty
        }
    }
    
    public init() {
        self._state = .empty
    }
    
    public init(from decoder: Decoder) throws {
        if let container = try decoder.singleValueContainerIfPresentAndNotNull() {
            do {
                self._state = .unexpanded(try container.decode(String.self))
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                self._state = .expanded(try container.decode(Model.self))
            }
        } else {
            self._state = .empty
        }
    }
    
    private var _state: ExpandableState
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch _state {
        case let .unexpanded(id):
            try container.encode(id)
        case let .expanded(model):
            try container.encode(model)
        default:
            try container.encodeNil()
        }
    }
    
    public var wrappedValue: String? {
        switch _state {
        case .unexpanded(let id):
            return id
        case .expanded(_), .empty:
            return nil
        }
    }
        
    public var projectedValue: Model? {
        switch _state {
        case .unexpanded(_), .empty:
            return nil
        case .expanded(let model):
            return model
        }
    }
}

// MARK: - @ExpandableCollection<T>
// For array fields where elements are either string IDs or expanded objects.
// wrappedValue → [String]? (the IDs)
// projectedValue ($prop) → [T]? (the expanded objects)

@propertyWrapper
public struct ExpandableCollection<Model: Codable & Sendable>: Codable, Sendable {
    private enum ExpandableState: Sendable {
        case unexpanded([String])
        indirect case expanded([Model])
        case empty
    }

    public init() {
        self._state = .empty
    }
    
    public init(ids: [String]?) {
        if let ids {
            self._state = .unexpanded(ids)
        } else {
            self._state = .empty
        }
    }
    
    public init(models: [Model]?) {
        if let models {
            self._state = .expanded(models)
        } else {
            self._state = .empty
        }
    }
    
    public init(from decoder: Decoder) throws {
        if let container = try decoder.singleValueContainerIfPresentAndNotNull() {
            do {
                self._state = .unexpanded(try container.decode([String].self))
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                self._state = .expanded(try container.decode([Model].self))
            }
        } else {
            self._state = .empty
        }
    }
    
    private var _state: ExpandableState
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch _state {
        case let .unexpanded(ids):
            try container.encode(ids)
        case let .expanded(models):
            try container.encode(models)
        default:
            try container.encodeNil()
        }
    }
    
    public var wrappedValue: [String]? {
        switch _state {
        case .unexpanded(let ids):
            return ids
        case .expanded(_), .empty:
            return nil
        }
    }
        
    public var projectedValue: [Model]? {
        switch _state {
        case .unexpanded(_), .empty:
            return nil
        case .expanded(let models):
            return models
        }
    }
}

// MARK: - Decoder Helper

internal extension Decoder {
    func singleValueContainerIfPresentAndNotNull() throws -> SingleValueDecodingContainer? {
        do {
            let container = try self.singleValueContainer()
            if container.decodeNil() {
                return nil
            }
            return container
        }
        catch DecodingError.keyNotFound(_, let context)
            where context.codingPath.count == self.codingPath.count
        {
            return nil
        }
    }
}