//
//  Plans.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Foundation

/// The [Plan Object](https://stripe.com/docs/api/plans/object).
public struct StripePlan: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the plan is currently available for new subscriptions.
    public var active: Bool?
    /// Specifies a usage aggregation strategy for plans of usage_type=metered. Allowed values are `sum` for summing up all usage during a period, `last_during_period` for picking the last usage record reported within a period, `last_ever` for picking the last usage record ever (across period bounds) or `max` which picks the usage record with the maximum reported usage during a period. Defaults to `sum`.
    public var aggregateUsage: StripePlanAggregateUsage?
    /// The amount in cents to be charged on the interval specified.
    public var amount: Int?
    /// Same as `amount`, but contains a decimal value with at most 12 decimal places.
    public var amountDecimal: String?
    /// Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `amount`) will be charged per unit in `quantity` (for plans with `usage_type=licensed`), or per unit of total usage (for plans with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    public var billingScheme: StripePlanBillingScheme?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// One of `day`, `week`, `month` or `year`. The frequency with which a subscription should be billed.
    public var interval: StripePlanInterval?
    /// The number of intervals (specified in the `interval` property) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    public var intervalCount: Int?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// A brief description of the plan, hidden from customers.
    public var nickname: String?
    /// The product whose pricing this plan determines.
    public var product: String?
    /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    public var tiers: [StripePlanTier]?
    /// Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price, in `graduated` tiering pricing can successively change as the quantity grows.
    public var tiersMode: StripePlanTiersMode?
    /// Apply a transformation to the reported usage or set quantity before computing the billed price. Cannot be combined with `tiers`
    public var transformUsage: StripePlanTransformUsage?
    /// Default number of trial days when subscribing a customer to this plan using `trial_from_plan=true`.
    public var trialPeriodDays: Int?
    /// Configures how the quantity per period should be determined, can be either `metered` or `licensed`. `licensed` will automatically bill the `quantity` set for a plan when adding it to a subscription, `metered` will aggregate the total usage based on usage records. Defaults to `licensed`.
    public var usageType: StripePlanUsageType?
}

public enum StripePlanAggregateUsage: String, StripeModel {
    case sum
    case lastDuringPeriod = "last_during_period"
    case lastEver = "last_ever"
    case max
}

public enum StripePlanBillingScheme: String, StripeModel {
    case perUnit = "per_unit"
    case tiered
}

public enum StripePlanInterval: String, StripeModel {
    case day
    case week
    case month
    case year
}

public struct StripePlanTier: StripeModel {
    /// Price for the entire tier.
    public var flatAmount: Int?
    /// Per unit price for units relevant to the tier.
    public var amount: Int?
    /// Up to and including to this quantity will be contained in the tier.
    public var upTo: Int?
}

public enum StripePlanTiersMode: String, StripeModel {
    case graduated
    case volume
}

public struct StripePlanTransformUsage: StripeModel {
    /// Divide usage by this number.
    public var divideBy: Int?
    /// After division, either round the result `up` or `down`.
    public var round: StripePlanTransformUsageRound?
}

public enum StripePlanTransformUsageRound: String, StripeModel {
    case up
    case down
}

public enum StripePlanUsageType: String, StripeModel {
    case metered
    case licensed
}

public struct StripePlanList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripePlan]?
}
