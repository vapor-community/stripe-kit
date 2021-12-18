//
//  StripeExpandable.swift
//  
//
//  Created by Andrew Edwards on 4/11/20.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode<U>(_ type: ExpandableCollection<U>.Type, forKey key: Self.Key) throws -> ExpandableCollection<U> where U: StripeModel {
       return try decodeIfPresent(type, forKey: key) ?? ExpandableCollection<U>()
    }
    
    public func decode<U>(_ type: Expandable<U>.Type, forKey key: Self.Key) throws -> Expandable<U> where U: StripeModel {
       return try decodeIfPresent(type, forKey: key) ?? Expandable<U>()
    }
    
    public func decode<U,D>(_ type: DynamicExpandable<U,D>.Type, forKey key: Self.Key) throws -> DynamicExpandable<U,D> where U: StripeModel, D: StripeModel {
       return try decodeIfPresent(type, forKey: key) ?? DynamicExpandable<U,D>()
    }
}

@propertyWrapper
public struct Expandable<Model: StripeModel>: StripeModel {
    
    private enum ExpandableState {
        case unexpanded(String)
        indirect case expanded(Model)
        case empty
    }
    
    public init() {
        self._state = .empty
    }
    
    public init(from decoder: Decoder) throws {
        let codingPath = decoder.codingPath
        do {
            let container = try decoder.singleValueContainer()
            do {
                if container.decodeNil() {
                    _state = .empty
                } else {
                    _state = .unexpanded(try container.decode(String.self))
                }
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                _state = .expanded(try container.decode(Model.self))
            }
        } catch DecodingError.keyNotFound(_, let context) where context.codingPath.count == codingPath.count {
            _state = .empty
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

@propertyWrapper
public struct DynamicExpandable<A: StripeModel, B: StripeModel>: StripeModel {
    private enum ExpandableState {
        case unexpanded(String)
        indirect case expanded(StripeModel)
        case empty
    }

    public init() {
        self._state = .empty
    }
    
    public init(from decoder: Decoder) throws {
        let codingPath = decoder.codingPath
        do {
            let container = try decoder.singleValueContainer()
            do {
                if container.decodeNil() {
                    _state = .empty
                } else {
                    _state = .unexpanded(try container.decode(String.self))
                }
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                do {
                    _state = .expanded(try container.decode(A.self))
                } catch { // can't catch a specific error here, any particular B might partially decode as A
                    _state = .expanded(try container.decode(B.self))
                }
            }
        } catch DecodingError.keyNotFound(_, let context) where context.codingPath.count == codingPath.count {
            _state = .empty
        }
    }

    private var _state: ExpandableState

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch _state {
        case let .unexpanded(id):
            try container.encode(id)
        case let .expanded(model):
            if let a = model as? A {
                try container.encode(a)
            } else if let b = model as? B {
                try container.encode(b)
            } else {
                preconditionFailure("Invalid model storage")
            }
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
        
    public var projectedValue: DynamicExpandable<A,B> { self }
    
    public func callAsFunction<T: StripeModel>(as type: T.Type) -> T? {
        switch _state {
        case .unexpanded(_), .empty:
            return nil
        case .expanded(let model):
            if let model = model as? T {
                return model
            } else {
                return nil
            }
        }
    }
}

@propertyWrapper
public struct ExpandableCollection<Model: StripeModel>: StripeModel {
    private enum ExpandableState {
        case unexpanded([String])
        indirect case expanded([Model])
        case empty
    }

    public init() {
        self._state = .empty
    }
    
    public init(from decoder: Decoder) throws {
        let codingPath = decoder.codingPath
        do {
            let container = try decoder.singleValueContainer()
            do {
                if container.decodeNil() {
                    _state = .empty
                } else {
                    _state = .unexpanded(try container.decode([String].self))
                }
            } catch DecodingError.typeMismatch(let type, _) where type is String.Type {
                _state = .expanded(try container.decode([Model].self))
            }
        } catch DecodingError.keyNotFound(_, let context) where context.codingPath.count == codingPath.count {
            _state = .empty
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
