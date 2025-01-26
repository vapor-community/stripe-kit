//
//  Feature..swift
//  stripe-kit
//
//  Created by TelemetryDeck on 25.01.25.
//

import Foundation

/// [The ProductFeature Object](https://docs.stripe.com/api/product-feature/object)
///
/// A product_feature represents an attachment between a feature and a product. When a product is purchased that has a feature attached, Stripe will create an entitlement to the feature for the
/// purchasing customer.
public struct ProductFeature: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The Feature object attached to this product.
    @Expandable<Feature> public var entitlementFeature: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
}

public struct ProductFeatureList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ProductFeature]?
}
