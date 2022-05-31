//
//  Charge.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/// The [Charge Object](https://stripe.com/docs/api/charges/object).
public struct StripeCharge: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A positive integer in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency) representing how much to charge. The minimum amount is $0.50 US or [equivalent in charge currency](https://support.stripe.com/questions/what-is-the-minimum-amount-i-can-charge-with-stripe).
    public var amount: Int?
    /// Amount in cents captured (can be less than the amount attribute on the charge if a partial capture was made).
    public var amountCaptured: Int?
    /// Amount in cents refunded (can be less than the amount attribute on the charge if a partial refund was issued).
    public var amountRefunded: Int?
    /// ID of the Connect application that created the charge.
    public var application: String?
    /// The application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.
    @Expandable<StripeApplicationFee> public var applicationFee: String?
    /// The amount of the application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.
    public var applicationFeeAmount: Int?
    /// ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes).
    @Expandable<StripeBalanceTransaction> public var balanceTransaction: String?
    /// Billing information associated with the payment method at the time of the transaction.
    public var billingDetails: StripeBillingDetails?
    /// The full statement descriptor that is passed to card networks, and that is displayed on your customers’ credit card and bank statements. Allows you to see what the statement descriptor looks like after the static and dynamic portions are combined.
    public var calculatedStatementDescriptor: String?
    /// If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured.
    public var captured: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// ID of the customer this charge is for if one exists.
    @Expandable<StripeCustomer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Details about the dispute if the charge has been disputed.
    public var dispute: String?
    /// Whether the charge has been disputed.
    public var disputed: Bool?
    /// Error code explaining reason for charge failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).
    public var failureCode: String?
    /// Message to user further explaining reason for charge failure if available.
    public var failureMessage: String?
    /// Information on fraud assessments for the charge.
    public var fraudDetails: StripeChargeFraudDetails?
    /// ID of the invoice this charge is for if one exists.
    @Expandable<StripeInvoice> public var invoice: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The account (if any) the charge was made on behalf of without triggering an automatic transfer. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers) for details.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// ID of the order this charge is for if one exists.
    @Expandable<StripeOrder> public var order: String?
    /// Details about whether the payment was accepted, and why. See [understanding declines](https://stripe.com/docs/declines) for details.
    public var outcome: StripeChargeOutcome?
    /// `true` if the charge succeeded, or was successfully authorized for later capture.
    public var paid: Bool?
    /// ID of the PaymentIntent associated with this charge, if one exists.
    @Expandable<StripePaymentIntent> public var paymentIntent: String?
    /// ID of the payment method used in this charge.
    public var paymentMethod: String?
    /// Details about the payment method at the time of the transaction.
    public var paymentMethodDetails: StripeChargePaymentDetails?
    /// This is the email address that the receipt for this charge was sent to.
    public var receiptEmail: String?
    /// This is the transaction number that appears on email receipts sent for this charge. This attribute will be `null` until a receipt has been sent.
    public var receiptNumber: String?
    /// This is the URL to view the receipt for this charge. The receipt is kept up-to-date to the latest state of the charge, including any refunds. If the charge is for an Invoice, the receipt will be stylized as an Invoice receipt.
    public var receiptUrl: String?
    /// Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
    public var refunded: Bool?
    /// A list of refunds that have been applied to the charge.
    public var refunds: StripeRefundsList
    /// ID of the review associated with this charge if one exists.
    @Expandable<StripeReview> public var review: String?
    /// Shipping information for the charge.
    public var shipping: StripeShippingLabel?
    /// The transfer ID which created this charge. Only present if the charge came from another Stripe account. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    @Expandable<StripeTransfer> public var sourceTransfer: String?
    /// Extra information about a charge. This will appear on your customer’s credit card statement. It must contain at least one letter.
    public var statementDescriptor: String?
    /// Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    public var statementDescriptorSuffix: String?
    /// The status of the payment is either `succeeded`, `pending`, or `failed`.
    public var status: StripeChargeStatus?
    /// ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination` parameter).
    @Expandable<StripeTransfer> public var transfer: String?
    /// An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    public var transferData: StripeChargeTransferData?
    /// A string that identifies this transaction as part of a group. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
    public var transferGroup: String?
}

