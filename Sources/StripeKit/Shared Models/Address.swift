//
//  Address.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public struct StripeAddress: Codable {
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

public struct StripeAddressKana: Codable {
    /// City/Ward
    public var city: String?
    /// Two-letter country code (ISO 3166-1 alpha-2).
    public var country: String?
    /// Block/Building number.
    public var line1: String?
    /// Building details.
    public var line2: String?
    /// Zip/Postal Code
    public var postalCode: String?
    /// Prefecture
    public var state: String?
    /// Town/cho-me
    public var town: String?
}

public struct StripeAddressKanji: Codable {
    /// City/Ward
    public var city: String?
    /// Two-letter country code (ISO 3166-1 alpha-2).
    public var country: String?
    /// Block/Building number.
    public var line1: String?
    /// Building details.
    public var line2: String?
    /// Zip/Postal Code
    public var postalCode: String?
    /// Prefecture
    public var state: String?
    /// Town/cho-me
    public var town: String?
}
