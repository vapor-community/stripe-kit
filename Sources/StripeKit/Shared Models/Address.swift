//
//  Address.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public struct Address: Codable {
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
    
    public init(city: String? = nil,
                country: String? = nil,
                line1: String? = nil,
                line2: String? = nil,
                postalCode: String? = nil,
                state: String? = nil) {
        self.city = city
        self.country = country
        self.line1 = line1
        self.line2 = line2
        self.postalCode = postalCode
        self.state = state
    }
}

public struct AddressKana: Codable {
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
    
    public init(city: String? = nil,
                country: String? = nil,
                line1: String? = nil,
                line2: String? = nil,
                postalCode: String? = nil,
                state: String? = nil,
                town: String? = nil) {
        self.city = city
        self.country = country
        self.line1 = line1
        self.line2 = line2
        self.postalCode = postalCode
        self.state = state
        self.town = town
    }
}

public struct AddressKanji: Codable {
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
    
    public init(city: String? = nil,
                country: String? = nil,
                line1: String? = nil,
                line2: String? = nil,
                postalCode: String? = nil,
                state: String? = nil,
                town: String? = nil) {
        self.city = city
        self.country = country
        self.line1 = line1
        self.line2 = line2
        self.postalCode = postalCode
        self.state = state
        self.town = town
    }
}