public struct StripeChargeFraudDetails: StripeModel {
    /// Assessments reported by you. If set, possible values of are `safe` and `fraudulent`.
    public var userReport: StripeChargeFraudDetailsReportType?
    /// Assessments from Stripe. If set, the value is `fraudulent`.
    public var stripeReport: StripeChargeFraudDetailsReportType?
}

public enum StripeChargeFraudDetailsReportType: String, StripeModel {
    case safe
    case fraudulent
}

public struct StripeChargeOutcome: StripeModel {
    /// Possible values are `approved_by_network`, `declined_by_network`, `not_sent_to_network`, and `reversed_after_approval`. The value `reversed_after_approval` indicates the payment was [blocked by Stripe](https://stripe.com/docs/declines#blocked-payments) after bank authorization, and may temporarily appear as “pending” on a cardholder’s statement.
    public var networkStatus: StripeChargeOutcomeNetworkStatus?
    /// An enumerated value providing a more detailed explanation of the outcome’s `type`. Charges blocked by Radar’s default block rule have the value `highest_risk_level`. Charges placed in review by Radar’s default review rule have the value `elevated_risk_level`. Charges authorized, blocked, or placed in review by custom rules have the value `rule`. See [understanding declines](https://stripe.com/docs/declines) for more details.
    public var reason: String?
    /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are `normal`, `elevated`, `highest`. For non-card payments, and card-based payments predating the public assignment of risk levels, this field will have the value `not_assessed`. In the event of an error in the evaluation, this field will have the value `unknown`.
    public var riskLevel: StripeChargeOutcomeRiskLevel?
    /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are between 0 and 100. For non-card payments, card-based payments predating the public assignment of risk scores, or in the event of an error during evaluation, this field will not be present. This field is only available with Radar for Fraud Teams.
    public var riskScore: Int?
    /// The ID of the Radar rule that matched the payment, if applicable.
    public var rule: String?
    /// A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not your customer.
    public var sellerMessage: String?
    /// Possible values are `authorized`, `manual_review`, `issuer_declined`, `blocked`, and `invalid`. See understanding declines and Radar reviews for details.
    public var type: StripeChargeOutcomeType?
}

public enum StripeChargeOutcomeNetworkStatus: String, StripeModel {
    case approvedByNetwork = "approved_by_network"
    case declinedByNetwork = "declined_by_network"
    case notSentToNetwork = "not_sent_to_network"
    case reversedAfterApproval = "reversed_after_approval"
}

public enum StripeChargeOutcomeRiskLevel: String, StripeModel {
    case normal
    case elevated
    case highest
    case notAssessed = "not_assessed"
    case unknown
}

public enum StripeChargeOutcomeType: String, StripeModel {
    case authorized
    case manualReview = "manual_review"
    case issuerDeclined = "issuer_declined"
    case blocked
    case invalid
}

public enum StripeChargeStatus: String, StripeModel {
    case succeeded
    case pending
    case failed
}

public struct StripeChargeTransferData: StripeModel {
    /// The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
    public var amount: Int?
    /// ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge request.
    public var destination: String?
}

public struct StripeChargesList: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    public var data: [StripeCharge]?
}

