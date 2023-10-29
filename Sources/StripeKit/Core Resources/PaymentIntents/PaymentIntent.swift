//
//  PaymentIntent.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

import Foundation

/// The [PaymentIntent Object](https://stripe.com/docs/api/payment_intents/object)
public struct PaymentIntent: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Amount intended to be collected by this PaymentIntent.
    public var amount: Int?
    /// Settings to configure compatible payment methods from the Stripe Dashboard.
    public var automaticPaymentMethods: PaymentIntentAutomaticMaymentMethods?
    /// The client secret of this PaymentIntent. Used for client-side retrieval using a publishable key. Please refer to [dynamic authentication](https://stripe.com/docs/payments/dynamic-authentication) guide on how `client_secret` should be handled.
    public var clientSecret: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// ID of the Customer this PaymentIntent is for if one exists.
    @Expandable<Customer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// The payment error encountered in the previous PaymentIntent confirmation.
    public var lastPaymentError: StripeError?
    /// The latest charge created by this payment intent.
    @Expandable<Charge> public var latestCharge: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If present, this property tells you what actions you need to take in order for your customer to fulfill a payment using the provided source.
    public var nextAction: PaymentIntentNextAction?
    /// ID of the payment method used in this PaymentIntent.
    @Expandable<PaymentMethod> public var paymentMethod: String?
    /// Email address that the receipt for the resulting payment will be sent to.
    public var receiptEmail: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. For more, learn to save card details after a payment. Stripe uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using `off_session` will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer.
    public var setupFutureUsage: PaymentIntentSetupFutureUsage?
    /// Shipping information for this PaymentIntent.
    public var shipping: ShippingLabel?
    /// For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    public var statementDescriptor: String?
    /// Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    public var statementDescriptorSuffix: String?
    /// Status of this PaymentIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `requires_capture`, `canceled`, or `succeeded`.
    public var status: PaymentIntentStatus?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount that can be captured from this PaymentIntent.
    public var amountCapturable: Int?
    /// Details about items included in the amount
    public var amountDetails: PaymentIntentAmountDetails?
    /// Amount that was collected by this PaymentIntent.
    public var amountReceived: Int?
    /// ID of the Connect application that created the PaymentIntent.
    public var application: String?
    /// The amount of the application fee (if any) for the resulting payment. See the PaymentIntents [Connect usage guide](https://stripe.com/docs/payments/payment-intents/usage#connect) for details.
    public var applicationFeeAmount: Int?
    /// Populated when `status` is `canceled`, this is the time at which the PaymentIntent was canceled. Measured in seconds since the Unix epoch.
    public var canceledAt: Date?
    /// User-given reason for cancellation of this PaymentIntent, one of `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`.
    public var cancellationReason: PaymentIntentCancellationReason?
    /// Capture method of this PaymentIntent, one of `automatic` or `manual`.
    public var captureMethod: PaymentIntentCaptureMethod?
    /// Confirmation method of this PaymentIntent, one of `manual` or `automatic`.
    public var confirmationMethod: PaymentIntentConfirmationMethod?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// ID of the invoice that created this PaymentIntent, if it exists.
    @Expandable<Invoice> public var invoice: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The account (if any) for which the funds of the PaymentIntent are intended. See the PaymentIntents Connect usage guide for details.
    @Expandable<ConnectAccount> public var onBehalfOn: String?
    /// Payment-method-specific configuration for this PaymentIntent.
    public var paymentMethodOptions: PaymentIntentPaymentMethodOptions?
    /// The list of payment method types (e.g. card) that this PaymentIntent is allowed to use.
    public var paymentMethodTypes: [String]?
    /// If present, this property tells you about the processing state of the payment.
    public var processing: PaymentIntentProcessing?
    /// ID of the review associated with this PaymentIntent, if any.
    @Expandable<Review> public var review: String?
    /// The data with which to automatically create a Transfer when the payment is finalized. See the PaymentIntents Connect usage guide for details.
    public var transferData: PaymentIntentTransferData?
    /// A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    public var transferGroup: String?
	/// Details about the subscription that created this invoice.
	public var subscriptionDetails: SubscriptionDetails?

    public init(id: String,
                amount: Int? = nil,
                automaticPaymentMethods: PaymentIntentAutomaticMaymentMethods? = nil,
                clientSecret: String? = nil,
                currency: Currency? = nil,
                customer: String? = nil,
                description: String? = nil,
                lastPaymentError: StripeError? = nil,
                latestCharge: String? = nil,
                metadata: [String : String]? = nil,
                nextAction: PaymentIntentNextAction? = nil,
                paymentMethod: String? = nil,
                receiptEmail: String? = nil,
                setupFutureUsage: PaymentIntentSetupFutureUsage? = nil,
                shipping: ShippingLabel? = nil,
                statementDescriptor: String? = nil,
                statementDescriptorSuffix: String? = nil,
                status: PaymentIntentStatus? = nil,
                object: String,
                amountCapturable: Int? = nil,
                amountDetails: PaymentIntentAmountDetails? = nil,
                amountReceived: Int? = nil,
                application: String? = nil,
                applicationFeeAmount: Int? = nil,
                canceledAt: Date? = nil,
                cancellationReason: PaymentIntentCancellationReason? = nil,
                captureMethod: PaymentIntentCaptureMethod? = nil,
                confirmationMethod: PaymentIntentConfirmationMethod? = nil,
                created: Date,
                invoice: String? = nil,
                livemode: Bool? = nil,
                onBehalfOn: String? = nil,
                paymentMethodOptions: PaymentIntentPaymentMethodOptions? = nil,
                paymentMethodTypes: [String]? = nil,
                processing: PaymentIntentProcessing? = nil,
                review: String? = nil,
                transferData: PaymentIntentTransferData? = nil,
                transferGroup: String? = nil) {
        self.id = id
        self.amount = amount
        self.automaticPaymentMethods = automaticPaymentMethods
        self.clientSecret = clientSecret
        self.currency = currency
        self._customer = Expandable(id: customer)
        self.description = description
        self.lastPaymentError = lastPaymentError
        self._latestCharge = Expandable(id: latestCharge)
        self.metadata = metadata
        self.nextAction = nextAction
        self._paymentMethod = Expandable(id: paymentMethod)
        self.receiptEmail = receiptEmail
        self.setupFutureUsage = setupFutureUsage
        self.shipping = shipping
        self.statementDescriptor = statementDescriptor
        self.statementDescriptorSuffix = statementDescriptorSuffix
        self.status = status
        self.object = object
        self.amountCapturable = amountCapturable
        self.amountDetails = amountDetails
        self.amountReceived = amountReceived
        self.application = application
        self.applicationFeeAmount = applicationFeeAmount
        self.canceledAt = canceledAt
        self.cancellationReason = cancellationReason
        self.captureMethod = captureMethod
        self.confirmationMethod = confirmationMethod
        self.created = created
        self._invoice = Expandable(id: invoice)
        self.livemode = livemode
        self._onBehalfOn = Expandable(id: onBehalfOn)
        self.paymentMethodOptions = paymentMethodOptions
        self.paymentMethodTypes = paymentMethodTypes
        self.processing = processing
        self._review = Expandable(id: review)
        self.transferData = transferData
        self.transferGroup = transferGroup
    }
}

