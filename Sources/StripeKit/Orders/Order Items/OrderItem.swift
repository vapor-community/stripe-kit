//
//  OrderItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

/// The [Order Item Pobject](https://stripe.com/docs/api/order_items/object)
public struct StripeOrderItem: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount for the line item.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Description of the line item, meant to be displayable to the user (e.g., `"Express shipping"`).
    public var description: String?
    /// The ID of the associated object for this line item. Expandable if not null (e.g., expandable to a SKU).
    // TODO: - Use @DynamicExpandable
    public var parent: String?
    /// A positive integer representing the number of instances of `parent` that are included in this order item. Applicable/present only if `type` is `sku`.
    public var quantity: Int?
    /// The type of line item. One of `sku`, `tax`, `shipping`, or `discount`.
    public var type: StripeOrderItemType?
}

public enum StripeOrderItemType: String, StripeModel {
    case sku
    case tax
    case shipping
    case discount
}