public struct StripeChargePaymentDetails: StripeModel {
    ///If this is a `ach_credit_transfer` payment, this hash contains a snapshot of the transaction specific details of the `ach_credit_transfer` payment method.
    public var achCreditTransfer: StripeChargePaymentDetailsACHCreditTransfer?
    /// If this is a `ach_debit` payment, this hash contains a snapshot of the transaction specific details of the `ach_debit` payment method.
    public var achDebit: StripeChargePaymentDetailsACHDebit?
    /// If this is a `afterpay_clearpay` payment, this hash contains a snapshot of the transaction specific details of the `afterpay_clearpay` payment method.
    public var afterpayClearpay: StripeChargePaymentDetailsAfterpayClearpay?
    /// If this is a `alipay` payment, this hash contains a snapshot of the transaction specific details of the `alipay` payment method.
    public var alipay: StripeChargePaymentDetailsAlipay?
    /// If this is a `au_becs_debit` payment, this hash contains a snapshot of the transaction specific details of the `au_becs_debit` payment method.
    public var auBecsDebit: StripeChargePaymentDetailsAuBecsDebit?
    /// If this is a `bacs_debit` payment, this hash contains a snapshot of the transaction specific details of the bacs_debit payment method.
    public var bacsDebit: StripeChargePaymentDetailsBacsDebit?
    /// If this is a `bancontact` payment, this hash contains a snapshot of the transaction specific details of the `bancontact` payment method.
    public var bancontact: StripeChargePaymentDetailsBancontact?
    /// If this is a `card` payment, this hash contains a snapshot of the transaction specific details of the `card` payment method.
    public var card: StripeChargePaymentDetailsCard?
    /// If this is a `card_present` payment, this hash contains a snapshot of the transaction specific details of the `card_present` payment method.
    public var cardPresent: StripeChargePaymentDetailsCardPresent?
    /// If this is a `eps` payment, this hash contains a snapshot of the transaction specific details of the `eps` payment method.
    public var eps: StripeChargePaymentDetailsEPS?
    /// If this is a `fpx` payment, this hash contains a snapshot of the transaction specific details of the `fpx` payment method.
    public var fpx: StripeChargePaymentDetailsFpx?
    /// If this is a `grabpay` payment, this hash contains a snapshot of the transaction specific details of the `grabpay` payment method.
    public var grabpay: StripeChargePaymentDetailsGrabpay?
    /// If this is a `giropay` payment, this hash contains a snapshot of the transaction specific details of the `giropay` payment method.
    public var giropay: StripeChargePaymentDetailsGiropay?
    /// If this is a `ideal` payment, this hash contains a snapshot of the transaction specific details of the `ideal` payment method.
    public var ideal: StripeChargePaymentDetailsIdeal?
    /// If this is a `interac_present` payment, this hash contains a snapshot of the transaction specific details of the `interac_present` payment method.
    public var interacPresent: StripeChargePaymentDetailsInteracPresent?
    /// If this is a klarna payment, this hash contains a snapshot of the transaction specific details of the klarna payment method.
    public var klarna: StripeChargePaymentDetailsKlarna?
    /// If this is a `multibanco` payment, this hash contains a snapshot of the transaction specific details of the `multibanco` payment method.
    public var multibanco: StripeChargePaymentDetailsMultibanco?
    /// If this is a oxxo payment, this hash contains a snapshot of the transaction specific details of the oxxo payment method.
    public var oxxo: StripeChargePaymentDetailsOXXO?
    
    /// If this is a `p24` payment, this hash contains a snapshot of the transaction specific details of the `p24` payment method.
    public var p24: StripeChargePaymentDetailsP24?
    /// If this is a `sepa_debit` payment, this hash contains a snapshot of the transaction specific details of the `sepa_debit` payment method.
    public var sepaDebit: StripeChargePaymentDetailsSepaDebit?
    
    /// If this is a `sofort` payment, this hash contains a snapshot of the transaction specific details of the `sofort` payment method
    public var sofort: StripeChargePaymentDetailsSofort?
    /// If this is a `stripe_account` payment, this hash contains a snapshot of the transaction specific details of the `stripe_account` payment method
    public var stripeAccount: StripeChargePaymentDetailsStripeAccount?
    /// The type of transaction-specific details of the payment method used in the payment, one of `ach_credit_transfer`, `ach_debit`, `alipay`, `bancontact`, `card`, `card_present`, `eps`, `giropay`, `ideal`, `multibanco`, `p24`, `sepa_debit`, `sofort`, `stripe_account`, or `wechat`. An additional hash is included on `payment_method_details` with a name matching this value. It contains information specific to the payment method.
    public var type: StripeChargePaymentDetailsType?
    /// If this is a wechat payment, this hash contains a snapshot of the transaction specific details of the wechat payment method.
    public var wechat: StripeChargePaymentDetailsWechat?
}

