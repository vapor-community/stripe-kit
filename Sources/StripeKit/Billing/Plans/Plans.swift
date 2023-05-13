//
//  Plans.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Foundation

/// The [Plan Object](https://stripe.com/docs/api/plans/object).
public struct Plan: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Whether the plan is currently available for new subscriptions.
    public var active: Bool?
    /// The amount in cents to be charged on the interval specified.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// One of `day`, `week`, `month` or `year`. The frequency with which a subscription should be billed.
    public var interval: PlanInterval?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// A brief description of the plan, hidden from customers.
    public var nickname: String?
    /// The product whose pricing this plan determines.
    @Expandable<Product> public var product: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Specifies a usage aggregation strategy for plans of `usage_type=metered`. Allowed values are `sum` for summing up all usage during a period, `last_during_period` for picking the last usage record reported within a period, `last_ever` for picking the last usage record ever (across period bounds) or `max` which picks the usage record with the maximum reported usage during a period. Defaults to `sum`.
    public var aggregateUsage: PlanAggregateUsage?
    /// Same as `amount`, but contains a decimal value with at most 12 decimal places.
    public var amountDecimal: String?
    /// Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `amount`) will be charged per unit in `quantity` (for plans with `usage_type=licensed`), or per unit of total usage (for plans with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    public var billingScheme: PlanBillingScheme?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The number of intervals (specified in the `interval` property) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    public var intervalCount: Int?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    public var tiers: [PlanTier]?
    /// Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price, in `graduated` tiering pricing can successively change as the quantity grows.
    public var tiersMode: PlanTiersMode?
    /// Apply a transformation to the reported usage or set quantity before computing the billed price. Cannot be combined with `tiers`
    public var transformUsage: PlanTransformUsage?
    /// Default number of trial days when subscribing a customer to this plan using `trial_from_plan=true`.
    public var trialPeriodDays: Int?
    /// Configures how the quantity per period should be determined, can be either `metered` or `licensed`. `licensed` will automatically bill the `quantity` set for a plan when adding it to a subscription, `metered` will aggregate the total usage based on usage records. Defaults to `licensed`.
    public var usageType: PlanUsageType?
    
    public init(id: String,
                active: Bool? = nil,
                amount: Int? = nil,
                currency: Currency? = nil,
                interval: PlanInterval? = nil,
                metadata: [String : String]? = nil,
                nickname: String? = nil,
                product: String? = nil,
                object: String,
                aggregateUsage: PlanAggregateUsage? = nil,
                amountDecimal: String? = nil,
                billingScheme: PlanBillingScheme? = nil,
                created: Date,
                intervalCount: Int? = nil,
                livemode: Bool? = nil,
                tiers: [PlanTier]? = nil,
                tiersMode: PlanTiersMode? = nil,
                transformUsage: PlanTransformUsage? = nil,
                trialPeriodDays: Int? = nil,
                usageType: PlanUsageType? = nil) {
        self.id = id
        self.active = active
        self.amount = amount
        self.currency = currency
        self.interval = interval
        self.metadata = metadata
        self.nickname = nickname
        self._product = Expandable(id: product)
        self.object = object
        self.aggregateUsage = aggregateUsage
        self.amountDecimal = amountDecimal
        self.billingScheme = billingScheme
        self.created = created
        self.intervalCount = intervalCount
        self.livemode = livemode
        self.tiers = tiers
        self.tiersMode = tiersMode
        self.transformUsage = transformUsage
        self.trialPeriodDays = trialPeriodDays
        self.usageType = usageType
    }
}

public enum PlanAggregateUsage: String, Codable {
    case sum
    case lastDuringPeriod = "last_during_period"
    case lastEver = "last_ever"
    case max
}

public enum PlanBillingScheme: String, Codable {
    case perUnit = "per_unit"
    case tiered
}

public enum PlanInterval: String, Codable {
    case day
    case week
    case month
    case year
}

public struct PlanTier: Codable {
    /// Price for the entire tier.
    public var flatAmount: Int?
    /// Same as `flat_amount`, but contains a decimal value with at most 12 decimal places.
    public var flatAmountDecimal: String?
    /// Per unit price for units relevant to the tier.
    public var unitAmount: Int?
    /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places
    public var unitAmountDecimal: String?
    /// Up to and including to this quantity will be contained in the tier.
    public var upTo: Int?
    
    public init(flatAmount: Int? = nil,
                flatAmountDecimal: String? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil,
                upTo: Int? = nil) {
        self.flatAmount = flatAmount
        self.flatAmountDecimal = flatAmountDecimal
        self.unitAmount = unitAmount
        self.unitAmountDecimal = unitAmountDecimal
        self.upTo = upTo
    }
}

public enum PlanTiersMode: String, Codable {
    case graduated
    case volume
}

public struct PlanTransformUsage: Codable {
    /// Divide usage by this number.
    public var divideBy: Int?
    /// After division, either round the result `up` or `down`.
    public var round: PlanTransformUsageRound?
    
    public init(divideBy: Int? = nil, round: PlanTransformUsageRound? = nil) {
        self.divideBy = divideBy
        self.round = round
    }
}

public enum PlanTransformUsageRound: String, Codable {
    case up
    case down
}

public enum PlanUsageType: String, Codable {
    case metered
    case licensed
}

public struct PlanList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Plan]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Plan]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
