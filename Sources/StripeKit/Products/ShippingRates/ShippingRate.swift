//
//  ShippingRate.swift
//  
//
//  Created by Andrew Edwards on 12/17/21.
//

import Foundation

public struct StripeShippingRate: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the shipping rate can be used for new purchases. Defaults to `true`.
    public var active: Bool
    /// The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
    public var displayName: String?
    /// Describes a fixed amount to charge for shipping. Must be present if type is fixed_amount.
    public var fixedAmount: StripeShippingRateFixedAmount?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The type of calculation to use on the shipping rate. Can only be fixed_amount for now.
    public var type: StripeShippingRateType?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
    public var deliveryEstimate: StripeDeliveryEstimate?
    /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified.
    public var taxBehavior: StripeShippingRateTaxBehavior?
    /// A tax code ID. The Shipping tax code is `txcd_92010001`.
    @Expandable<StripeTaxCode> public var taxCode: String?
}

public struct StripeShippingRateFixedAmount: StripeModel {
    /// A non-negative integer in cents representing how much to charge.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
}

public enum StripeShippingRateType: String, StripeModel {
    case fixedAmount = "fixed_amount"
}

public struct StripeShippingRateDeliveryEstimate: StripeModel {
    /// The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
    public var maximum: StripeShippingRateDeliveryEstimateMaxMin?
    /// The lower bound of the estimated range. If empty, represents no lower bound.
    public var minimum: StripeShippingRateDeliveryEstimateMaxMin?
}

public struct StripeShippingRateDeliveryEstimateMaxMin: StripeModel {
    /// A unit of time.
    public var unit: StripeShippingRateDeliveryEstimateUnit?
    /// Must be greater than 0.
    public var value: Int?
}

public enum StripeShippingRateDeliveryEstimateUnit: String, StripeModel {
    case hour
    case day
    case businessDay = "business_day"
    case week
    case month
}

public enum StripeShippingRateTaxBehavior: String, StripeModel {
    case inclusive
    case exclusive
    case unspecified
}

public struct StripeShippingRateList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeShippingRate]?
}
