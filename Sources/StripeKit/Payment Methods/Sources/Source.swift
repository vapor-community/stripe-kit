//
//  Source.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/// The [Source Object](https://stripe.com/docs/api/sources/object).
public struct StripeSource: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount associated with the source. This is the amount for which the source will be chargeable once ready. Required for `single_use` sources.
    public var amount: Int?
    /// The client secret of the source. Used for client-side retrieval using a publishable key.
    public var clientSecret: String?
    /// Information related to the code verification flow. Present if the source is authenticated by a verification code (`flow` is `code_verification`).
    public var codeVerification: StripeSourceCodeVerification?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO code for the currency associated with the source. This is the currency for which the source will be chargeable once ready. Required for `single_use` sources.
    public var currency: Currency?
    /// The ID of the customer to which this source is attached. This will not be present when the source has not been attached to a customer.
    public var customer: String?
    /// The authentication flow of the source. flow is one of `redirect`, `receiver`, `code_verification`, `none`.
    public var flow: StripeSourceFlow?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Information about the owner of the payment instrument that may be used or required by particular source types.
    public var owner: StripeSourceOwner?
    /// Information related to the receiver flow. Present if the source is a receiver (`flow` is `receiver`).
    public var receiver: StripeSourceReceiver?
    /// Information related to the redirect flow. Present if the source is authenticated by a redirect (`flow` is `redirect`).
    public var redirect: StripeSourceRedirect?
    /// Extra information about a source. This will appear on your customer’s statement every time you charge the source.
    public var statementDescriptor: String?
    /// The status of the source, one of `canceled`, `chargeable`, `consumed`, `failed`, or `pending`. Only `chargeable` sources can be used to create a charge.
    public var status: StripeSourceStatus?
    /// The type of the source. The type is a payment method, one of ach_credit_transfer, ach_debit, alipay, bancontact, card, card_present, eps, giropay, ideal, multibanco, p24, sepa_debit, sofort, three_d_secure, or wechat. An additional hash is included on the source with a name matching this value. It contains additional information specific to the payment method used.
    public var type: StripeSourceType?
    /// Either `reusable` or `single_use`. Whether this source should be reusable or not. Some source types may or may not be reusable by construction, while others may leave the option at creation. If an incompatible value is passed, an error will be returned.
    public var usage: StripeSourceUsage?
    
    public var achCreditTransfer: StripeSourceACHCreditTransfer?
    public var achDebit: StripeSourceACHDebit?
    public var alipay: StripeSourceAlipay?
    public var bancontact: StripeSourceBancontact?
    public var card: StripeSourceCard?
    public var cardPresent: StripeSourceCardPresent?
    public var eps: StripeSourceEPS?
    public var giropay: StripeSourceGiropay?
    public var ideal: StripeSourceIDEAL?
    public var multibanco: StripeSourceMultibanco?
    public var p24: StripeSourceP24?
    public var sepaDebit: StripeSourceSepaDebit?
    public var sofort: StripeSourceSofort?
    public var threeDSecure: StripeSourceThreeDSecure?
    public var wechat: StripeSourceWechat?
}

public struct StripeSourceCodeVerification: Codable {
    /// The number of attempts remaining to authenticate the source object with a verification code.
    public var attemptsRemaining: Int?
    /// The status of the code verification, either `pending` (awaiting verification, `attempts_remaining` should be greater than 0), `succeeded` (successful verification) or `failed` (failed verification, cannot be verified anymore as `attempts_remaining` should be 0).
    public var status: StripeSourceCodeVerificationStatus?
}

public enum StripeSourceCodeVerificationStatus: String, Codable {
    case pending
    case succeeded
    case failed
}

public enum StripeSourceFlow: String, Codable {
    case redirect
    case receiver
    case codeVerification = "code_verification"
    case none
}

