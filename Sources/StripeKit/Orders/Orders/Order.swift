//
//  Order.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

/// The [Order Object](https://stripe.com/docs/api/orders/object)
public struct StripeOrder: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount for the order.
    public var amount: Int?
    ///
    public var amountReturned: Int?
    /// ID of the Connect Application that created the order.
    public var application: String?
    ///
    public var applicationFee: Int?
    /// The ID of the payment used to pay for the order. Present if the order status is `paid`, `fulfilled`, or `refunded`.
    public var charge: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// The customer used for the order.
    public var customer: String?
    /// The email address of the customer placing the order.
    public var email: String?
    ///
    public var externalCouponCode: String?
    /// List of items constituting the order. An order can have up to 25 items.
    public var items: [StripeOrderItem]?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    ///
    public var returns: StripeOrderReturnList?
    /// The shipping method that is currently selected for this order, if any. If present, it is equal to one of the ids of shipping methods in the shipping_methods array. At order creation time, if there are multiple shipping methods, Stripe will automatically selected the first method.
    public var selectedShippingMethod: String?
    /// The shipping address for the order. Present if the order is for goods to be shipped.
    public var shipping: StripeShippingLabel?
    /// A list of supported shipping methods for this order. The desired shipping method can be specified either by updating the order, or when paying it.
    public var shippingMethods: [StripeShippingMethod]?
    /// Current order status. One of `created`, `paid`, `canceled`, `fulfilled`, or `returned`. More details in the [Orders Guide](https://stripe.com/docs/orders/guide#understanding-order-statuses).
    public var status: StripeOrderStatus?
    /// The timestamps at which the order status was updated.
    public var statusTransitions: StripeOrderStatusTransitions?
    ///
    public var updated: Date?
    /// The user’s order ID if it is different from the Stripe order ID.
    public var upstreamId: String?
}

public enum StripeOrderStatus: String, StripeModel {
    case created
    case paid
    case canceled
    case fulfilled
    case returned
}

public struct StripeOrderStatusTransitions: StripeModel {
    public var canceled: Date?
    public var fulfiled: Date?
    public var paid: Date?
    public var returned: Date?
}

public struct StripeShippingMethod: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount for the line item.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// The estimated delivery date for the given shipping method. Can be either a specific date or a range.
    public var deliveryEstimate: StripeDeliveryEstimate?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
}

public struct StripeDeliveryEstimate: StripeModel {
    /// If `type` is `"exact"`, `date` will be the expected delivery date in the format YYYY-MM-DD.
    public var date: String?
    /// If `type` is `"range"`, earliest will be be the earliest delivery date in the format YYYY-MM-DD.
    public var earliest: String?
    /// If `type` is `"range"`, `latest` will be the latest delivery date in the format YYYY-MM-DD.
    public var latest: String?
    /// The type of estimate. Must be either "range" or "exact".
    public var type: StripeDeliveryEstimateType?
}

public enum StripeDeliveryEstimateType: String, StripeModel {
    case range
    case exact
}

public struct StripeOrderList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeOrder]?
    
    public enum CodingKeys: String, CodingKey {
        case object, url, data
        case hasMore = "has_more"
    }
}
