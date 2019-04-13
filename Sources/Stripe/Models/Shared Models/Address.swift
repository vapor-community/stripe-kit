//
//  Address.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public struct StripeAddress: StripeModel {
    /// City/District/Suburb/Town/Village.
    public var city: String?
    /// 2-letter country code.
    public var country: String?
    /// Address line 1 (Street address/PO Box/Company name).
    public var line1: String?
    /// Address line 2 (Apartment/Suite/Unit/Building).
    public var line2: String?
    /// ZIP or postal code.
    public var postalCode: String?
    /// State/County/Province/Region.
    public var state: String?
}