public struct StripeSourceOwner: Codable {
    /// Owner’s address.
    public var address: Address?
    /// Owner’s email address.
    public var email: String?
    /// Owner’s full name.
    public var name: String?
    /// Owner’s phone number (including extension).
    public var phone: String?
    /// Verified owner’s address. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedAddress: Address?
    /// Verified owner’s email address. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedEmail: String?
    /// Verified owner’s full name. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    /// Verified owner’s phone number (including extension). Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedPhone: String?
}

public struct StripeSourceReceiver: Codable {
    /// The address of the receiver source. This is the value that should be communicated to the customer to send their funds to.
    public var address: String?
    /// The total amount that was charged by you. The amount charged is expressed in the source’s currency.
    public var amountCharged: Int?
    /// The total amount received by the receiver source. `amount_received = amount_returned + amount_charged` is true at all time. The amount received is expressed in the source’s currency.
    public var amountReceived: Int?
    /// The total amount that was returned to the customer. The amount returned is expressed in the source’s currency.
    public var amountReturned: Int?
    /// Type of refund attribute method, one of `email`, `manual`, or `none`.
    public var refundAttributesMethod: StripeSourceReceiverRefundAttributesMethod?
    /// Type of refund attribute status, one of `missing`, `requested`, or `available`.
    public var refundAttributesStatus: StripeSourceReceiverRefundAttributesStatus?
}

public enum StripeSourceReceiverRefundAttributesMethod: String, Codable {
    case email
    case manual
    case none
}

public enum StripeSourceReceiverRefundAttributesStatus: String, Codable {
    case missing
    case requested
    case available
}

public struct StripeSourceRedirect: Codable {
    /// The failure reason for the redirect, either `user_abort` (the customer aborted or dropped out of the redirect flow), `declined` (the authentication failed or the transaction was declined), or `processing_error` (the redirect failed due to a technical error). Present only if the redirect status is `failed`.
    public var failureReason: StripeSourceRedirectFailureReason?
    /// The URL you provide to redirect the customer to after they authenticated their payment.
    public var returnUrl: String?
    /// The status of the redirect, either `pending` (ready to be used by your customer to authenticate the transaction), `succeeded` (succesful authentication, cannot be reused) or `not_required` (redirect should not be used) or `failed` (failed authentication, cannot be reused).
    public var status: StripeSourceRedirectReason?
    /// The URL provided to you to redirect a customer to as part of a `redirect` authentication flow.
    public var url: String?
}

public enum StripeSourceRedirectFailureReason: String, Codable {
    case userAbort = "user_abort"
    case declined
    case processingError = "processing_error"
    case failed
}

public enum StripeSourceRedirectReason: String, Codable {
    case pending
    case succeeded
    case notRequired = "not_required"
    case failed
}

public enum StripeSourceStatus: String, Codable {
    case canceled
    case chargeable
    case consumed
    case failed
    case pending
}

public enum StripeSourceType: String, Codable {
    case achCreditTransfer = "ach_credit_transfer"
    case achDebit = "ach_debit"
    case alipay
    case bancontact
    case card
    case cardPresent = "card_present"
    case eps
    case giropay
    case ideal
    case multibanco
    case p24
    case sepaDebit = "sepa_debit"
    case sofort
    case threeDSecure = "three_d_secure"
    case wechat
}

public enum StripeSourceUsage: String, Codable {
    case reusable
    case singleUse = "single_use"
}

// MARK: - Sources
public struct StripeSourceACHCreditTransfer: Codable {
    public var accountNumber: String?
    public var bankName: String?
    public var fingerprint: String?
    public var routingNumber: String?
    public var swiftCode: String?
}

public struct StripeSourceACHDebit: Codable {
    public var bankName: String?
    public var country: String?
    public var fingerprint: String?
    public var last4: String?
    public var routingNumber: String?
    public var type: String?
}

public struct StripeSourceAlipay: Codable {
    public var nativeUrl: String?
    public var statementDescriptor: String?
}

