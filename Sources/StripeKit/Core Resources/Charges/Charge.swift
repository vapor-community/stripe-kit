//
//  Charge.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/// The [Charge Object](https://stripe.com/docs/api/charges/object)
public struct Charge: Codable {
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
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Billing information associated with the payment method at the time of the transaction.
    public var billingDetails: StripeBillingDetails?
    /// The full statement descriptor that is passed to card networks, and that is displayed on your customers’ credit card and bank statements. Allows you to see what the statement descriptor looks like after the static and dynamic portions are combined.
    public var calculatedStatementDescriptor: String?
    /// If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured.
    public var captured: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// ID of the customer this charge is for if one exists.
    @Expandable<StripeCustomer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Details about the dispute if the charge has been disputed.
    public var dispute: String?
    /// Whether the charge has been disputed.
    public var disputed: Bool?
    /// ID of the balance transaction that describes the reversal of the balance on your account due to payment failure.
    @Expandable<BalanceTransaction> public var failureBalanceTransaction: String?
    /// Error code explaining reason for charge failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).
    public var failureCode: String?
    /// Message to user further explaining reason for charge failure if available.
    public var failureMessage: String?
    /// Information on fraud assessments for the charge.
    public var fraudDetails: ChargeFraudDetails?
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
    public var outcome: ChargeOutcome?
    /// `true` if the charge succeeded, or was successfully authorized for later capture.
    public var paid: Bool?
    /// ID of the PaymentIntent associated with this charge, if one exists.
    @Expandable<StripePaymentIntent> public var paymentIntent: String?
    /// ID of the payment method used in this charge.
    public var paymentMethod: String?
    /// Details about the payment method at the time of the transaction.
    public var paymentMethodDetails: ChargePaymentMethodDetails?
    /// Options to configure Radar. See Radar Session for more information.
    public var radarOptions: ChrageRadarOptions?
    /// This is the email address that the receipt for this charge was sent to.
    public var receiptEmail: String?
    /// This is the transaction number that appears on email receipts sent for this charge. This attribute will be `null` until a receipt has been sent.
    public var receiptNumber: String?
    /// This is the URL to view the receipt for this charge. The receipt is kept up-to-date to the latest state of the charge, including any refunds. If the charge is for an Invoice, the receipt will be stylized as an Invoice receipt.
    public var receiptUrl: String?
    /// Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
    public var refunded: Bool?
    /// A list of refunds that have been applied to the charge.
    public var refunds: RefundsList?
    /// ID of the review associated with this charge if one exists.
    @Expandable<StripeReview> public var review: String?
    /// Shipping information for the charge.
    public var shipping: ShippingLabel?
    /// The transfer ID which created this charge. Only present if the charge came from another Stripe account. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    @Expandable<StripeTransfer> public var sourceTransfer: String?
    /// Extra information about a charge. This will appear on your customer’s credit card statement. It must contain at least one letter.
    public var statementDescriptor: String?
    /// Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    public var statementDescriptorSuffix: String?
    /// The status of the payment is either `succeeded`, `pending`, or `failed`.
    public var status: ChargeStatus?
    /// ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination` parameter).
    @Expandable<StripeTransfer> public var transfer: String?
    /// An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    public var transferData: ChargeTransferData?
    /// A string that identifies this transaction as part of a group. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
    public var transferGroup: String?
    
