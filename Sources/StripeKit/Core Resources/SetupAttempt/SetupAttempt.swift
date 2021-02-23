//
//  SetupAttempt.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import Foundation

public struct StripeSetupAttempt: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The value of application on the SetupIntent at the time of this confirmation.
    public var application: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The value of customer on the SetupIntent at the time of this confirmation.
    @Expandable<StripeCustomer> public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The value of `on_behalf_of` on the SetupIntent at the time of this confirmation.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// ID of the payment method used with this SetupAttempt.
    @Expandable<StripePaymentMethod> public var paymentMethod: String?
    /// Details about the payment method at the time of SetupIntent confirmation.
    public var paymentMethodDetails:
    /// The error encountered during this attempt to confirm the SetupIntent, if any.
    public var setupError: _StripeError?
    /// ID of the SetupIntent that this attempt belongs to.
    @Expandable<StripeSetupIntent> public var setupIntent: String?
    /// Status of this SetupAttempt, one of `requires_confirmation`, `requires_action`, `processing`, `succeeded`, `failed`, or `abandoned`.
    public var status: StripeSetupAttemptStatus?
    /// The value of usage on the SetupIntent at the time of this confirmation, one of `off_session` or `on_session`.
    public var usage: StripeSetupAttemptUsage?
}

public struct StripeSetupAttemptPaymentMethodDetails: StripeModel {
    public var auBecsDebit: StripeSetupAttemptPaymentMethodDetailsAuBecsDebit?
    /// If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
    public var bacsDebit: StripeSetupAttemptPaymentMethodDetailsBacsDebit?
    /// If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
    public var bancontact: StripeSetupAttemptPaymentMethodDetailsBancontact?
    /// Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    public var billingDetails: StripeBillingDetails?
    /// If this is a `card` PaymentMethod, this hash contains details about the card.
    public var card: StripePaymentMethodCard?
    /// If this is an `card_present` PaymentMethod, this hash contains details about the Card Present payment method.
    public var cardPresent: StripePaymentMethodCardPresent?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The ID of the Customer to which this PaymentMethod is saved. This will not be set when the PaymentMethod has not been saved to a Customer.
    @Expandable<StripeCustomer> public var customer: String?
    /// If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method.
    public var eps: StripePaymentMethodEps?
    /// If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method.
    public var fpx: StripePaymentMethodFpx?
    /// If this is an `giropay` PaymentMethod, this hash contains details about the Giropay payment method.
    public var giropay: StripePaymentMethodGiropay?
    /// If this is an `ideal` PaymentMethod, this hash contains details about the iDEAL payment method.
    public var ideal: StripePaymentMethodIdeal?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If this is an oxxo PaymentMethod, this hash contains details about the OXXO payment method.
    public var oxxo: StripePaymentMethodOXXO?
    /// If this is a `p24` PaymentMethod, this hash contains details about the P24 payment method.
    public var p24: StripePaymentMethodP24?
    /// If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    public var sepaDebit: StripePaymentMethodSepaDebit?
    /// If this is a sofort PaymentMethod, this hash contains details about the SOFORT payment method.
    public var sofort: StripePaymentMethodSofort?
    /// The type of the PaymentMethod, one of `card` or `card_present`. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
    public var type: StripePaymentMethodType?
}

public struct StripeSetupAttemptPaymentMethodDetailsAuBecsDebit: StripeModel {
}
public struct StripeSetupAttemptPaymentMethodDetailsBacsDebit: StripeModel {
}
public struct StripeSetupAttemptPaymentMethodDetailsBancontact: StripeModel {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<StripePaymentMethodSepaDebit> public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    public var
}

public enum StripeSetupAttemptStatus: String, StripeModel {
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case succeeded
    case failed
    case abandoned
}

public struct StripeSetupAttemptList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSetupAttempt]?
}

public enum StripeSetupAttemptUsage: String, StripeModel {
    case offSession = "off_session"
    case onSession = "on_session"
}
