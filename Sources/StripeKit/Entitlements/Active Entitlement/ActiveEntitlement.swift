//
//  Feature..swift
//  stripe-kit
//
//  Created by TelemetryDeck on 25.01.25.
//

import Foundation

/// [The ActiveEntitlement Object](https://docs.stripe.com/api/entitlements/active-entitlement/object)
///
/// An active entitlement describes access to a feature for a customer.
public struct ActiveEntitlement: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The Feature that the customer is entitled to.
    @Expandable<Feature> public var feature: String?
    /// A unique key you provide as your own system identifier. This may be up to 80 characters.
    public var lookupKey: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
}

public struct ActiveEntitlementList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ActiveEntitlement]?
}