    public init(id: String,
                object: String,
                amount: Int? = nil,
                amountCaptured: Int? = nil,
                amountRefunded: Int? = nil,
                application: String? = nil,
                applicationFee: String? = nil,
                applicationFeeAmount: Int? = nil,
                balanceTransaction: String? = nil,
                billingDetails: StripeBillingDetails? = nil,
                calculatedStatementDescriptor: String? = nil,
                captured: Bool? = nil,
                created: Date,
                currency: Currency? = nil,
                customer: String? = nil,
                description: String? = nil,
                dispute: String? = nil,
                disputed: Bool? = nil,
                failureBalanceTransaction: String? = nil,
                failureCode: String? = nil,
                failureMessage: String? = nil,
                fraudDetails: ChargeFraudDetails? = nil,
                invoice: String? = nil,
                livemode: Bool? = nil,
                metadata: [String : String]? = nil,
                onBehalfOf: String? = nil,
                order: String? = nil,
                outcome: ChargeOutcome? = nil,
                paid: Bool? = nil,
                paymentIntent: String? = nil,
                paymentMethod: String? = nil,
                paymentMethodDetails: ChargePaymentMethodDetails? = nil,
                radarOptions: ChrageRadarOptions? = nil,
                receiptEmail: String? = nil,
                receiptNumber: String? = nil,
                receiptUrl: String? = nil,
                refunded: Bool? = nil,
                refunds: RefundsList? = nil,
                review: String? = nil,
                shipping: ShippingLabel? = nil,
                sourceTransfer: String? = nil,
                statementDescriptor: String? = nil,
                statementDescriptorSuffix: String? = nil,
                status: ChargeStatus? = nil,
                transfer: String? = nil,
                transferData: ChargeTransferData? = nil,
                transferGroup: String? = nil) {
        self.id = id
        self.object = object
        self.amount = amount
        self.amountCaptured = amountCaptured
        self.amountRefunded = amountRefunded
        self.application = application
        self._applicationFee = Expandable(id: applicationFee)
        self.applicationFeeAmount = applicationFeeAmount
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.billingDetails = billingDetails
        self.calculatedStatementDescriptor = calculatedStatementDescriptor
        self.captured = captured
        self.created = created
        self.currency = currency
        self._customer = Expandable(id: customer)
        self.description = description
        self.dispute = dispute
        self.disputed = disputed
        self._failureBalanceTransaction = Expandable(id: failureBalanceTransaction)
        self.failureCode = failureCode
        self.failureMessage = failureMessage
        self.fraudDetails = fraudDetails
        self._invoice = Expandable(id: invoice)
        self.livemode = livemode
        self.metadata = metadata
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self._order = Expandable(id: order)
        self.outcome = outcome
        self.paid = paid
        self._paymentIntent = Expandable(id: paymentIntent)
        self.paymentMethod = paymentMethod
        self.paymentMethodDetails = paymentMethodDetails
        self.radarOptions = radarOptions
        self.receiptEmail = receiptEmail
        self.receiptNumber = receiptNumber
        self.receiptUrl = receiptUrl
        self.refunded = refunded
        self.refunds = refunds
        self._review = Expandable(id: review)
        self.shipping = shipping
        self._sourceTransfer = Expandable(id: sourceTransfer)
        self.statementDescriptor = statementDescriptor
        self.statementDescriptorSuffix = statementDescriptorSuffix
        self.status = status
        self._transfer = Expandable(id: transfer)
        self.transferData = transferData
        self.transferGroup = transferGroup
    }
}

public struct ChargeFraudDetails: Codable {
    /// Assessments reported by you. If set, possible values of are `safe` and `fraudulent`.
    public var userReport: ChargeFraudDetailsReportType?
    /// Assessments from Stripe. If set, the value is `fraudulent`.
    public var stripeReport: ChargeFraudDetailsReportType?
    
    public init(userReport: ChargeFraudDetailsReportType? = nil,
                stripeReport: ChargeFraudDetailsReportType? = nil) {
        self.userReport = userReport
        self.stripeReport = stripeReport
    }
}

public enum ChargeFraudDetailsReportType: String, Codable {
    case safe
    case fraudulent
}

public struct ChargeOutcome: Codable {
    /// Possible values are `approved_by_network`, `declined_by_network`, `not_sent_to_network`, and `reversed_after_approval`. The value `reversed_after_approval` indicates the payment was [blocked by Stripe](https://stripe.com/docs/declines#blocked-payments) after bank authorization, and may temporarily appear as “pending” on a cardholder’s statement.
    public var networkStatus: ChargeOutcomeNetworkStatus?
    /// An enumerated value providing a more detailed explanation of the outcome’s `type`. Charges blocked by Radar’s default block rule have the value `highest_risk_level`. Charges placed in review by Radar’s default review rule have the value `elevated_risk_level`. Charges authorized, blocked, or placed in review by custom rules have the value `rule`. See [understanding declines](https://stripe.com/docs/declines) for more details.
    public var reason: String?
    /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are `normal`, `elevated`, `highest`. For non-card payments, and card-based payments predating the public assignment of risk levels, this field will have the value `not_assessed`. In the event of an error in the evaluation, this field will have the value `unknown`.
    public var riskLevel: ChargeOutcomeRiskLevel?
    /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are between 0 and 100. For non-card payments, card-based payments predating the public assignment of risk scores, or in the event of an error during evaluation, this field will not be present. This field is only available with Radar for Fraud Teams.
    public var riskScore: Int?
    /// The ID of the Radar rule that matched the payment, if applicable.
    public var rule: String?
    /// A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not your customer.
    public var sellerMessage: String?
    /// Possible values are `authorized`, `manual_review`, `issuer_declined`, `blocked`, and `invalid`. See understanding declines and Radar reviews for details.
    public var type: ChargeOutcomeType?
    
