//
//  Capabilities.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import Foundation

public struct StripeCapability: Codable {
    /// The identifier for the capability.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The account for which the capability enables functionality.
    @Expandable<StripeConnectAccount> public var account: String?
    /// Whether the capability has been requested.
    public var requested: Bool?
    ///
    public var requirements: StripeCapabilitiesRequirements?
    /// Time at which the capability was requested. Measured in seconds since the Unix epoch.
    public var requestedAt: Date?
    /// The status of the capability. Can be active, inactive, pending, or unrequested.
    public var status: StripeCapabilitiesStatus?
}

public struct StripeCapabilitiesRequirements: Codable {
    /// Date by which the fields in `currently_due` must be collected to keep the capability enabled for the account. These fields may disable the capability sooner if the next threshold is reached before they are collected.
    public var currentDeadline: Date?
    /// Fields that need to be collected to keep the capability enabled. If not collected by `current_deadline`, these fields appear in `past_due` as well, and the capability is disabled.
    public var currentlyDue: [String]?
    /// If the capability is disabled, this string describes why. Can be `requirements.past_due`, `requirements.pending_verification`, `listed`, `platform_paused`, `rejected.fraud`, `rejected.listed`, `rejected.terms_of_service`, `rejected.other`, `under_review`, or `other`.
    ///
    /// `rejected.unsupported_business` means that the account’s business is not supported by the capability. For example, payment methods may restrict the businesses they support in their terms of service:
    /// - [Adterpay Clearpay's terms of service](https://stripe.com/afterpay-clearpay/legal#restricted-businesses)
    ///
    /// If you believe that the rejection is in error, please contact support@stripe.com for assistance.
    public var disabledReason: String?
    /// Fields that are `currently_due` and need to be collected again because validation or verification failed.
    public var errors: [StripeConnectAccountRequirementsError]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As they become required, they appear in `currently_due` as well, and `current_deadline` becomes set.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by `current_deadline`. These fields need to be collected to enable the capability on the account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. Will be an empty array unless an asynchronous verification is pending. If verification fails, these fields move to `eventually_due`, `currently_due`, or `past_due`.
    public var pendingVerification: [String]?
}

public enum StripeCapabilitiesStatus: String, Codable {
    case active
    case inactive
    case pending
    case unrequested
}

public struct StripeCapabilitiesList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeCapability]?
}
