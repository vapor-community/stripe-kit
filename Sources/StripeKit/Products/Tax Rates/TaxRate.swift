//
//  TaxRate.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

import Foundation

/// The [Tax Rate Object](https://stripe.com/docs/api/tax_rates/object)
public struct TaxRate: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Defaults to true. When set to false, this tax rate cannot be applied to objects in the API, but will still be applied to subscriptions and invoices that already have it set.
    public var active: Bool?
    /// Two-letter country code.
    public var country: String?
    /// An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
    public var description: String?
    /// The display name of the tax rates as it will appear to your customer on their receipt email, PDF, and the hosted invoice page.
    public var displayName: String?
    /// This specifies if the tax rate is inclusive or exclusive.
    public var inclusive: Bool?
    /// The jurisdiction for the tax rate.
    public var jurisdiction: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// This represents the tax rate percent out of 100.
    public var percentage: Decimal?
    /// ISO 3166-2 subdivision code, without country prefix. For example, “NY” for New York, United States.
    public var state: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The high-level tax type, such as `vat` or `sales_tax`.
    public var taxType: TaxRateTaxType?
    
    public init(id: String,
                active: Bool? = nil,
                country: String? = nil,
                description: String? = nil,
                displayName: String? = nil,
                inclusive: Bool? = nil,
                jurisdiction: String? = nil,
                metadata: [String : String]? = nil,
                percentage: Decimal? = nil,
                state: String? = nil,
                object: String,
                created: Date,
                livemode: Bool? = nil,
                taxType: TaxRateTaxType? = nil) {
        self.id = id
        self.active = active
        self.country = country
        self.description = description
        self.displayName = displayName
        self.inclusive = inclusive
        self.jurisdiction = jurisdiction
        self.metadata = metadata
        self.percentage = percentage
        self.state = state
        self.object = object
        self.created = created
        self.livemode = livemode
        self.taxType = taxType
    }
}

public enum TaxRateTaxType: String, Codable {
    case vat
    case salesTax = "sales_tax"
}

public struct TaxRateList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TaxRate]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TaxRate]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
