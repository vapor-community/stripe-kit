//
//  SKU.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

/// The [SKU Object](https://stripe.com/docs/api/skus/object).
public struct StripeSKU: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the SKU is available for purchase.
    public var active: Bool?
    /// A dictionary of attributes and values for the attributes defined by the product. If, for example, a product’s attributes are `["size", "gender"]`, a valid SKU has the following dictionary of attributes: `{"size": "Medium", "gender": "Unisex"}`.
    public var attributes: [String: String]?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// The URL of an image for this SKU, meant to be displayable to the customer.
    public var image: String?
    /// Description of the SKU’s inventory.
    public var inventory: StripeSKUInventory?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The dimensions of this SKU for shipping purposes.
    public var packageDimensions: StripeProductPackageDimensions?
    /// The cost of the item as a positive integer in the smallest currency unit (that is, 100 cents to charge $1.00, or 100 to charge ¥100, Japanese Yen being a zero-decimal currency).
    public var price: Int?
    /// The ID of the product this SKU is associated with. The product must be currently active.
    public var product: String?
    /// 
    public var updated: Date?
}

public struct StripeSKUInventory: StripeModel {
    /// The count of inventory available. Will be present if and only if `type` is `finite`.
    public var quantity: Int?
    /// Inventory type. Possible values are `finite`, `bucket` (not quantified), and `infinite`.
    public var type: StripeSKUInventoryType?
    /// An indicator of the inventory available. Possible values are `in_stock`, `limited`, and `out_of_stock`. Will be present if and only if `type` is `bucket`.
    public var value: StripeSKUInventoryValue?
}

public enum StripeSKUInventoryType: String, StripeModel {
    case finite
    case bucket
    case infinite
}

public enum StripeSKUInventoryValue: String, StripeModel {
    case inStock = "in_stock"
    case limited
    case outOfStock = "out_of_stock"
}

public struct StripeSKUList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeSKU]?
}