public struct PaymentIntentProcessing: Codable {
    /// If the PaymentIntent’s `payment_method_types` includes card, this hash contains the details on the processing state of the payment.
    public var card: PaymentIntentProcessingCard?
    /// Type of the payment method for which payment is in processing state, one of `card`.
    public var type: String?
    
    public init(card: PaymentIntentProcessingCard? = nil, type: String? = nil) {
        self.card = card
        self.type = type
    }
}

public struct PaymentIntentProcessingCard: Codable {
    /// For recurring payments of Indian cards, this hash contains details on whether customer approval is required, and until when the payment will be in `processing` state
    public var customerNotification: PaymentIntentProcessingCardCustomerNotification?
    
    public init(customerNotification: PaymentIntentProcessingCardCustomerNotification? = nil) {
        self.customerNotification = customerNotification
    }
}

public struct PaymentIntentProcessingCardCustomerNotification: Codable {
    /// Whether customer approval has been requested for this payment. For payments greater than INR 15000 or mandate amount, the customer must provide explicit approval of the payment with their bank.
    public var approvalRequested: Bool?
    /// If customer approval is required, they need to provide approval before this time.
    public var completesAt: Date?
    
    public init(approvalRequested: Bool? = nil, completesAt: Date? = nil) {
        self.approvalRequested = approvalRequested
        self.completesAt = completesAt
    }
}


