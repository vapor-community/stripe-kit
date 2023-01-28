//
//  PromotionCodes.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import Foundation

public struct StripePromotionCode: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the promotion code is currently active. A promotion code is only active if the coupon is also valid.
    public var active: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The customer that this promotion code can be used by.
    @Expandable<StripeCustomer> public var customer: String?
    /// The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for each customer.
    public var code: String?
    /// Hash describing the coupon for this promotion code.
    public var coupon: StripeCoupon?
    /// Date at which the promotion code can no longer be redeemed.
    public var expiresAt: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Maximum number of times this promotion code can be redeemed.
    public var maxRedemptions: Int?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Settings that restrict the redemption of the promotion code.
    public var restrictions: StripePromotionCodeRestrictions?
    /// Number of times this promotion code has been used.
    public var timesRedeemed: Int?
}

public struct StripePromotionCodeRestrictions: Codable {
    /// A Boolean indicating if the Promotion Code should only be redeemed for Customers without any successful payments or invoices
    public var firstTimeTransaction: Bool?
    /// Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
    public var minimumAmount: Int?
    /// Three-letter ISO code for minimum_amount
    public var minimumAmountCurrency: String?
}

public struct StripePromotionCodeList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePromotionCode]?
}
