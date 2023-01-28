//
//  TaxID.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/11/19.
//

import Foundation

/// The [Tax ID Object](https://stripe.com/docs/api/customer_tax_ids/object).
public struct StripeTaxID: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Two-letter ISO code representing the country of the tax ID.
    public var country: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// ID of the customer.
    @Expandable<StripeCustomer> public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Type of the tax ID, one of `eu_vat`, `nz_gst`, `au_abn`, or `unknown`
    public var type: StripeTaxIDType?
    /// Value of the tax ID.
    public var value: String?
    /// Tax ID verification information.
    public var verification: StripeTaxIDVerififcation?
}

public enum StripeTaxIDType: String, Codable {
    case ae_trn
    case au_abn
    case br_cnpj
    case br_cpf
    case ca_bn
    case ca_qst
    case ch_vat
    case cl_tin
    case es_cif
    case eu_vat
    case gb_vat
    case hk_br
    case id_npwp
    case in_gst
    case jp_cn
    case jp_rn
    case kr_brn
    case li_uid
    case mx_rfc
    case my_frp
    case my_itn
    case my_sst
    case no_vat
    case nz_gst
    case ru_inn
    case ru_kpp
    case sa_vat
    case sg_gst
    case sg_uen
    case th_vat
    case tw_vat
    case us_ein
    case za_vat
    case unknown
}

public struct StripeTaxIDVerififcation: Codable {
    /// Verification status, one of `pending`, `unavailable`, `unverified`, or `verified`.
    public var status: StripeTaxIDVerififcationStatus?
    /// Verified address.
    public var verifiedAddress: String?
    /// Verified name.
    public var verifiedName: String?
}

public enum StripeTaxIDVerififcationStatus: String, Codable {
    case pending
    case unavailable
    case unverified
    case verified
}

public struct StripeTaxIDList: Codable {
    public var object: String
    public var url: String?
    public var hasMore: Bool?
    public var data: [StripeTaxID]?
}