public struct StripeChargePaymentDetailsACHCreditTransfer: StripeModel {
    /// Account number to transfer funds to.
    public var accountNumber: String?
    /// Name of the bank associated with the routing number.
    public var bankName: String?
    /// Routing transit number for the bank account to transfer funds to.
    public var routingNumber: String?
    /// SWIFT code of the bank associated with the routing number
    public var swiftCode: String?
}

public struct StripeChargePaymentDetailsACHDebit: StripeModel {
    /// Type of entity that holds the account. This can be either individual or company.
    public var accountHolderType: StripeChargePaymentDetailsACHDebitAccountHolderType?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Account number to transfer funds to.
    public var last4: String?
    /// Routing transit number for the bank account.
    public var routingNumber: String?
}

public enum StripeChargePaymentDetailsACHDebitAccountHolderType: String, StripeModel {
    case individual
    case company
}

public struct StripeChargePaymentDetailsAfterpayClearpay: StripeModel {
}

public struct StripeChargePaymentDetailsAlipay: StripeModel {
    /// Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same.
    public var buyerId: String?
    /// Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same.
    public var fingerprint: String?
    /// Transaction ID of this particular Alipay transaction.
    public var transactionId: String?
}

public struct StripeChargePaymentDetailsAuBecsDebit: StripeModel {
    /// Bank-State-Branch number of the bank account.
    public var bsbNumber: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// ID of the mandate used to make this payment.
    public var mandate: String?
}

public struct StripeChargePaymentDetailsBacsDebit: StripeModel {
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// ID of the mandate used to make this payment.
    public var mandate: String?
    /// Sort code of the bank account. (e.g., `10-20-30`)
    public var sortCode: String?
}

public struct StripeChargePaymentDetailsBancontact: StripeModel {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Preferred language of the Bancontact authorization page that the customer is redirected to. Can be one of `en`, `de`, `fr`, or `nl`
    public var preferredLanguage: StripeChargePaymentDetailsBancontactPreferredLanguage?
    /// Owner’s verified full name. Values are verified or provided by Bancontact directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
}

public enum StripeChargePaymentDetailsBancontactPreferredLanguage: String, StripeModel {
    case en
    case de
    case fr
    case nl
}

public struct StripeChargePaymentDetailsCard: StripeModel {
    /// Card brand. Can be `amex`, `diners`, `discover`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var brand: StripePaymentMethodCardBrand?
    /// Checks on Card address and CVC if provided.
    public var checks: StripePaymentMethodCardChecks?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: StripeCardFundingType?
    /// Installment details for this payment (Mexico only). For more information, see the [installments integration guide.](https://stripe.com/docs/payments/installments)
    public var installments: StripeChargePaymentDetailsCardInstallments?
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be `amex`, `diners`, `discover`, `interac`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var network: StripePaymentMethodCardNetwork?
    /// Contains details on how this Card maybe be used for 3D Secure authentication.
    public var threeDSecure: StripeChargePaymentDetailsCardThreeDSecure?
    /// If this Card is part of a card wallet, this contains the details of the card wallet.
    public var wallet: StripePaymentMethodCardWallet?
}

public struct StripeChargePaymentDetailsCardInstallments: StripeModel {
    /// Installment plan selected for the payment.
    public var plan: StripeChargePaymentDetailsCardInstallmentPlan?
}

