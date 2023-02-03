//
//  PaymentIntent.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

import Foundation

/// The [PaymentIntent Object](https://stripe.com/docs/api/payment_intents/object)
public struct StripePaymentIntent: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount intended to be collected by this PaymentIntent.
    public var amount: Int?
    /// Amount that can be captured from this PaymentIntent.
    public var amountCapturable: Int?
    /// Amount that was collected by this PaymentIntent.
    public var amountReceived: Int?
    /// ID of the Connect application that created the PaymentIntent.
    public var application: String?
    /// The amount of the application fee (if any) for the resulting payment. See the PaymentIntents [Connect usage guide](https://stripe.com/docs/payments/payment-intents/usage#connect) for details.
    public var applicationFeeAmount: Int?
    /// Settings to configure compatible payment methods from the Stripe Dashboard.
    public var automaticPaymentMethods: StripePaymentIntentAutomaticMaymentMethods?
    /// Populated when `status` is `canceled`, this is the time at which the PaymentIntent was canceled. Measured in seconds since the Unix epoch.
    public var canceledAt: Date?
    /// User-given reason for cancellation of this PaymentIntent, one of `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`.
    public var cancellationReason: StripePaymentIntentCancellationReason?
    /// Capture method of this PaymentIntent, one of `automatic` or `manual`.
    public var captureMethod: StripePaymentIntentCaptureMethod?
    /// Charges that were created by this PaymentIntent, if any.
    public var charges: StripeChargesList?
    /// The client secret of this PaymentIntent. Used for client-side retrieval using a publishable key. Please refer to [dynamic authentication](https://stripe.com/docs/payments/dynamic-authentication) guide on how `client_secret` should be handled.
    public var clientSecret: String?
    /// Confirmation method of this PaymentIntent, one of `manual` or `automatic`.
    public var confirmationMethod: StripePaymentIntentConfirmationMethod?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// ID of the Customer this PaymentIntent is for if one exists.
    @Expandable<StripeCustomer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// ID of the invoice that created this PaymentIntent, if it exists.
    @Expandable<StripeInvoice> public var invoice: String?
    /// The payment error encountered in the previous PaymentIntent confirmation.
    public var lastPaymentError: StripeError?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If present, this property tells you what actions you need to take in order for your customer to fulfill a payment using the provided source.
    public var nextAction: StripePaymentIntentNextAction?
    /// The account (if any) for which the funds of the PaymentIntent are intended. See the PaymentIntents Connect usage guide for details.
    @Expandable<StripeConnectAccount> public var onBehalfOn: String?
    /// ID of the payment method used in this PaymentIntent.
    @Expandable<StripePaymentMethod> public var paymentMethod: String?
    /// Payment-method-specific configuration for this PaymentIntent.
    public var paymentMethodOptions: StripePaymentIntentPaymentMethodOptions?
    /// The list of payment method types (e.g. card) that this PaymentIntent is allowed to use.
    public var paymentMethodTypes: [String]?
    /// Email address that the receipt for the resulting payment will be sent to.
    public var receiptEmail: String?
    /// ID of the review associated with this PaymentIntent, if any.
    @Expandable<StripeReview> public var review: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. For more, learn to save card details after a payment. Stripe uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using `off_session` will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer.
    public var setupFutureUsage: StripePaymentIntentSetupFutureUsage?
    /// Shipping information for this PaymentIntent.
    public var shipping: ShippingLabel?
    /// For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    public var statementDescriptor: String?
    /// Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    public var statementDescriptorSuffix: String?
    /// Status of this PaymentIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `requires_capture`, `canceled`, or `succeeded`.
    public var status: StripePaymentIntentStatus?
    /// The data with which to automatically create a Transfer when the payment is finalized. See the PaymentIntents Connect usage guide for details.
    public var transferData: StripePaymentIntentTransferData?
    /// A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    public var transferGroup: String?
}

public struct StripePaymentIntentAutomaticMaymentMethods: Codable {
    /// Automatically calculates compatible payment methods
    public var enabled: Bool?
}

