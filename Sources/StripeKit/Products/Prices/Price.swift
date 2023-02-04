//
//  Price.swift
//  
//
//  Created by Andrew Edwards on 7/19/20.
//

import Foundation

/// The [Price Object](https://stripe.com/docs/api/prices/object)
public struct StripePrice: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the price can be used for new purchases.
    public var active: Bool?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The ID of the product this price is associated with.
    @Expandable<StripeProduct> public var product: String?
    /// The recurring components of a price such as `interval` and `usage_type`.
    public var recurring: StripePriceRecurring?
    /// One of `one_time` or `recurring` depending on whether the price is for a one-time purchase or a recurring (subscription) purchase.
    public var type: StripePriceType?
    /// The unit amount in cents to be charged, represented as a whole integer if possible.
    public var unitAmount: Int?
    /// Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in quantity (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    public var billingScheme: StripePriceBillingScheme?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// A lookup key used to retrieve prices dynamically from a static string.
    public var lookupKey: String?
    /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to tiered. See also the documentation for `billing_scheme`. This field is not included by default. To include it in the response, expand the `tiers` field.
    public var tiers: [StripePriceTier]?
    /// Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.
    public var tiersMode: StripePriceTierMode?
    /// Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.
    public var transformQuantity: StripePriceTransformQuantity?
    /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places.
    public var unitAmountDecimal: String?
}

public struct StripePriceRecurring: Codable {
    /// Specifies a usage aggregation strategy for prices of `usage_type=metered`. Allowed values are sum for summing up all usage during a period, `last_during_period` for using the last usage record reported within a period, `last_ever` for using the last usage record ever (across period bounds) or `max` which uses the usage record with the maximum reported usage during a period. Defaults to `sum`.
    public var aggregateUsage: StripePriceRecurringAggregateUsage?
    /// The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
    public var interval: PlanInterval?
    /// The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    public var intervalCount: Int?
    /// Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.
    public var usageType: StripePlanUsageType?
}
    
public enum StripePriceRecurringAggregateUsage: String, Codable {
    case sum
    case lastDuringPeriod = "last_during_period"
    case lastEver = "last_ever"
    case max
}

public enum StripePriceType: String, Codable {
    case oneTime = "one_time"
    case recurring
}

public enum StripePriceBillingScheme: String, Codable {
    case perUnit = "per_unit"
    case tiered
}

public struct StripePriceTier: Codable {
    /// Price for the entire tier.
    public var flatAmount: Int?
    /// Same as `flat_amount`, but contains a decimal value with at most 12 decimal places.
    public var flatAmountDecimal: String?
    /// Per unit price for units relevant to the tier.
    public var unitAmount: Int?
    /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
    public var unitAmountDecimal: String?
    /// Up to and including to this quantity will be contained in the tier.
    public var upTo: Int?
}

public enum StripePriceTierMode: String, Codable {
    case graduated
    case volume
}

public struct StripePriceTransformQuantity: Codable {
    /// Divide usage by this number.
    public var divideBy: Int?
    /// After division, either round the result `up` or `down`.
    public var round: StripePriceTransformQuantityRound?
}

public enum StripePriceTransformQuantityRound: String, Codable {
    case up
    case down
}

public struct StripePriceList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePrice]?
}