public struct StripeChargePaymentDetailsCardInstallmentPlan: StripeModel {
    /// For `fixed_count` installment plans, this is the number of installment payments your customer will make to their credit card.
    public var count: Int?
    /// For `fixed_count` installment plans, this is the interval between installment payments your customer will make to their credit card. One of `month`.
    public var interval: StripePlanInterval?
    /// Type of installment plan, one of `fixed_count`.
    public var type: String?
}

public struct StripeChargePaymentDetailsCardThreeDSecure: StripeModel {
    /// Whether or not authentication was performed. 3D Secure will succeed without authentication when the card is not enrolled.
    public var authenticated: Bool?
    /// Whether or not 3D Secure succeeded.
    public var succeeded: Bool?
    /// The version of 3D Secure that was used for this payment.
    public var version: String?
}

public struct StripeChargePaymentDetailsCardPresent: StripeModel {
    /// The authorized amount
    public var authorizedAmount: Int?
    /// Card brand. Can be amex, diners, discover, jcb, mastercard, unionpay, visa, or unknown.
    public var brand: StripePaymentMethodCardBrand?
    /// When using manual capture, a future timestamp after which the charge will be automatically refunded if uncaptured.
    public var captureBefore: Date?
    /// The cardholder name as read from the card, in ISO 7813 format. May include alphanumeric characters, special characters and first/last name separator (/). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
    public var cardholderName: String?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Authorization response cryptogram.
    public var emvAuthData: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: StripeCardFundingType?
    /// ID of a card PaymentMethod generated from the `card_present` PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
    public var generatedCard: String?
    /// Whether this PaymentIntent is eligible for incremental authorizations.
    public var incrementalAuthorizationSupported: Bool?
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be `amex`, `diners`, `discover`, `interac`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var network: StripePaymentMethodCardNetwork?
    /// Defines whether the authorized amount can be over-captured or not
    public var overCaptureSupported: Bool?
    /// How were card details read in this transaction. Can be `contact_emv`, `contactless_emv`, `magnetic_stripe_fallback`, `magnetic_stripe_track2`, or `contactless_magstripe_mode`
    public var readMethod: StripeChargePaymentDetailsCardPresentReadMethod?
    /// A collection of fields required to be displayed on receipts. Only required for EMV transactions.
    public var receipt: StripeChargePaymentDetailsCardPresentReceipt?
}

public enum StripeChargePaymentDetailsCardPresentReadMethod: String, StripeModel {
    case contactEmv = "contact_emv"
    case contactlessEmv = "contactless_emv"
    case magneticStripeFallback = "magnetic_stripe_fallback"
    case magneticStripeTrack2 = "magnetic_stripe_track2"
    case contactlessMagstripeMode = "contactless_magstripe_mode"
}

public struct StripeChargePaymentDetailsCardPresentReceipt: StripeModel {
    /// The type of account being debited or credited
    public var accountType: StripeChargePaymentDetailsCardPresentReceiptAccountType?
    /// EMV tag 9F26, cryptogram generated by the integrated circuit chip.
    public var applicationCryptogram: String?
    /// Mnenomic of the Application Identifier.
    public var applicationPreferredName: String?
    /// Identifier for this transaction.
    public var authorizationCode: String?
    /// EMV tag 8A. A code returned by the card issuer.
    public var authorizationResponseCode: String?
    /// How the cardholder verified ownership of the card.
    public var cardholderVerificationMethod: String?
    /// EMV tag 84. Similar to the application identifier stored on the integrated circuit chip.
    public var dedicatedFileName: String?
    /// The outcome of a series of EMV functions performed by the card reader.
    public var terminalVerificationResults: String?
    /// An indication of various EMV functions performed during the transaction.
    public var transactionStatusInformation: String?
}

public enum StripeChargePaymentDetailsCardPresentReceiptAccountType: String, Codable {
    /// A credit account, as when using a credit card
    case credit
    /// A checking account, as when using a debit card
    case checking
    /// A prepaid account, as when using a debit gift card
    case prepaid
    /// An unknown account
    case unknown
}