public enum StripePaymentIntentSetupFutureUsage: String, Codable {
    case onSession = "on_session"
    case offSession = "off_session"
}

public struct StripePaymentIntentTransferData: Codable {
	/// Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    public var amount: Int?
    /// The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to upon payment success.
    public var destination: String?
}

public enum StripePaymentIntentCancellationReason: String, Codable {
    case duplicate
    case fraudulent
    case requestedByCustomer = "requested_by_customer"
    case failedInvoice = "failed_invoice"
    case voidInvoice = "void_invoice"
    case automatic
}

public enum StripePaymentIntentCaptureMethod: String, Codable {
    /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
    case automatic
    /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later. (Not all payment methods support this.)
    case manual
}

public enum StripePaymentIntentConfirmationMethod: String, Codable {
    /// (Default) PaymentIntent can be confirmed using a publishable key. After `next_action`s are handled, no additional confirmation is required to complete the payment.
    case automatic
    /// All payment attempts must be made using a secret key. The PaymentIntent returns to the `requires_confirmation` state after handling `next_action`s, and requires your server to initiate each payment attempt with an explicit confirmation.
    case manual
}

public struct StripePaymentIntentNextAction: Codable {
    /// Contains instructions for authenticating a payment by redirecting your customer to Alipay App or website.
    public var alipayHandleRedirect: StripePaymentIntentNextActionAlipayHandleRedirect?
    /// Contains Boleto details necessary for the customer to complete the payment.
    public var boletoDisplaydetails: StripePaymentIntentNextActionBoletoDisplayDetails?
    /// Contains OXXO details necessary for the customer to complete the payment.
    public var oxxoDisplayDetails: StripePaymentIntentNextActionOXXODisplayDetails?
    /// Contains instructions for authenticating a payment by redirecting your customer to another page or application.
    public var redirectToUrl: StripePaymentIntentNextActionRedirectToUrl?
    /// Type of the next action to perform, one of `redirect_to_url` or `use_stripe_sdk`, `alipay_handle_redirect`, or `oxxo_display_details`.
    public var type: StripePaymentIntentNextActionType?
    /// Contains details describing microdeposits verification flow.
    public var verifyWithMicrodeposits: StripePaymentIntentNextActionVerifyWithMicrodeposits?
    /// The field that contains Wechat Pay QR code info
    public var wechatPayDisplayQrCode: StripePaymentIntentNextActionWechatPayQRCode?
    /// Info required for android app to app redirect
    public var wechatPayRedirectToAndroidApp: StripePaymentIntentNextActionWechatPayAndroidApp?
    /// Info required for iOS app to app redirect
    public var wechatPayRedirectToIosApp: StripePaymentIntentNextActionWechatPayIOSApp?
}

public struct StripePaymentIntentNextActionAlipayHandleRedirect: Codable {
    /// The native data to be used with Alipay SDK you must redirect your customer to in order to authenticate the payment in an Android App.
    public var nativeData: String?
    /// The native URL you must redirect your customer to in order to authenticate the payment in an iOS App.
    public var nativeUrl: String?
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
}

public struct StripePaymentIntentNextActionBoletoDisplayDetails: Codable {
    /// The timestamp after which the boleto expires.
    public var expiresAt: Date?
    /// The URL to the hosted boleto voucher page, which allows customers to view the boleto voucher.
    public var hostedVoucherUrl: String?
    /// The boleto number.
    public var number: String?
    /// The URL to the downloadable boleto voucher PDF.
    public var pdf: String?
}

public struct StripePaymentIntentNextActionOXXODisplayDetails: Codable {
    /// The timestamp after which the OXXO voucher expires.
    public var expiresAfter: Date?
    /// The URL for the hosted OXXO voucher page, which allows customers to view and print an OXXO voucher.
    public var hostedVoucherUrl: String?
    /// OXXO reference number.
    public var number: String?
}

public struct StripePaymentIntentNextActionRedirectToUrl: Codable {
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
}

