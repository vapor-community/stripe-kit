//
//  OrderReturn.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

/// The [Return Object](https://stripe.com/docs/api/order_returns/object)
public struct StripeOrderReturn: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount for the returned line item.
    public var amount: Int?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The items included in this order return.
    public var items: [StripeOrderItem]?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The order that this return includes items from.
    @Expandable<StripeOrder> public var order: String?
    /// The ID of the refund issued for this return.
    @Expandable<Refund> public var refund: String?
}

public struct StripeOrderReturnList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeOrderReturn]?
}