public struct StripeChargePaymentDetailsEPS: StripeModel {
    /// Owner’s verified full name. Values are verified or provided by EPS directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
}

public struct StripeChargePaymentDetailsFpx: StripeModel {
    /// The customer’s bank. Can be one of `affin_bank`, `alliance_bank`, `ambank`, `bank_islam`, `bank_muamalat`, `bank_rakyat`, `bsn`, `cimb`, `hong_leong_bank`, `hsbc`, `kfh`, `maybank2u`, `ocbc`, `public_bank`, `rhb`, `standard_chartered`, `uob`, `deutsche_bank`, `maybank2e`, or `pb_enterprise`.
    public var bank: StripeChargePaymentDetailsFpxBank?
    /// Unique transaction id generated by FPX for every request from the merchant
    public var transactionId: String?
}

public enum StripeChargePaymentDetailsFpxBank: String, StripeModel {
    case affinBank = "affin_bank"
    case allianceBank = "alliance_bank"
    case ambank
    case bankIslam = "bank_islam"
    case bankMuamalat = "bank_muamalat"
    case bankRakyat = "bank_rakyat"
    case bsn
    case cimb
    case hongLeongBank = "hong_leong_bank"
    case hsbc
    case kfh
    case maybank2u
    case ocbc
    case publicBank = "public_bank"
    case rhb
    case standardChartered = "standard_chartered"
    case uob
    case deutscheBank = "deutsche_bank"
    case maybank2e
    case pbEnterprise = "pb_enterprise"
}

public struct StripeChargePaymentDetailsGiropay: StripeModel {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// Owner’s verified full name. Values are verified or provided by Giropay directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
}

public struct StripeChargePaymentDetailsGrabpay: StripeModel {
    /// Unique transaction id generated by GrabPay
    public var transactionId: String?
}

public struct StripeChargePaymentDetailsIdeal: StripeModel {
    /// The customer’s bank. Can be one of `abn_amro`, `asn_bank`, `bunq`, `handelsbanken`, `ing`, `knab`, `moneyou`, `rabobank`, `regiobank`, `sns_bank`, `triodos_bank`, or `van_lanschot`.
    public var bank: StripeChargePaymentDetailsIdealBank?
    /// The Bank Identifier Code of the customer’s bank.
    public var bic: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Owner’s verified full name. Values are verified or provided by iDEAL directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
}

public struct StripeChargePaymentDetailsInteracPresent: StripeModel {
    /// Card brand. Can be `interac`, `mastercard` or `visa`.
    public var brand: StripeChargePaymentDetailsInteracPresentBrand?
    /// The cardholder name as read from the card, in ISO 7813 format. May include alphanumeric characters, special characters and first/last name separator (`/`).
    public var cardholderName: String?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Authorization response cryptogram.
    public var emvAuthData: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number,for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: StripeCardFundingType?
    /// ID of a card PaymentMethod generated from the card_present PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
    public var generatedCard: String?
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be amex, cartes_bancaires, diners, discover, interac, jcb, mastercard, unionpay, visa, or unknown.
    public var network: StripePaymentMethodCardNetwork?
    /// How were card details read in this transaction. Can be `contact_emv`, `contactless_emv`, `magnetic_stripe_fallback`, `magnetic_stripe_track2`, or `contactless_magstripe_mode`
    public var readMethod: StripeChargePaymentDetailsInteracPresentReadMethod?
    /// A collection of fields required to be displayed on receipts. Only required for EMV transactions.
    public var receipt: StripeChargePaymentDetailsInteracPresentReceipt?
}

public enum StripeChargePaymentDetailsInteracPresentBrand: String, StripeModel {
    case interac
    case mastercard
    case visa
}

public enum StripeChargePaymentDetailsInteracPresentReadMethod: String, StripeModel {
    case contactEmv = "contact_emv"
    case contactlessEmv = "contactless_emv"
    case magneticStripeFallback = "magnetic_stripe_fallback"
    case magneticStripeTrack2 = "magnetic_stripe_track2"
    case contactlessMagstripeMode = "contactless_magstripe_mode"
}