public struct PaymentIntentAutomaticMaymentMethods: Codable {
    /// Automatically calculates compatible payment methods
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public enum PaymentIntentSetupFutureUsage: String, Codable {
    case onSession = "on_session"
    case offSession = "off_session"
}

public struct PaymentIntentTransferData: Codable {
	/// Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    public var amount: Int?
    /// The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to upon payment success.
    @Expandable<ConnectAccount> public var destination: String?
    
    public init(amount: Int? = nil, destination: String? = nil) {
        self.amount = amount
        self._destination = Expandable(id: destination)
    }
}

public enum PaymentIntentCancellationReason: String, Codable {
    case duplicate
    case fraudulent
    case requestedByCustomer = "requested_by_customer"
    case failedInvoice = "failed_invoice"
    case voidInvoice = "void_invoice"
    case automatic
}

public enum PaymentIntentCaptureMethod: String, Codable {
    /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
    case automatic
    /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later. (Not all payment methods support this.)
    case manual
}

public enum PaymentIntentConfirmationMethod: String, Codable {
    /// (Default) PaymentIntent can be confirmed using a publishable key. After `next_action`s are handled, no additional confirmation is required to complete the payment.
    case automatic
    /// All payment attempts must be made using a secret key. The PaymentIntent returns to the `requires_confirmation` state after handling `next_action`s, and requires your server to initiate each payment attempt with an explicit confirmation.
    case manual
}

public struct PaymentIntentNextAction: Codable {
    /// Contains instructions for authenticating a payment by redirecting your customer to Alipay App or website.
    public var alipayHandleRedirect: PaymentIntentNextActionAlipayHandleRedirect?
    /// Contains Boleto details necessary for the customer to complete the payment.
    public var boletoDisplaydetails: PaymentIntentNextActionBoletoDisplayDetails?
    /// Contains instructions for processing off session recurring payments with Indian issued cards.
    public var cardAwaitNotification: PaymentIntentNextActionCardAwaitNotification?
    // TODO: - Add suppport for Bank display once out of preview
    // https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-display_bank_transfer_instructions
    /// Contains Konbini details necessary for the customer to complete the payment.
    public var konbiniDisplayDetails: PaymentIntentNextActionKonbiniDisplayDetails?
    /// Contains OXXO details necessary for the customer to complete the payment.
    public var oxxoDisplayDetails: PaymentIntentNextActionOXXODisplayDetails?
    /// The field that contains PayNow QR code info
    public var paynowDisplayQrCode: PaymentIntentNextActionPaynowDisplayQRCode?
    /// The field that contains Pix QR code info
    // public var pixDisplayQrCode: PaymentIntentNextActionPaynowDisplayQRCode? TODO: - Add preview feature when it's ready.https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-pix_display_qr_code
    /// The field that contains PromptPay QR code info
    public var promptpayDisplayQrCode: PaymentIntentNextActionPromptPayDisplayQRCode?
    /// Contains instructions for authenticating a payment by redirecting your customer to another page or application.
    public var redirectToUrl: PaymentIntentNextActionRedirectToUrl?
    /// Type of the next action to perform, one of `redirect_to_url` or `use_stripe_sdk`, `alipay_handle_redirect`, `oxxo_display_details` or `verify_with_microdeposits`.
    public var type: PaymentIntentNextActionType?
    /// Contains details describing microdeposits verification flow.
    public var verifyWithMicrodeposits: PaymentIntentNextActionVerifyWithMicrodeposits?
    /// The field that contains Wechat Pay QR code info
    public var wechatPayDisplayQrCode: PaymentIntentNextActionWechatPayQRCode?
    /// Info required for android app to app redirect
    public var wechatPayRedirectToAndroidApp: PaymentIntentNextActionWechatPayAndroidApp?
    /// Info required for iOS app to app redirect
    public var wechatPayRedirectToIosApp: PaymentIntentNextActionWechatPayIOSApp?
    
