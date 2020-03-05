//
//  Capabilities.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import Foundation

public struct StripeCapability: StripeModel {
    /// The identifier for the capability.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The account for which the capability enables functionality.
    public var account: String?
    /// Whether the capability has been requested.
    public var requested: Bool?
    /// Time at which the capability was requested. Measured in seconds since the Unix epoch.
    public var requestedAt: Date?
    /// The status of the capability. Can be active, inactive, pending, or unrequested.
    public var status: StripeCapabilitiesStatus?
}

public struct StripeCapabilitiesRequirements: StripeModel {
    /// The date the fields in `currently_due` must be collected by to keep the capability enabled for the account.
    public var currentDeadline: Date?
    /// The fields that need to be collected to keep the capability enabled. If not collected by the `current_deadline`, these fields appear in `past_due` as well, and the capability is disabled.
    public var currentlyDue: [String]?
    /// If the capability is disabled, this string describes why. Possible values are `requirement.fields_needed`, `pending.onboarding`, `pending.review`, `rejected_fraud`, or `rejected.other`.
    public var disabledReason: String?
    /// The fields that need to be collected assuming all volume thresholds are reached. As they become required, these fields appear in `currently_due` as well, and the `current_deadline` is set.
    public var eventuallyDue: [String]?
    /// The fields that weren’t collected by the `current_deadline`. These fields need to be collected to enable the capability for the account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. An empty array unless an asynchronous verification is pending. If verification fails, the fields in this array become required and move to `currently_due` or `past_due`.
    public var pendingVerification: [String]?
}

public enum StripeCapabilitiesStatus: String, StripeModel {
    case active
    case inactive
    case pending
    case unrequested
}

public struct StripeCapabilitiesList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeCapability]?
    
    public enum CodingKeys: String, CodingKey {
        case object, url, data
        case hasMore = "has_more"
    }
}
