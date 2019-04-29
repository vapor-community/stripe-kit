//
//  BillingDetails.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

public struct StripeBillingDetails: StripeModel {
    /// Billing address.
    public var address: StripeAddress?
    /// Email address.
    public var email: String?
    /// Full name.
    public var name: String?
    /// Billing phone number (including extension).
    public var phone: String?
}