    public init(networkStatus: ChargeOutcomeNetworkStatus? = nil,
                reason: String? = nil,
                riskLevel: ChargeOutcomeRiskLevel? = nil,
                riskScore: Int? = nil,
                rule: String? = nil,
                sellerMessage: String? = nil,
                type: ChargeOutcomeType? = nil) {
        self.networkStatus = networkStatus
        self.reason = reason
        self.riskLevel = riskLevel
        self.riskScore = riskScore
        self.rule = rule
        self.sellerMessage = sellerMessage
        self.type = type
    }
}

public enum ChargeOutcomeNetworkStatus: String, Codable {
    case approvedByNetwork = "approved_by_network"
    case declinedByNetwork = "declined_by_network"
    case notSentToNetwork = "not_sent_to_network"
    case reversedAfterApproval = "reversed_after_approval"
}

public enum ChargeOutcomeRiskLevel: String, Codable {
    case normal
    case elevated
    case highest
    case notAssessed = "not_assessed"
    case unknown
}

public enum ChargeOutcomeType: String, Codable {
    case authorized
    case manualReview = "manual_review"
    case issuerDeclined = "issuer_declined"
    case blocked
    case invalid
}

public enum ChargeStatus: String, Codable {
    case succeeded
    case pending
    case failed
}

public struct ChargeTransferData: Codable {
    /// The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
    public var amount: Int?
    /// ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge request.
    @Expandable<StripeConnectAccount> public var destination: String?
    
    public init(amount: Int? = nil,
                destination: String? = nil) {
        self.amount = amount
        self._destination = Expandable(id: destination)
    }
}

public struct ChargeList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    /// The list of Chrages
    public var data: [Charge]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Charge]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public struct ChargeSearchResult: Codable {
    /// A string describing the object type returned.
    public var object: String
    /// A list of charges, paginated by any request parameters.
    public var data: [Charge]?
    /// Whether or not there are more elements available after this set.
    public var hasMore: Bool?
    /// The URL for accessing this list.
    public var url: String?
    /// The URL for accessing the next page in search results.
    public var nextPage: String?
    /// The total count of entries in the search result, not just the current page.
    public var totalCount: Int?
    
    public init(object: String,
                data: [Charge]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil,
                nextPage: String? = nil,
                totalCount: Int? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
        self.nextPage = nextPage
        self.totalCount = totalCount
    }
}

