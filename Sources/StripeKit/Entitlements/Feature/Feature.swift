//
//  Feature..swift
//  stripe-kit
//
//  Created by TelemetryDeck on 25.01.25.
//

import Foundation

/// [The Feature Object](https://docs.stripe.com/api/entitlements/feature/object)
///
/// A feature represents a monetizable ability or functionality in your system. Features can be assigned to products, and when those products are purchased, Stripe will create an entitlement to the
/// feature for the purchasing customer.
public struct Feature: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// A unique key you provide as your own system identifier. This may be up to 80 characters.
    public var lookupKey: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The feature’s name, for your own purpose, not meant to be displayable to the customer.
    public var name: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Inactive features cannot be attached to new products and will not be returned from the features list endpoint.
    public var active: Bool?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
}

public struct FeatureList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Feature]?
}
