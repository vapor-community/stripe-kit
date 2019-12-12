//
//  StripeIdentifiable.swift
//  Stripe
//
//  Created by Alessio Buratti on 12.12.19.
//
//

import NIO

public protocol StripeExpandable: StripeModel {
    var id: String { get }
}

extension StripeCustomer: StripeExpandable { }

extension StripeCard: StripeExpandable { }


@propertyWrapper
public struct Expandable<Model: StripeExpandable>: StripeModel {
    
    private enum ExpandableState {
        case unexpanded(String)
        case expanded(Model)
    }
    
    private var _state: ExpandableState
    
    public var id: String {
        switch _state {
        case let .unexpanded(id):
            return id
        case let .expanded(model):
            return model.id
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch _state {
        case let .unexpanded(id):
            try id.encode(to: encoder)
        case let .expanded(model):
            try model.encode(to: encoder)
        }
    }
    
    public init(from decoder: Decoder) throws {
        do {
            _state = try .unexpanded(String(from: decoder))
        } catch DecodingError.typeMismatch(_, _) {
            _state = try .expanded(Model(from: decoder))
        } catch {
            throw error
        }
    }
    
    public var wrappedValue: Model? {
        switch _state {
        case .unexpanded(_):
            return nil
        case let .expanded(model):
            return model
        }
    }
    
    public var projectedValue: Expandable<Model> {
        self
    }
}
