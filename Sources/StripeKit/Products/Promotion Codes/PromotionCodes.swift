//
//  PromotionCodes.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import Foundation

public struct PromotionCode: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for each customer.
    public var code: String?
    /// Hash describing the coupon for this promotion code.
    public var coupon: Coupon?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the promotion code is currently active. A promotion code is only active if the coupon is also valid.
    public var active: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The customer that this promotion code can be used by.
    @Expandable<Customer> public var customer: String?
    /// Date at which the promotion code can no longer be redeemed.
    public var expiresAt: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Maximum number of times this promotion code can be redeemed.
    public var maxRedemptions: Int?
    /// Settings that restrict the redemption of the promotion code.
    public var restrictions: PromotionCodeRestrictions?
    /// Number of times this promotion code has been used.
    public var timesRedeemed: Int?
    
    public init(id: String,
                code: String? = nil,
                coupon: Coupon? = nil,
                metadata: [String : String]? = nil,
                object: String,
                active: Bool? = nil,
                created: Date,
                customer: String? = nil,
                expiresAt: Date? = nil,
                livemode: Bool? = nil,
                maxRedemptions: Int? = nil,
                restrictions: PromotionCodeRestrictions? = nil,
                timesRedeemed: Int? = nil) {
        self.id = id
        self.code = code
        self.coupon = coupon
        self.metadata = metadata
        self.object = object
        self.active = active
        self.created = created
        self._customer = Expandable(id: customer)
        self.expiresAt = expiresAt
        self.livemode = livemode
        self.maxRedemptions = maxRedemptions
        self.restrictions = restrictions
        self.timesRedeemed = timesRedeemed
    }
}

public struct PromotionCodeRestrictions: Codable {
    /// Promotion code restrictions defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your promotion code in `eur`, fetch the value of the `eur` key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
    public var currencyOptions: [Currency: PromotionCodeRestrictionsCurrencyOptions]?
    /// A Boolean indicating if the Promotion Code should only be redeemed for Customers without any successful payments or invoices
    public var firstTimeTransaction: Bool?
    /// Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
    public var minimumAmount: Int?
    /// Three-letter ISO code for `minimum_amount`
    public var minimumAmountCurrency: String?
    
    public init(currencyOptions: [Currency : PromotionCodeRestrictionsCurrencyOptions]? = nil,
                firstTimeTransaction: Bool? = nil,
                minimumAmount: Int? = nil,
                minimumAmountCurrency: String? = nil) {
        self.currencyOptions = currencyOptions
        self.firstTimeTransaction = firstTimeTransaction
        self.minimumAmount = minimumAmount
        self.minimumAmountCurrency = minimumAmountCurrency
    }
}

public struct PromotionCodeRestrictionsCurrencyOptions: Codable {
    /// Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
    public var minimumAmount: Int?
    
    public init(minimumAmount: Int? = nil) {
        self.minimumAmount = minimumAmount
    }
}

public struct PromotionCodeList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [PromotionCode]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [PromotionCode]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