public struct ChargePaymentMethodDetails: Codable {
    ///If this is a `ach_credit_transfer` payment, this hash contains a snapshot of the transaction specific details of the `ach_credit_transfer` payment method.
    public var achCreditTransfer: ChargePaymentMethodDetailsACHCreditTransfer?
    /// If this is a `ach_debit` payment, this hash contains a snapshot of the transaction specific details of the `ach_debit` payment method.
    public var achDebit: ChargePaymentMethodDetailsACHDebit?
    /// If this is a `acss_debit` payment, this hash contains a snapshot of the transaction specific details of the `acss_debit` payment method.
    public var acssDebit: ChargePaymentMethodDetailsACSSDebit?
    /// If this is a `affirm` payment, this hash contains a snapshot of the transaction specific details of the `affirm` payment method.
    public var affirm: ChargePaymentMethodDetailsAffirm?
    /// If this is a `afterpay_clearpay` payment, this hash contains a snapshot of the transaction specific details of the `afterpay_clearpay` payment method.
    public var afterpayClearpay: ChargePaymentMethodDetailsAfterpayClearpay?
    /// If this is a `alipay` payment, this hash contains a snapshot of the transaction specific details of the `alipay` payment method.
    public var alipay: ChargePaymentMethodDetailsAlipay?
    /// If this is a `au_becs_debit` payment, this hash contains a snapshot of the transaction specific details of the `au_becs_debit` payment method.
    public var auBecsDebit: ChargePaymentMethodDetailsAuBecsDebit?
    /// If this is a `bacs_debit` payment, this hash contains a snapshot of the transaction specific details of the bacs_debit payment method.
    public var bacsDebit: ChargePaymentMethodDetailsBacsDebit?
    /// If this is a `bancontact` payment, this hash contains a snapshot of the transaction specific details of the `bancontact` payment method.
    public var bancontact: ChargePaymentMethodDetailsBancontact?
    /// If this is a `blik` payment, this hash contains a snapshot of the transaction specific details of the `blik` payment method.
    public var blik: ChargePaymentMethodDetailsBlik?
    /// If this is a `boleto` payment, this hash contains a snapshot of the transaction specific details of the `boleto` payment method.
    public var boleto: ChargePaymentMethodDetailsBoleto?
    /// If this is a `card` payment, this hash contains a snapshot of the transaction specific details of the `card` payment method.
    public var card: ChargePaymentMethodDetailsCard?
    /// If this is a `card_present` payment, this hash contains a snapshot of the transaction specific details of the `card_present` payment method.
    public var cardPresent: ChargePaymentMethodDetailsCardPresent?
    /// If this is a `customer_balance` payment, this hash contains a snapshot of the transaction specific details of the `customer_balance` payment method.
    public var customerBalance: ChargePaymentMethodDetailsCustomerBalance?
    /// If this is a `eps` payment, this hash contains a snapshot of the transaction specific details of the `eps` payment method.
    public var eps: ChargePaymentMethodDetailsEPS?
    /// If this is a `fpx` payment, this hash contains a snapshot of the transaction specific details of the `fpx` payment method.
    public var fpx: ChargePaymentMethodDetailsFpx?
    /// If this is a `grabpay` payment, this hash contains a snapshot of the transaction specific details of the `grabpay` payment method.
    public var grabpay: ChargePaymentMethodDetailsGrabpay?
    /// If this is a `giropay` payment, this hash contains a snapshot of the transaction specific details of the `giropay` payment method.
    public var giropay: ChargePaymentMethodDetailsGiropay?
    /// If this is a `ideal` payment, this hash contains a snapshot of the transaction specific details of the `ideal` payment method.
    public var ideal: ChargePaymentMethodDetailsIdeal?
    /// If this is a `interac_present` payment, this hash contains a snapshot of the transaction specific details of the `interac_present` payment method.
    public var interacPresent: ChargePaymentMethodDetailsInteracPresent?
    /// If this is a klarna payment, this hash contains a snapshot of the transaction specific details of the klarna payment method.
    public var klarna: ChargePaymentMethodDetailsKlarna?
    /// If this is a konbini payment, this hash contains a snapshot of the transaction specific details of the konbini payment method.
    public var konbini: ChargePaymentMethodDetailsKobini?
    /// If this is a `multibanco` payment, this hash contains a snapshot of the transaction specific details of the `multibanco` payment method.
    public var multibanco: ChargePaymentMethodDetailsMultibanco?
    /// If this is a oxxo payment, this hash contains a snapshot of the transaction specific details of the oxxo payment method.
    public var oxxo: ChargePaymentMethodDetailsOXXO?
    /// If this is a `p24` payment, this hash contains a snapshot of the transaction specific details of the `p24` payment method.
    public var p24: ChargePaymentMethodDetailsP24?
    /// If this is a `paynow` payment, this hash contains a snapshot of the transaction specific details of the `paynow` payment method.
    public var paynow: ChargePaymentMethodDetailsPaynow?
    /// If this is a `pix` payment, this hash contains a snapshot of the transaction specific details of the `pix` payment method.
    public var pix: ChargePaymentMethodDetailsPix?
    /// If this is a `promptpay` payment, this hash contains a snapshot of the transaction specific details of the `promptpay` payment method.
    public var promptpay: ChargePaymentMethodDetailsPromptpay?
    /// If this is a `sepa_debit` payment, this hash contains a snapshot of the transaction specific details of the `sepa_debit` payment method.
    public var sepaDebit: ChargePaymentMethodDetailsSepaDebit?
    /// If this is a `sofort` payment, this hash contains a snapshot of the transaction specific details of the `sofort` payment method
    public var sofort: ChargePaymentMethodDetailsSofort?
    /// If this is a `stripe_account` payment, this hash contains a snapshot of the transaction specific details of the `stripe_account` payment method
    public var stripeAccount: ChargePaymentMethodDetailsStripeAccount?
    /// The type of transaction-specific details of the payment method used in the payment, one of `ach_credit_transfer`, `ach_debit`, `alipay`, `bancontact`, `card`, `card_present`, `eps`, `giropay`, `ideal`, `multibanco`, `p24`, `sepa_debit`, `sofort`, `stripe_account`, or `wechat`. An additional hash is included on `payment_method_details` with a name matching this value. It contains information specific to the payment method.
    public var type: ChargePaymentMethodDetailsType?
    /// If this is a `us_bank_account` payment, this hash contains a snapshot of the transaction specific details of the `us_bank_account` payment method.
    public var usBankAccount: ChargePaymentMethodDetailsUSBankAccount?
    /// If this is a `wechat` payment, this hash contains a snapshot of the transaction specific details of the `wechat` payment method.
    public var wechat: ChargePaymentMethodDetailsWechat?
    /// If this is a `wechat_pay` payment, this hash contains a snapshot of the transaction specific details of the `wechat_pay` payment method.
    public var wechatPay: ChargePaymentMethodDetailsWechatPay?
    
