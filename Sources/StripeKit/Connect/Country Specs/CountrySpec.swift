//
//  CountrySpec.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import Foundation
/// Stripe needs to collect certain pieces of information about each account created. These requirements can differ depending on the account's country. The Country Specs API makes these rules available to your integration.
public struct CountrySpec: Codable {
    /// Unique identifier for the object. Represented as the ISO country code for this country.
    public var id: String
    /// The default currency for this country. This applies to both payment methods and bank accounts.
    public var defaultCurrency: Currency?
    /// Currencies that can be accepted in the specific country (for transfers).
    public var supportedBankAccountCurrencies: [String: [String]]?
    /// Currencies that can be accepted in the specified country (for payments).
    public var supportedPaymentCurrencies: [Currency]?
    /// Payment methods available in the specified country. You may need to enable some payment methods (e.g., [ACH](https://stripe.com/docs/ach)) on your account before they appear in this list. The `stripe` payment method refers to [charging through your platform](https://stripe.com/docs/connect/destination-charges).
    public var supportedPaymentMethods: [String]?
    /// Countries that can accept transfers from the specified country.
    public var supportedTransferCountries: [String]?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Lists the types of verification data needed to keep an account open.
    public var verificationFields: CountrySpecVerificationFields?
    
    public init(id: String,
                defaultCurrency: Currency? = nil,
                supportedBankAccountCurrencies: [String : [String]]? = nil,
                supportedPaymentCurrencies: [Currency]? = nil,
                supportedPaymentMethods: [String]? = nil,
                supportedTransferCountries: [String]? = nil,
                object: String,
                verificationFields: CountrySpecVerificationFields? = nil) {
        self.id = id
        self.defaultCurrency = defaultCurrency
        self.supportedBankAccountCurrencies = supportedBankAccountCurrencies
        self.supportedPaymentCurrencies = supportedPaymentCurrencies
        self.supportedPaymentMethods = supportedPaymentMethods
        self.supportedTransferCountries = supportedTransferCountries
        self.object = object
        self.verificationFields = verificationFields
    }
}

public struct CountrySpecList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [CountrySpec]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [CountrySpec]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public struct CountrySpecVerificationFields: Codable {
    /// Verification types for company account.
    public var company: CountrySpecVerificationFieldsAttributes?
    /// Verification types for individual account.
    public var individual: CountrySpecVerificationFieldsAttributes?
    
    public init(company: CountrySpecVerificationFieldsAttributes? = nil, individual: CountrySpecVerificationFieldsAttributes? = nil) {
        self.company = company
        self.individual = individual
    }
}

public struct CountrySpecVerificationFieldsAttributes: Codable {
    /// Additional fieCountrySpecy required for some users.
    public var additional: [String]?
    /// Fields which every account must eventually provide.
    public var minimum: [String]?
    
    public init(additional: [String]? = nil, minimum: [String]? = nil) {
        self.additional = additional
        self.minimum = minimum
    }
}