public struct StripeChargePaymentDetailsInteracPresentReceipt: StripeModel {
    /// EMV tag 9F26, cryptogram generated by the integrated circuit chip.
    public var applicationCryptogram: String?
    /// Mnenomic of the Application Identifier.
    public var applicationPreferredName: String?
    /// Identifier for this transaction.
    public var authorizationCode: String?
    /// EMV tag 8A. A code returned by the card issuer.
    public var authorizationResponseCode: String?
    /// How the cardholder verified ownership of the card.
    public var cardholderVerificationMethod: String?
    /// EMV tag 84. Similar to the application identifier stored on the integrated circuit chip.
    public var dedicatedFileName: String?
    /// The outcome of a series of EMV functions performed by the card reader.
    public var terminalVerificationResults: String?
    /// An indication of various EMV functions performed during the transaction.
    public var transactionStatusInformation: String?
}

public struct StripeChargePaymentDetailsKlarna: StripeModel {
    /// The Klarna payment method used for this transaction. Can be one of `pay_later`, `pay_now`, `pay_with_financing`, or `pay_in_installments`.
    public var paymentMethodCategory: StripeChargePaymentDetailsKlarnaPaymentMethodCategory?
    /// Preferred language of the Klarna authorization page that the customer is redirected to.
    public var preferredLocale: String?
}

public enum StripeChargePaymentDetailsKlarnaPaymentMethodCategory: String, StripeModel {
    case payLater = "pay_later"
    case payNow = "pay_now"
    case payWithFinancing = "pay_with_financing"
    case payInInstallments = "pay_in_installments"
}

public enum StripeChargePaymentDetailsIdealBank: String, StripeModel {
    case abnAmro = "abn_amro"
    case asnBank = "asn_bank"
    case bunq
    case handelsbanken
    case ing
    case knab
    case moneyou
    case rabobank
    case regiobank
    case snsBank = "sns_bank"
    case triodosBank = "triodos_bank"
    case vanLanschot = "van_lanschot"
}

public struct StripeChargePaymentDetailsMultibanco: StripeModel {
    /// Entity number associated with this Multibanco payment.
    public var entity: String?
    /// Reference number associated with this Multibanco payment.
    public var reference: String?
}

public struct StripeChargePaymentDetailsOXXO: StripeModel {
    /// OXXO reference number
    public var number: String?
}

public struct StripeChargePaymentDetailsP24: StripeModel {
    /// Unique reference for this Przelewy24 payment.
    public var reference: String?
    /// Owner’s verified full name. Values are verified or provided by Przelewy24 directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
}

public struct StripeChargePaymentDetailsSepaDebit: StripeModel {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Branch code of bank associated with the bank account.
    public var branchCode: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four characters of the IBAN.
    public var last4: String?
    /// ID of the mandate used to make this payment.
    public var mandate: String?
}

public struct StripeChargePaymentDetailsSofort: StripeModel {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Owner’s verified full name. Values are verified or provided by SOFORT directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
}

public struct StripeChargePaymentDetailsStripeAccount: StripeModel {
    // https://stripe.com/docs/api/charges/object#charge_object-payment_method_details-stripe_account
}

public enum StripeChargePaymentDetailsType: String, StripeModel {
    case achCreditTransfer = "ach_credit_transfer"
    case achDebit = "ach_debit"
    case alipay
    case auBecsDebit = "au_becs_debit"
    case bancontact
    case card
    case cardPresent = "card_present"
    case eps
    case giropay
    case ideal
    case klarna
    case multibanco
    case p24
    case sepaDebit = "sepa_debit"
    case sofort
    case stripeAccount = "stripe_account"
    case wechat
}

public struct StripeChargePaymentDetailsWechat: StripeModel {
    // https://stripe.com/docs/api/charges/object#charge_object-payment_method_details-wechat
}
