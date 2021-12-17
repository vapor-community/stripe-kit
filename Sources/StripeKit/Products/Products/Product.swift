//
//  Product.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

/// The [Product Object](https://stripe.com/docs/api/products/object).
public struct StripeProduct: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the product is currently available for purchase.
    public var active: Bool?
    /// A list of up to 5 attributes that each SKU can provide values for (e.g., `["color", "size"]`). Only applicable to products of `type=good`.
    public var attributes: [String]?
    /// A short one-line description of the product, meant to be displayable to the customer. Only applicable to products of `type=good`.
    public var caption: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// An array of connect application identifiers that cannot purchase this product. Only applicable to products of `type=good`.
    public var deactivateOn: [String]?
    /// The product’s description, meant to be displayable to the customer. Only applicable to products of `type=good`.
    public var description: String?
    /// A list of up to 8 URLs of images for this product, meant to be displayable to the customer. Only applicable to products of `type=good`.
    public var images: [String]?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The product’s name, meant to be displayable to the customer. Applicable to both `service` and `good` types.
    public var name: String?
    /// The dimensions of this product for shipping purposes. A SKU associated with this product can override this value by having its own `package_dimensions`. Only applicable to products of `type=good`.
    public var packageDimensions: StripeProductPackageDimensions?
    /// Whether this product is a shipped good. Only applicable to products of `type=good`.
    public var shippable: Bool?
    /// Extra information about a product which will appear on your customer’s credit card statement. In the case that multiple products are billed at once, the first statement descriptor will be used. Only available on products of `type=service`.
    public var statementDescriptor: String?
    /// A tax code ID.
    @Expandable<StripeTaxCode> public var taxCode: String?
    /// The type of the product. The product is either of type `good`, which is eligible for use with Orders and SKUs, or `service`, which is eligible for use with Subscriptions and Plans.
    public var type: StripeProductType?
    /// A label that represents units of this product, such as seat(s), in Stripe and on customers’ receipts and invoices. Only available on products of type=service.
    public var unitLabel: String?
    /// Time at which the object was last updated. Measured in seconds since the Unix epoch.
    public var updated: Date?
    /// A URL of a publicly-accessible webpage for this product. Only applicable to products of `type=good`.
    public var url: String?
}

public struct StripeProductPackageDimensions: StripeModel {
    /// Height, in inches.
    public var height: Decimal?
    /// Length, in inches.
    public var length: Decimal?
    /// Weight, in inches.
    public var weight: Decimal?
    /// Width, in inches.
    public var width: Decimal?
}

public enum StripeProductType: String, StripeModel {
    case service
    case good
}

public struct StripeProductsList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeProduct]?
}
