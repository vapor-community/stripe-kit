//
//  Mandate.swift
//  
//
//  Created by Andrew Edwards on 11/23/19.
//

import Foundation

public struct StripeMandate: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Details about the customer’s acceptance of the mandate.
    public var customerAcceptance: StripeMandateCustomerAcceptance?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// If this is a multi_use mandate, this hash contains details about the mandate.
    public var multiUse: String?
    /// ID of the payment method associated with this mandate.
    public var paymentMethod: String?
    /// Additional mandate information specific to the payment method type.
    public var paymentMethodDetails: StripeMandatePaymentMethodDetails?
    /// If this is a single_use mandate, this hash contains details about the mandate.
    public var singleUse: StripeMandateSingleUse?
    /// The status of the Mandate, one of `active`, `inactive`, or `pending`. The Mandate can be used to initiate a payment only if status=active.
    public var status: StripeMandateStatus?
    /// The type of the mandate, one of `multi_use` or `single_use`.
    public var type: StripeMandateType?
}

public struct StripeMandateCustomerAcceptance: StripeModel {
    /// The time at which the customer accepted the Mandate.
    public var acceptedAt: Date?
    /// If this is a Mandate accepted offline, this hash contains details about the offline acceptance.
    public var offline: String?
    /// If this is a Mandate accepted online, this hash contains details about the online acceptance.
    public var online: StripeMandateCustomerAcceptanceOnline?
    /// The type of customer acceptance information included with the Mandate. One of online or offline.
    public var type: StripeMandateCustomerAcceptanceType?
}

public struct StripeMandateCustomerAcceptanceOnline: StripeModel {
    /// The IP address from which the Mandate was accepted by the customer
    public var ipAddress: String?
    /// The user agent of the browser from which the Mandate was accepted by the customer.
    public var userAgent: String?
}

public enum StripeMandateCustomerAcceptanceType: String, StripeModel {
    case online
    case offline
}

public struct StripeMandatePaymentMethodDetails: StripeModel {
    /// If this mandate is associated with a card payment method, this hash contains mandate information specific to the card payment method.
    public var card: StripePaymentMethodCard?
    /// If this mandate is associated with a `sepa_debit` payment method, this hash contains mandate information specific to the `sepa_debit` payment method.
    public var sepaDebit: String?
    /// The type of the payment method associated with this mandate. An additional hash is included on `payment_method_details` with a name matching this value. It contains mandate information specific to the payment method.
    public var type: StripePaymentMethodType?
}

public struct StripeMandateSingleUse: StripeModel {
    /// On a single use mandate, the amount of the payment.
    public var amount: Int?
    /// On a single use mandate, the currency of the payment.
    public var currency: StripeCurrency?
}

public enum StripeMandateStatus: String, StripeModel {
    case active
    case inactive
    case pending
}

public enum StripeMandateType: String, StripeModel {
    case multiUse = "multi_use"
    case singleUse = "single_use"
}