public enum StripePaymentIntentNextActionType: String, Codable {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
    case alipayHandleRedirect = "alipay_handle_redirect"
    case oxxoDisplayDetails = "oxxo_display_details"
}

public struct StripePaymentIntentNextActionVerifyWithMicrodeposits: Codable {
    /// The timestamp when the microdeposits are expected to land.
    public var arrivalDate: Date?
    /// The URL for the hosted verification page, which allows customers to verify their bank account.
    public var hostedVerificationUrl: String?
}

public struct StripePaymentIntentNextActionWechatPayQRCode: Codable {
    /// The data being used to generate QR code
    public var data: String?
    /// The base64 image data for a pre-generated QR code
    public var imageDataUrl: String?
}

public struct StripePaymentIntentNextActionWechatPayAndroidApp: Codable {
    /// `app_id` is the APP ID registered on WeChat open platform
    public var appId: String?
    /// `nonce_str` is a random string
    public var nonceStr: String?
    /// Package is static value
    public var package: String?
    /// A unique merchant ID assigned by Wechat Pay
    public var partnerId: String?
    /// A unique trading ID assigned by Wechat Pay
    public var prepayId: String?
    /// A signature
    public var sign: String?
    /// Specifies the current time in epoch format
    public var timestamp: String?
}

public struct StripePaymentIntentNextActionWechatPayIOSApp: Codable {
    /// An universal link that redirect to Wechat Pay APP
    public var nativeUrl: String?
}

public enum StripePaymentIntentStatus: String, Codable {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case requiresCapture = "requires_capture"
    case canceled
    case succeeded
}

public struct StripePaymentIntentsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePaymentIntent]?
}

public struct StripePaymentIntentPaymentMethodOptions: Codable {
    /// If the PaymentIntent’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var acssDebit: StripePaymentIntentPaymentMethodOptionsAcssDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `afterpay_clearpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var afterpayClearpay: StripePaymentIntentPaymentMethodOptionsAfterpayClearpay?
    /// If the PaymentIntent’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var alipay: StripePaymentIntentPaymentMethodOptionsAlipay?
    /// If the PaymentIntent’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var bancontact: StripePaymentIntentPaymentMethodOptionsBancontact?
    /// If the PaymentIntent’s `payment_method_types` includes `boleto`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var boleto: StripePaymentIntentPaymentMethodOptionsBoleto?
    /// If the PaymentIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var card: StripePaymentIntentPaymentMethodOptionsCard?
    /// If the PaymentIntent’s `payment_method_types` includes `card_present`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var cardPresent: StripePaymentIntentPaymentMethodOptionsCardPresent?
    /// If the PaymentIntent’s `payment_method_types` includes `giropay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var giropay: StripePaymentIntentPaymentMethodOptionsGiropay?
    /// If the PaymentIntent’s `payment_method_types` includes `ideal`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var ideal: StripePaymentIntentPaymentMethodOptionsIdeal?
    /// If the PaymentIntent’s `payment_method_types` includes `klarna`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var klarna: StripePaymentIntentPaymentMethodOptionsKlarna?
    /// If the PaymentIntent’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var oxxo: StripePaymentIntentPaymentMethodOptionsOXXO?
    /// If the PaymentIntent’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var p24: StripePaymentIntentPaymentMethodOptionsP24?
    /// If the PaymentIntent’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sepaDebit: StripePaymentIntentPaymentMethodOptionsSepaDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sofort: StripePaymentIntentPaymentMethodOptionsSofort?
    /// If the PaymentIntent’s `payment_method_types` includes `wechat_pay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var wechatPay: StripePaymentIntentPaymentMethodOptionsWechatPay?
}

public struct StripePaymentIntentPaymentMethodOptionsAcssDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: StripePaymentIntentPaymentMethodOptionsAcssDebitMandateOptions?
    /// Bank account verification method.
    public var verificationMethod: StripePaymentIntentPaymentMethodOptionsAcssDebitVerificationMethod?
}