    public init(achCreditTransfer: ChargePaymentMethodDetailsACHCreditTransfer? = nil,
                  achDebit: ChargePaymentMethodDetailsACHDebit? = nil,
                  acssDebit: ChargePaymentMethodDetailsACSSDebit? = nil,
                  affirm: ChargePaymentMethodDetailsAffirm? = nil,
                  afterpayClearpay: ChargePaymentMethodDetailsAfterpayClearpay? = nil,
                  alipay: ChargePaymentMethodDetailsAlipay? = nil,
                  auBecsDebit: ChargePaymentMethodDetailsAuBecsDebit? = nil,
                  bacsDebit: ChargePaymentMethodDetailsBacsDebit? = nil,
                  bancontact: ChargePaymentMethodDetailsBancontact? = nil,
                  blik: ChargePaymentMethodDetailsBlik? = nil,
                  boleto: ChargePaymentMethodDetailsBoleto? = nil,
                  card: ChargePaymentMethodDetailsCard? = nil,
                  cardPresent: ChargePaymentMethodDetailsCardPresent? = nil,
                  customerBalance: ChargePaymentMethodDetailsCustomerBalance? = nil,
                  eps: ChargePaymentMethodDetailsEPS? = nil,
                  fpx: ChargePaymentMethodDetailsFpx? = nil,
                  grabpay: ChargePaymentMethodDetailsGrabpay? = nil,
                  giropay: ChargePaymentMethodDetailsGiropay? = nil,
                  ideal: ChargePaymentMethodDetailsIdeal? = nil,
                  interacPresent: ChargePaymentMethodDetailsInteracPresent? = nil,
                  klarna: ChargePaymentMethodDetailsKlarna? = nil,
                  konbini: ChargePaymentMethodDetailsKobini? = nil,
                  multibanco: ChargePaymentMethodDetailsMultibanco? = nil,
                  oxxo: ChargePaymentMethodDetailsOXXO? = nil,
                  p24: ChargePaymentMethodDetailsP24? = nil,
                  paynow: ChargePaymentMethodDetailsPaynow? = nil,
                  pix: ChargePaymentMethodDetailsPix? = nil,
                  promptpay: ChargePaymentMethodDetailsPromptpay? = nil,
                  sepaDebit: ChargePaymentMethodDetailsSepaDebit? = nil,
                  sofort: ChargePaymentMethodDetailsSofort? = nil,
                  stripeAccount: ChargePaymentMethodDetailsStripeAccount? = nil,
                  type: ChargePaymentMethodDetailsType? = nil,
                  usBankAccount: ChargePaymentMethodDetailsUSBankAccount? = nil,
                  wechat: ChargePaymentMethodDetailsWechat? = nil,
                  wechatPay: ChargePaymentMethodDetailsWechatPay? = nil) {
        self.achCreditTransfer = achCreditTransfer
        self.achDebit = achDebit
        self.acssDebit = acssDebit
        self.affirm = affirm
        self.afterpayClearpay = afterpayClearpay
        self.alipay = alipay
        self.auBecsDebit = auBecsDebit
        self.bacsDebit = bacsDebit
        self.bancontact = bancontact
        self.blik = blik
        self.boleto = boleto
        self.card = card
        self.cardPresent = cardPresent
        self.customerBalance = customerBalance
        self.eps = eps
        self.fpx = fpx
        self.grabpay = grabpay
        self.giropay = giropay
        self.ideal = ideal
        self.interacPresent = interacPresent
        self.klarna = klarna
        self.konbini = konbini
        self.multibanco = multibanco
        self.oxxo = oxxo
        self.p24 = p24
        self.paynow = paynow
        self.pix = pix
        self.promptpay = promptpay
        self.sepaDebit = sepaDebit
        self.sofort = sofort
        self.stripeAccount = stripeAccount
        self.type = type
        self.usBankAccount = usBankAccount
        self.wechat = wechat
        self.wechatPay = wechatPay
    }
}

public enum ChargePaymentMethodDetailsType: String, Codable {
    case achCreditTransfer = "ach_credit_transfer"
    case achDebit = "ach_debit"
    case acssDebit = "acss_debit"
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

public struct ChrageRadarOptions: Codable {
    /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
    public var session: String?
    
    public init(session: String? = nil) {
        self.session = session
    }
}