    public init(alipayHandleRedirect: PaymentIntentNextActionAlipayHandleRedirect? = nil,
                boletoDisplaydetails: PaymentIntentNextActionBoletoDisplayDetails? = nil,
                cardAwaitNotification: PaymentIntentNextActionCardAwaitNotification? = nil,
                konbiniDisplayDetails: PaymentIntentNextActionKonbiniDisplayDetails? = nil,
                oxxoDisplayDetails: PaymentIntentNextActionOXXODisplayDetails? = nil,
                paynowDisplayQrCode: PaymentIntentNextActionPaynowDisplayQRCode? = nil,
                promptpayDisplayQrCode: PaymentIntentNextActionPromptPayDisplayQRCode? = nil,
                redirectToUrl: PaymentIntentNextActionRedirectToUrl? = nil,
                type: PaymentIntentNextActionType? = nil,
                verifyWithMicrodeposits: PaymentIntentNextActionVerifyWithMicrodeposits? = nil,
                wechatPayDisplayQrCode: PaymentIntentNextActionWechatPayQRCode? = nil,
                wechatPayRedirectToAndroidApp: PaymentIntentNextActionWechatPayAndroidApp? = nil,
                wechatPayRedirectToIosApp: PaymentIntentNextActionWechatPayIOSApp? = nil) {
        self.alipayHandleRedirect = alipayHandleRedirect
        self.boletoDisplaydetails = boletoDisplaydetails
        self.cardAwaitNotification = cardAwaitNotification
        self.konbiniDisplayDetails = konbiniDisplayDetails
        self.oxxoDisplayDetails = oxxoDisplayDetails
        self.paynowDisplayQrCode = paynowDisplayQrCode
        self.promptpayDisplayQrCode = promptpayDisplayQrCode
        self.redirectToUrl = redirectToUrl
        self.type = type
        self.verifyWithMicrodeposits = verifyWithMicrodeposits
        self.wechatPayDisplayQrCode = wechatPayDisplayQrCode
        self.wechatPayRedirectToAndroidApp = wechatPayRedirectToAndroidApp
        self.wechatPayRedirectToIosApp = wechatPayRedirectToIosApp
    }
}

public enum PaymentIntentStatus: String, Codable {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case requiresCapture = "requires_capture"
    case canceled
    case succeeded
}

public struct PaymentIntentAmountDetails: Codable {
    /// Portion of the amount that corresponds to a tip.
    public var tip: PaymentIntentAmountDetailsTip?
    
    public init(tip: PaymentIntentAmountDetailsTip? = nil) {
        self.tip = tip
    }
}

public struct PaymentIntentAmountDetailsTip: Codable {
    /// Portion of the amount that corresponds to a tip.
    public var amount: Int?
    