public struct StripePaymentIntentPaymentMethodOptionsAcssDebitMandateOptions: Codable {
    /// A URL for custom mandate text
    public var customMandateUrl: String?
    /// Description of the interval. Only required if `payment_schedule` parmeter is `interval` or `combined`.
    public var intervalDescription: String?
    /// Payment schedule for the mandate.
    public var paymentSchedule: StripePaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule?
    /// Transaction type of the mandate.
    public var transactionType: StripePaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType?
}

public enum StripePaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum StripePaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum StripePaymentIntentPaymentMethodOptionsAcssDebitVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

public struct StripePaymentIntentPaymentMethodOptionsAlipay: Codable {}

public struct StripePaymentIntentPaymentMethodOptionsAfterpayClearpay: Codable {
    /// Order identifier shown to the merchant in Afterpay’s online portal. We recommend using a value that helps you answer any questions a customer might have about the payment. The identifier is limited to 128 characters and may contain only letters, digits, underscores, backslashes and dashes.
    public var reference: String?
}

public struct StripePaymentIntentPaymentMethodOptionsBancontact: Codable {
    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
    public var preferredLanguage: String?
}

public struct StripePaymentIntentPaymentMethodOptionsBoleto: Codable {
    /// The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set `expires_after_days` to 2, the Boleto voucher will expire on Wednesday at 23:59 America/Sao_Paulo time.
    public var expiresAfterDays: Int?
}

public struct StripePaymentIntentPaymentMethodOptionsCard: Codable {
    /// Installment details for this payment (Mexico only). For more information, see the installments integration guide.
    public var installments: StripePaymentIntentPaymentMethodOptionsCardInstallments?
    /// Selected network to process this PaymentIntent on. Depends on the available networks of the card attached to the PaymentIntent. Can be only set confirm-time.
    public var network: String?
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Permitted values include: `automatic` or `any`. If not provided, defaults to `automatic`. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: String?
}

public struct StripePaymentIntentPaymentMethodOptionsCardInstallments: Codable {
    // TODO: - Rename the charge installment plan.
    /// Installment plans that may be selected for this PaymentIntent.
    public var availablePlans: [ChargePaymentMethodDetailsCardInstallmentPlan]?
    /// Whether Installments are enabled for this PaymentIntent.
    public var enabled: Bool?
    /// Installment plan selected for this PaymentIntent.
    public var plan: ChargePaymentMethodDetailsCardInstallmentPlan?
}

public struct StripePaymentIntentPaymentMethodOptionsCardPresent: Codable {}

public struct StripePaymentIntentPaymentMethodOptionsGiropay: Codable {}

public struct StripePaymentIntentPaymentMethodOptionsIdeal: Codable {}

public struct StripePaymentIntentPaymentMethodOptionsKlarna: Codable {
    /// Preferred locale of the Klarna checkout page that the customer is redirected to.
    public var preferredLocale: String?
}

public struct StripePaymentIntentPaymentMethodOptionsOXXO: Codable {
    /// The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set `expires_after_days` to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
    public var expiresAfterDays: Int?
}

public struct StripePaymentIntentPaymentMethodOptionsP24: Codable {}

public struct StripePaymentIntentPaymentMethodOptionsSepaDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: StripePaymentIntentPaymentMethodOptionsSepaDebitMandateOptions?
}

public struct StripePaymentIntentPaymentMethodOptionsSepaDebitMandateOptions: Codable {}

public struct StripePaymentIntentPaymentMethodOptionsSofort: Codable {
    /// Preferred language of the SOFORT authorization page that the customer is redirected to.
    public var preferredLanguage: String?
}

public struct StripePaymentIntentPaymentMethodOptionsWechatPay: Codable {
    /// The app ID registered with WeChat Pay. Only required when client is ios or android.
    public var appId: String?
    /// The client type that the end customer will pay from
    public var client: StripePaymentIntentPaymentMethodOptionsWechatPayClient?
}

public enum StripePaymentIntentPaymentMethodOptionsWechatPayClient: String, Codable {
    /// The end customer will pay from web browser
    case web
    /// The end customer will pay from an iOS app
    case ios
    /// The end customer will pay from an Android app
    case android
}
