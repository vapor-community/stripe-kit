//
//  StripeExpandable.swift
//  
//
//  Created by Andrew Edwards on 4/11/20.
//

import Foundation

@propertyWrapper
public class Expandable<Model: StripeModel>: StripeModel {
    
    private enum ExpandableState {
        case unexpanded(String)
        case expanded(Model)
    }
    
    required public init(from decoder: Decoder) throws {
        do {
            _state = try .unexpanded(String(from: decoder))
        } catch DecodingError.typeMismatch(_, _) {
            _state = try .expanded(Model(from: decoder))
        } catch {
            throw error
        }
    }
    
    private var _state: ExpandableState
    
    public func encode(to encoder: Encoder) throws {
        switch _state {
        case let .unexpanded(id):
            try id.encode(to: encoder)
        case let .expanded(model):
            try model.encode(to: encoder)
        }
    }
    
    public var wrappedValue: String? {
        switch _state {
        case .unexpanded(let id):
            return id
        case .expanded(_):
            return nil
        }
    }
        
    public var projectedValue: Model? {
        switch _state {
        case .unexpanded(_):
            return nil
        case .expanded(let model):
            return model
        }
    }
}