    public init(amount: Int? = nil) {
        self.amount = amount
    }
}

public struct PaymentIntentPaymentMethodOptions: Codable {
    /// If the PaymentIntent’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var acssDebit: PaymentIntentPaymentMethodOptionsAcssDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `affirm`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var affirm: PaymentIntentPaymentMethodOptionsAffirm?
    /// If the PaymentIntent’s `payment_method_types` includes `afterpay_clearpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var afterpayClearpay: PaymentIntentPaymentMethodOptionsAfterpayClearpay?
    /// If the PaymentIntent’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var alipay: PaymentIntentPaymentMethodOptionsAlipay?
    /// If the PaymentIntent’s `payment_method_types` includes `au_becs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var auBecsDebit: PaymentIntentPaymentMethodOptionsAUBecsDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `bacs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var bacsDebit: PaymentIntentPaymentMethodOptionsBacsDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var bancontact: PaymentIntentPaymentMethodOptionsBancontact?
    /// If the PaymentIntent’s `payment_method_types` includes blik, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var blik: PaymentIntentPaymentMethodOptionsBlik?
    /// If the PaymentIntent’s `payment_method_types` includes `boleto`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var boleto: PaymentIntentPaymentMethodOptionsBoleto?
    /// If the PaymentIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var card: PaymentIntentPaymentMethodOptionsCard?
    /// If the PaymentIntent’s `payment_method_types` includes `card_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var cardPresent: PaymentIntentPaymentMethodOptionsCardPresent?
    /// If the PaymentIntent’s `payment_method_types` includes `customer_balance`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var customerBalance: PaymentIntentPaymentMethodOptionsCustomerBalance?
    /// If the PaymentIntent’s `payment_method_types` includes `eps`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var eps: PaymentIntentPaymentMethodOptionsEPS?
    /// If the PaymentIntent’s `payment_method_types` includes `fpx`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var fpx: PaymentIntentPaymentMethodOptionsFPX?
    /// If the PaymentIntent’s `payment_method_types` includes `giropay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var giropay: PaymentIntentPaymentMethodOptionsGiropay?
    /// If the PaymentIntent’s `payment_method_types` includes `grabpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var grabpay: PaymentIntentPaymentMethodOptionsGrabPay?
    /// If the PaymentIntent’s `payment_method_types` includes `ideal`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var ideal: PaymentIntentPaymentMethodOptionsIdeal?
    /// If the PaymentIntent’s `payment_method_types` includes `interac_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var interacPresent: PaymentIntentPaymentMethodOptionsInteracPresent?
    /// If the PaymentIntent’s `payment_method_types` includes `klarna`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var klarna: PaymentIntentPaymentMethodOptionsKlarna?
    /// If the PaymentIntent’s `payment_method_types` includes `konbini`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var konbini: PaymentIntentPaymentMethodOptionsKonbini?
    /// If the PaymentIntent’s `payment_method_types` includes `link`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var link: PaymentIntentPaymentMethodOptionsLink?
    /// If the PaymentIntent’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var oxxo: PaymentIntentPaymentMethodOptionsOXXO?
    /// If the PaymentIntent’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var p24: PaymentIntentPaymentMethodOptionsP24?
    /// If the PaymentIntent’s `payment_method_types` includes `paynow`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var paynow: PaymentIntentPaymentMethodOptionsPaynow?
    /// If the PaymentIntent’s `payment_method_types` includes `pix`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var pix: PaymentIntentPaymentMethodOptionsPix?
    /// If the PaymentIntent’s `payment_method_types` includes `promptpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var promptpay: PaymentIntentPaymentMethodOptionsPromptPay?
    /// If the PaymentIntent’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sepaDebit: PaymentIntentPaymentMethodOptionsSepaDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sofort: PaymentIntentPaymentMethodOptionsSofort?
    /// If the PaymentIntent’s `payment_method_types` includes `us_bank_account`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var usBankAccount: PaymentIntentPaymentMethodOptionsUSBankAccount?
    /// If the PaymentIntent’s `payment_method_types` includes `wechat_pay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var wechatPay: PaymentIntentPaymentMethodOptionsWechatPay?
    