public struct StripeSourceBancontact: Codable {
    public var bankCode: String?
    public var bankName: String?
    public var bic: String?
    public var ibnLast4: String?
    public var preferredLanguage: String?
}

public struct StripeSourceCard: Codable {
    public var addressLine1Check: String?
    public var addressZipCheck: String?
    public var brand: StripeCardBrand?
    public var country: String?
    public var cvcCheck: String?
    public var dynamicLast4: String?
    public var expMonth: Int?
    public var expYear: Int?
    public var fingerprint: String?
    public var funding: StripeCardFundingType?
    public var last4: String?
    public var name: String?
    public var threeDSecure: String?
    public var tokenizationMethod: String?
}

public struct StripeSourceCardPresent: Codable {
    public var applicationCryptogram: String?
    public var applicationPreferredName: String?
    public var authorizationCode: String?
    public var authorizationResponseCode: String?
    public var brand: StripeCardBrand?
    public var country: String?
    public var cvmType: String?
    public var dataType: String?
    public var dedicatedFileName: String?
    public var emvAuthdata: String?
    public var evidenceCustomerSignature: String?
    public var evidenceTransactionCertificate: String?
    public var expMonth: Int?
    public var expyear: Int?
    public var fingerprint: String?
    public var funding: StripeCardFundingType?
    public var last4: String?
    public var posDeviceId: String?
    public var posEntryMode: String?
    public var readMethod: String?
    public var reader: String?
    public var terminalVerificationResults: String?
    public var transactionStatusInformation: String?
}

public struct StripeSourceEPS: Codable {
    // The Eps sources do not have any specific property today.
    // The only ones available in the spec are for private betas.
}

public struct StripeSourceGiropay: Codable {
    public var bankCode: String?
    public var bic: String?
    public var bankName: String?
}

public struct StripeSourceIDEAL: Codable {
    public var bank: String?
    public var bic: String?
    public var ibanLast4: String?
}

public struct StripeSourceMultibanco: Codable {
    public var entity: String?
    public var reference: String?
}

public struct StripeSourceP24: Codable {
    public var reference: String?
}

public struct StripeSourceSepaDebit: Codable {
    public var bankCode: String?
    public var branchCode: String?
    public var country: String?
    public var fingerprint: String?
    public var last4: String?
    public var mandateReference: String?
    public var mandateUrl: String?
}

public struct StripeSourceSofort: Codable {
    public var bankCode: String?
    public var bankName: String?
    public var bic: String?
    public var country: String?
    public var ibanLast4: String?
    public var verifiedName: String?
}

public struct StripeSourceThreeDSecure: Codable {
    public var addressLine1Check: String?
    public var addressZipCheck: String?
    public var authenticated: Bool?
    public var brand: StripeCardBrand?
    public var card: String?
    public var country: String?
    public var customer: String?
    public var cvcCheck: String?
    public var dynamicLast4: String?
    public var expMonth: Int?
    public var expYear: Int?
    public var fingerprint: String?
    public var funding: StripeCardFundingType?
    public var last4: String?
    public var threedSecure: StripeSourceThreeDSecureSupportStatus?
    public var tokenizationMethod: StripeCardTokenizedMethod?
}

public enum StripeSourceThreeDSecureSupportStatus: String, Codable {
    case notSupported = "not_supported"
    case required
    case recommended
    case optional
}

public struct StripeSourceWechat: Codable {
    // Stripe has no offocial documentation details
    /// https://stripe.com/docs/api/charges/object#charge_object-payment_method_details-wechat
}

public struct StripeSourcesList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePaymentSource]?
}

extension StripeSourcesList {
    public var bankAccounts: [StripeBankAccount]? {
        return data?.compactMap { $0.bankAccount }
    }
    
    public var cards: [StripeCard]? {
        return data?.compactMap { $0.card }
    }
    
    public var sources: [StripeSource]? {
        return data?.compactMap { $0.source }
    }
}
