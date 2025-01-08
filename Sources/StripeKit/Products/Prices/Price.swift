//
//  Price.swift
//
//
//  Created by Andrew Edwards on 7/19/20.
//

import Foundation

/// The [Price Object](https://stripe.com/docs/api/prices/object)
public struct Price: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Whether the price can be used for new purchases.
    public var active: Bool?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// A brief description of the price, hidden from customers.
    public var nickname: String?
    /// The ID of the product this price is associated with.
    @Expandable<Product> public var product: String?
    /// The recurring components of a price such as `interval` and `usage_type`.
    public var recurring: PriceRecurring?
    /// One of `one_time` or `recurring` depending on whether the price is for a one-time purchase or a recurring (subscription) purchase.
    public var type: PriceType?
    /// The unit amount in cents to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
    public var unitAmount: Int?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in quantity (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    public var billingScheme: PriceBillingScheme?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Prices defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your price in eur, fetch the value of the eur key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
    public var currencyOptions: [Currency: PriceCurrencyOption]?
    /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
    public var customUnitAmount: PriceCustomUnitAmount?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// A lookup key used to retrieve prices dynamically from a static string. This may be up to 200 characters.
    public var lookupKey: String?
    /// Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified. Once specified as either inclusive or exclusive, it cannot be changed.
    public var taxBehavior: String?
    /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to tiered. See also the documentation for `billing_scheme`. This field is not included by default. To include it in the response, expand the `tiers` field.
    public var tiers: [PriceTier]?
    /// Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.
    public var tiersMode: PriceTierMode?
    /// Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.
    public var transformQuantity: PriceTransformQuantity?
    /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places.
    public var unitAmountDecimal: String?

    public init(id: String,
                active: Bool? = nil,
                currency: Currency? = nil,
                metadata: [String: String]? = nil,
                nickname: String? = nil,
                product: String? = nil,
                recurring: PriceRecurring? = nil,
                type: PriceType? = nil,
                unitAmount: Int? = nil,
                object: String,
                billingScheme: PriceBillingScheme? = nil,
                created: Date,
                currencyOptions: [Currency: PriceCurrencyOption]? = nil,
                customUnitAmount: PriceCustomUnitAmount? = nil,
                livemode: Bool? = nil,
                lookupKey: String? = nil,
                taxBehavior: String? = nil,
                tiers: [PriceTier]? = nil,
                tiersMode: PriceTierMode? = nil,
                transformQuantity: PriceTransformQuantity? = nil,
                unitAmountDecimal: String? = nil)
    {
        self.id = id
        self.active = active
        self.currency = currency
        self.metadata = metadata
        self.nickname = nickname
        self._product = Expandable(id: product)
        self.recurring = recurring
        self.type = type
        self.unitAmount = unitAmount
        self.object = object
        self.billingScheme = billingScheme
        self.created = created
        self.currencyOptions = currencyOptions
        self.customUnitAmount = customUnitAmount
        self.livemode = livemode
        self.lookupKey = lookupKey
        self.taxBehavior = taxBehavior
        self.tiers = tiers
        self.tiersMode = tiersMode
        self.transformQuantity = transformQuantity
        self.unitAmountDecimal = unitAmountDecimal
    }
}

public struct PriceRecurring: Codable {
    /// Specifies a usage aggregation strategy for prices of `usage_type=metered`. Allowed values are sum for summing up all usage during a period, `last_during_period` for using the last usage record reported within a period, `last_ever` for using the last usage record ever (across period bounds) or `max` which uses the usage record with the maximum reported usage during a period. Defaults to `sum`.
    public var aggregateUsage: PriceRecurringAggregateUsage?
    /// The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
    public var interval: PlanInterval?
    /// The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    public var intervalCount: Int?
    /// Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.
    public var usageType: PlanUsageType?
    /// The meter tracking the usage of a metered price
    public var meter: String?

    public init(aggregateUsage: PriceRecurringAggregateUsage? = nil,
                interval: PlanInterval? = nil,
                intervalCount: Int? = nil,
                usageType: PlanUsageType? = nil,
                meter: String? = nil)
    {
        self.aggregateUsage = aggregateUsage
        self.interval = interval
        self.intervalCount = intervalCount
        self.usageType = usageType
        self.meter = meter
    }
}

