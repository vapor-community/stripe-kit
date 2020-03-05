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
    /// Additional information about a business_entity cardholder.
    public var company: StripeCardholderCompany?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The cardholder’s email address.
    public var email: String?
    /// Additional information about an individual cardholder.
    public var individual: StripeCardholderIndividual?
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
    /// Information about verification requirements for the cardholder, including what information needs to be collected.
    public var requirements: StripeCardholderAuthorizationRequirements?
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

public struct StripeCardholderCompany: StripeModel {
    /// Whether the company’s business ID number was provided.
    public var taxIdProvided: Bool?
}

public struct StripeCardholderIndividual: StripeModel {
    /// The date of birth of this cardholder.
    public var dob: StripePersonDOB?
    /// The first name of this cardholder
    public var firstName: String?
    /// The first name of this cardholder
    public var lastName: String?
    /// Government-issued ID document for this cardholder.
    public var verification: StripeCardholderIndividualVerification?
}

public struct StripeCardholderIndividualVerification: StripeModel {
    /// An identifying document, either a passport or local ID card.
    public var document: StripePersonVerificationDocument?
}

public struct StripeCardholderAuthorizationRequirements: StripeModel {
    /// If the cardholder is disabled, this string describes why. Can be one of listed, rejected.listed, or under_review.
    public var disabledReason: StripeRequirementsDisabledReason?
    /// If not empty, this field contains the list of fields that need to be collected in order to verify and re-enabled the cardholder.
    public var pastDue: [String]?
}

public enum StripeCardholderStatus: String, StripeModel {
    case active
    case inactive
    case blocked
}

public enum StripeCardholderType: String, StripeModel {
    case individial
    case businessEntity = "business_entity"
}

public enum StripeRequirementsDisabledReason: String, StripeModel {
    case listed
    case rejectedListed = "rejected.listed"
    case underReview = "under_review"
}

public struct StripeCardholderList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeCardholder]?
    
    public enum CodingKeys: String, CodingKey {
        case object, url, data
        case hasMore = "has_more"
    }
}
