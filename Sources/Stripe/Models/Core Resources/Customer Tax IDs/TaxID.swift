//
//  TaxID.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/11/19.
//

import Foundation

/// The [Tax ID Object](https://stripe.com/docs/api/customer_tax_ids/object).
public struct StripeTaxID: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Two-letter ISO code representing the country of the tax ID.
    public var country: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// ID of the customer.
    public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Type of the tax ID, one of `eu_vat`, `nz_gst`, `au_abn`, or `unknown`
    public var type: StripeTaxIDType?
    /// Tax ID verification information.
    public var verification: StripeTaxIDVerififcation?
}

public enum StripeTaxIDType: String, StripeModel {
    case euVat = "eu_vat"
    case nzGst = "nz_gst"
    case auAbn = "au_abn"
    case unknown
}

public struct StripeTaxIDVerififcation: StripeModel {
    /// Verification status, one of `pending`, `unavailable`, `unverified`, or `verified`.
    public var status: StripeTaxIDVerififcationStatus?
    /// Verified address.
    public var verifiedAddress: String?
    /// Verified name.
    public var verifiedName: String?
}

public enum StripeTaxIDVerififcationStatus: String, StripeModel {
    case pending
    case unavailable
    case unverified
    case verified
}

public struct StripeTaxIDList: StripeModel {
    public var object: String
    public var url: String?
    public var hasMore: Bool?
    public var data: [StripeTaxID]?
}
