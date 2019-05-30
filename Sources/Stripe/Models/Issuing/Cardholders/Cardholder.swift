//
//  Cardholder.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/21/19.
//

import Foundation

/// The [Cardholder object](https://stripe.com/docs/api/issuing/cardholders/object)
public struct StripeCardholder: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    ///
    public var authorizationControls: StripeCardholderAuthorizationControls?
    /// The cardholder’s billing address.
    public var billing: StripeCardholderBilling?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The cardholder’s email address.
    public var email: String?
    /// Whether or not this cardholder is the default cardholder.
    public var isDefault: Bool?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The cardholder’s name. This will be printed on cards issued to them.
    public var name: String?
    /// The cardholder’s phone number.
    public var phoneNumber: String?
    /// One of `active`, `inactive`, `blocked`, or `pending`.
    public var status: StripeCardholderStatus?
    /// One of `individual` or `business_entity`.
    public var type: StripeCardholderType?
}

public struct StripeCardholderAuthorizationControls: StripeModel {
    /// Array of strings containing categories of authorizations permitted on this card.
    public var allowedCategories: [String]?
    /// Array of strings containing categories of authorizations to always decline on this card.
    public var blockedCategories: [String]?
    /// Limit the spending with rules based on time intervals and categories.
    public var spendingLimits: [StripeCardholderAuthorizationControlSpendingLimit]?
    /// Currency for the amounts within spending_limits.
    public var spendingLimitsCurrency: StripeCurrency?
}

public struct StripeCardholderAuthorizationControlSpendingLimit: StripeModel {
    /// Maximum amount allowed to spend per time interval.
    public var amount: Int?
    /// Array of strings containing categories on which to apply the spending limit. Leave this blank to limit all charges.
    public var categories: [String]?
    /// The time interval with which to apply this spending limit towards. Allowed values are per_authorization, daily, weekly, monthly, yearly, or all_time.
    public var interval: StripeCardholderAuthorizationControlSpendingLimitInterval?
}

public enum StripeCardholderAuthorizationControlSpendingLimitInterval: String, StripeModel {
    case perAuthorization = "per_authorization"
    case daily
    case weekly
    case monthly
    case yearly
    case allTime = "all_time"
}

public struct StripeCardholderBilling: StripeModel {
    public var address: StripeAddress?
    public var name: String?
}

public enum StripeCardholderStatus: String, StripeModel {
    case active
    case inactive
    case blocked
    case pending
}

public enum StripeCardholderType: String, StripeModel {
    case individial
    case businessEntity = "business_entity"
}

public struct StripeCardholderList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeCardholder]?
}