    public init(acssDebit: PaymentIntentPaymentMethodOptionsAcssDebit? = nil,
                affirm: PaymentIntentPaymentMethodOptionsAffirm? = nil,
                afterpayClearpay: PaymentIntentPaymentMethodOptionsAfterpayClearpay? = nil,
                alipay: PaymentIntentPaymentMethodOptionsAlipay? = nil,
                auBecsDebit: PaymentIntentPaymentMethodOptionsAUBecsDebit? = nil,
                bacsDebit: PaymentIntentPaymentMethodOptionsBacsDebit? = nil,
                bancontact: PaymentIntentPaymentMethodOptionsBancontact? = nil,
                blik: PaymentIntentPaymentMethodOptionsBlik? = nil,
                boleto: PaymentIntentPaymentMethodOptionsBoleto? = nil,
                card: PaymentIntentPaymentMethodOptionsCard? = nil,
                cardPresent: PaymentIntentPaymentMethodOptionsCardPresent? = nil,
                customerBalance: PaymentIntentPaymentMethodOptionsCustomerBalance? = nil,
                eps: PaymentIntentPaymentMethodOptionsEPS? = nil,
                fpx: PaymentIntentPaymentMethodOptionsFPX? = nil,
                giropay: PaymentIntentPaymentMethodOptionsGiropay? = nil,
                grabpay: PaymentIntentPaymentMethodOptionsGrabPay? = nil,
                ideal: PaymentIntentPaymentMethodOptionsIdeal? = nil,
                interacPresent: PaymentIntentPaymentMethodOptionsInteracPresent? = nil,
                klarna: PaymentIntentPaymentMethodOptionsKlarna? = nil,
                konbini: PaymentIntentPaymentMethodOptionsKonbini? = nil,
                link: PaymentIntentPaymentMethodOptionsLink? = nil,
                oxxo: PaymentIntentPaymentMethodOptionsOXXO? = nil,
                p24: PaymentIntentPaymentMethodOptionsP24? = nil,
                paynow: PaymentIntentPaymentMethodOptionsPaynow? = nil,
                pix: PaymentIntentPaymentMethodOptionsPix? = nil,
                promptpay: PaymentIntentPaymentMethodOptionsPromptPay? = nil,
                sepaDebit: PaymentIntentPaymentMethodOptionsSepaDebit? = nil,
                sofort: PaymentIntentPaymentMethodOptionsSofort? = nil,
                usBankAccount: PaymentIntentPaymentMethodOptionsUSBankAccount? = nil,
                wechatPay: PaymentIntentPaymentMethodOptionsWechatPay? = nil) {
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
        self.giropay = giropay
        self.grabpay = grabpay
        self.ideal = ideal
        self.interacPresent = interacPresent
        self.klarna = klarna
        self.konbini = konbini
        self.link = link
        self.oxxo = oxxo
        self.p24 = p24
        self.paynow = paynow
        self.pix = pix
        self.promptpay = promptpay
        self.sepaDebit = sepaDebit
        self.sofort = sofort
        self.usBankAccount = usBankAccount
        self.wechatPay = wechatPay
    }
}

public struct PaymentIntentList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [PaymentIntent]?
}

public struct PaymentIntentSearchResult: Codable {
    /// A string describing the object type returned.
    public var object: String
    /// A list of charges, paginated by any request parameters.
    public var data: [PaymentIntent]?
    /// Whether or not there are more elements available after this set.
    public var hasMore: Bool?
    /// The URL for accessing this list.
    public var url: String?
    /// The URL for accessing the next page in search results.
    public var nextPage: String?
    /// The total count of entries in the search result, not just the current page.
    public var totalCount: Int?
    
    public init(object: String,
                data: [PaymentIntent]? = nil,
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
