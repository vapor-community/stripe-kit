//
//  CountrySpec.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import Foundation
/// Stripe needs to collect certain pieces of information about each account created. These requirements can differ depending on the account's country. The Country Specs API makes these rules available to your integration.
public struct StripeCountrySpec: Codable {
    /// Unique identifier for the object. Represented as the ISO country code for this country.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
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
    /// Lists the types of verification data needed to keep an account open.
    public var verificationFields: StripeCountrySpecVerificationFields?
}

public struct StripeCountrySpecList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeCountrySpec]?
}

public struct StripeCountrySpecVerificationFields: Codable {
    /// Verification types for company account.
    public var company: StripeCountrySpecVerificationFieldsAttributes?
    /// Verification types for individual account.
    public var individual: StripeCountrySpecVerificationFieldsAttributes?
}

public struct StripeCountrySpecVerificationFieldsAttributes: Codable {
    /// Additional fields which are only required for some users.
    public var additional: [String]?
    /// Fields which every account must eventually provide.
    public var minimum: [String]?
}