public enum PriceRecurringAggregateUsage: String, Codable {
    case sum
    case lastDuringPeriod = "last_during_period"
    case lastEver = "last_ever"
    case max
}

public enum PriceType: String, Codable {
    case oneTime = "one_time"
    case recurring
}

public enum PriceBillingScheme: String, Codable {
    case perUnit = "per_unit"
    case tiered
}

public struct PriceCurrencyOption: Codable {
    /// When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
    public var customUnitAmount: PriceCurrencyOptionCustomUnitAmount?
    /// Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
    public var taxBehavior: PriceTaxBehavior?
    /// Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`. This field is not included by default. To include it in the response, expand the `<currency>.tiers` field.
    public var tiers: [PriceTier]?
    /// The unit amount in cents to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
    public var unitAmount: Int?
    /// The unit amount in cents to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.
    public var unitAmountDecimal: String?

    public init(customUnitAmount: PriceCurrencyOptionCustomUnitAmount? = nil,
                taxBehavior: PriceTaxBehavior? = nil,
                tiers: [PriceTier]? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil)
    {
        self.customUnitAmount = customUnitAmount
        self.taxBehavior = taxBehavior
        self.tiers = tiers
        self.unitAmount = unitAmount
        self.unitAmountDecimal = unitAmountDecimal
    }
}

public struct PriceCurrencyOptionCustomUnitAmount: Codable {
    /// The maximum unit amount the customer can specify for this item.
    public var maximum: Int?
    /// The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
    public var minimum: Int?
    /// The starting unit amount which can be updated by the customer.
    public var preset: Int?

    public init(maximum: Int? = nil,
                minimum: Int? = nil,
                preset: Int? = nil)
    {
        self.maximum = maximum
        self.minimum = minimum
        self.preset = preset
    }
}

public enum PriceTaxBehavior: String, Codable {
    case inclusive
    case exclusive
    case unspecified
}

public struct PriceTier: Codable {
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

    public init(flatAmount: Int? = nil,
                flatAmountDecimal: String? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil,
                upTo: Int? = nil)
    {
        self.flatAmount = flatAmount
        self.flatAmountDecimal = flatAmountDecimal
        self.unitAmount = unitAmount
        self.unitAmountDecimal = unitAmountDecimal
        self.upTo = upTo
    }
}

public struct PriceCustomUnitAmount: Codable {
    /// The maximum unit amount the customer can specify for this item.
    public var maximum: Int?
    /// The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
    public var minimum: Int?
    /// The starting unit amount which can be updated by the customer.
    public var preset: Int?

    public init(maximum: Int? = nil,
                minimum: Int? = nil,
                preset: Int? = nil)
    {
        self.maximum = maximum
        self.minimum = minimum
        self.preset = preset
    }
}

public enum PriceTierMode: String, Codable {
    case graduated
    case volume
}

public struct PriceTransformQuantity: Codable {
    /// Divide usage by this number.
    public var divideBy: Int?
    /// After division, either round the result `up` or `down`.
    public var round: PriceTransformQuantityRound?

    public init(divideBy: Int? = nil,
                round: PriceTransformQuantityRound? = nil)
    {
        self.divideBy = divideBy
        self.round = round
    }
}

public enum PriceTransformQuantityRound: String, Codable {
    case up
    case down
}

public struct PriceSearchResult: Codable {
    /// A string describing the object type returned.
    public var object: String
    /// A list of prices, paginated by any request parameters.
    public var data: [Price]?
    /// Whether or not there are more elements available after this set.
    public var hasMore: Bool?
    /// The URL for accessing this list.
    public var url: String?
    /// The URL for accessing the next page in search results.
    public var nextPage: String?
    /// The total count of entries in the search result, not just the current page.
    public var totalCount: Int?

    public init(object: String,
                data: [Price]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil,
                nextPage: String? = nil,
                totalCount: Int? = nil)
    {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
        self.nextPage = nextPage
        self.totalCount = totalCount
    }
}

public struct PriceList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Price]?

    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Price]? = nil)
    {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
