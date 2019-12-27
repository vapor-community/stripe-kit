//
//  AccountLink.swift
//  
//
//  Created by Andrew Edwards on 11/3/19.
//

import Foundation

/// The [Account Link Object](https://stripe.com/docs/api/account_links/object).
public struct AccountLink: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The timestamp at which this account link will expire.
    public var expiresAt: Date?
    /// The URL for the account link.
    public var url: String?
}

public enum AccountLinkCreationType: String, StripeModel {
    case customAccountVerification = "custom_account_verification"
    case customAccountUpdate = "custom_account_update"
}

public enum AccountLinkCreationCollectType: String, StripeModel {
    case currentlyDue = "currently_due"
    case eventuallyDue = "eventually_due"
}
