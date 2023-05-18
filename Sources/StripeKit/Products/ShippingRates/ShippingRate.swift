//
//  ShippingRate.swift
//  
//
//  Created by Andrew Edwards on 12/17/21.
//

import Foundation

public struct ShippingRate: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Whether the shipping rate can be used for new purchases. Defaults to `true`.
    public var active: Bool
    /// The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
    public var displayName: String?
    /// Describes a fixed amount to charge for shipping. Must be present if type is fixed_amount.
    public var fixedAmount: ShippingRateFixedAmount?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The type of calculation to use on the shipping rate. Can only be fixed_amount for now.
    public var type: ShippingRateType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
    public var deliveryEstimate: ShippingRateDeliveryEstimate?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified.
    public var taxBehavior: ShippingRateTaxBehavior?
    /// A tax code ID. The Shipping tax code is `txcd_92010001`.
    @Expandable<TaxCode> public var taxCode: String?
    
    public init(id: String,
                active: Bool,
                displayName: String? = nil,
                fixedAmount: ShippingRateFixedAmount? = nil,
                metadata: [String : String]? = nil,
                type: ShippingRateType? = nil,
                object: String,
                created: Date,
                deliveryEstimate: ShippingRateDeliveryEstimate? = nil,
                livemode: Bool? = nil,
                taxBehavior: ShippingRateTaxBehavior? = nil,
                taxCode: String? = nil) {
        self.id = id
        self.active = active
        self.displayName = displayName
        self.fixedAmount = fixedAmount
        self.metadata = metadata
        self.type = type
        self.object = object
        self.created = created
        self.deliveryEstimate = deliveryEstimate
        self.livemode = livemode
        self.taxBehavior = taxBehavior
        self._taxCode = Expandable(id: taxCode)
    }
}

public struct ShippingRateFixedAmount: Codable {
    /// A non-negative integer in cents representing how much to charge.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Shipping rates defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your shipping rate in `eur`, fetch the value of the `eur` key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
    public var currencyOptions: [Currency: ShippingRateFixedAmountCurrencyOptions]?
    
    public init(amount: Int? = nil,
                currency: Currency? = nil,
                currencyOptions: [Currency : ShippingRateFixedAmountCurrencyOptions]? = nil) {
        self.amount = amount
        self.currency = currency
        self.currencyOptions = currencyOptions
    }
}

public struct ShippingRateFixedAmountCurrencyOptions: Codable {
    /// A non-negative integer in cents representing how much to charge.
    public var amount: Int?
    /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
    public var taxBehavior: ShippingRateFixedAmountCurrencyOptionsTaxBehavior?
    
    public init(amount: Int? = nil,
                taxBehavior: ShippingRateFixedAmountCurrencyOptionsTaxBehavior? = nil) {
        self.amount = amount
        self.taxBehavior = taxBehavior
    }
}

public enum ShippingRateFixedAmountCurrencyOptionsTaxBehavior: String, Codable {
    case inclusive
    case exclusive
    case unspecified
}

public enum ShippingRateType: String, Codable {
    case fixedAmount = "fixed_amount"
}

public struct ShippingRateDeliveryEstimate: Codable {
    /// The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
    public var maximum: ShippingRateDeliveryEstimateMaxMin?
    /// The lower bound of the estimated range. If empty, represents no lower bound.
    public var minimum: ShippingRateDeliveryEstimateMaxMin?
    
    public init(maximum: ShippingRateDeliveryEstimateMaxMin? = nil,
                minimum: ShippingRateDeliveryEstimateMaxMin? = nil) {
        self.maximum = maximum
        self.minimum = minimum
    }
}

public struct ShippingRateDeliveryEstimateMaxMin: Codable {
    /// A unit of time.
    public var unit: ShippingRateDeliveryEstimateUnit?
    /// Must be greater than 0.
    public var value: Int?
    
    public init(unit: ShippingRateDeliveryEstimateUnit? = nil, value: Int? = nil) {
        self.unit = unit
        self.value = value
    }
}

public enum ShippingRateDeliveryEstimateUnit: String, Codable {
    case hour
    case day
    case businessDay = "business_day"
    case week
    case month
}

public enum ShippingRateTaxBehavior: String, Codable {
    case inclusive
    case exclusive
    case unspecified
}

public struct ShippingRateList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ShippingRate]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [ShippingRate]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
