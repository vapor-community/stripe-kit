//
//  PaymentIntent.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

import Foundation

/// The [PaymentIntent Object](https://stripe.com/docs/api/payment_intents/object).
public struct StripePaymentIntent: StripeModel {
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
    public var currency: StripeCurrency?
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
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. For more, learn to save card details after a payment. Stripe uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using off_session will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer.
    public var setupFutureUsage: StripePaymentIntentSetupFutureUsage?
    /// Shipping information for this PaymentIntent.
    public var shipping: StripeShippingLabel?
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

public enum StripePaymentIntentSetupFutureUsage: String, StripeModel {
    case onSession = "on_session"
    case offSession = "off_session"
}

public struct StripePaymentIntentTransferData: StripeModel {
	/// Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    public var amount: Int?
    /// The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to upon payment success.
    public var destination: String?
}

public enum StripePaymentIntentCancellationReason: String, StripeModel {
    case duplicate
    case fraudulent
    case requestedByCustomer = "requested_by_customer"
    case failedInvoice = "failed_invoice"
    case voidInvoice = "void_invoice"
    case automatic
}

public enum StripePaymentIntentCaptureMethod: String, StripeModel {
    /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
    case automatic
    /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later. (Not all payment methods support this.)
    case manual
}

public enum StripePaymentIntentConfirmationMethod: String, StripeModel {
    /// (Default) PaymentIntent can be confirmed using a publishable key. After `next_action`s are handled, no additional confirmation is required to complete the payment.
    case automatic
    /// All payment attempts must be made using a secret key. The PaymentIntent returns to the `requires_confirmation` state after handling `next_action`s, and requires your server to initiate each payment attempt with an explicit confirmation.
    case manual
}

public struct StripePaymentIntentNextAction: StripeModel {
    /// Contains instructions for authenticating a payment by redirecting your customer to another page or application.
    public var redirectToUrl: StripePaymentIntentNextActionRedirectToUrl?
    /// Type of the next action to perform, one of `redirect_to_url` or `use_stripe_sdk`.
    public var type: StripePaymentIntentNextActionType?
}

public struct StripePaymentIntentNextActionRedirectToUrl: StripeModel {
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
    /**
     https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-use_stripe_sdk
     Stripe .net doesn't implement the `use_stripe_sdk` property (probably due to its dynamic nature) so neither am I :)
     https://github.com/stripe/stripe-dotnet/blob/master/src/Stripe.net/Entities/PaymentIntents/PaymentIntentNextAction.cs
     */
}

public enum StripePaymentIntentNextActionType: String, StripeModel {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
}

public enum StripePaymentIntentStatus: String, StripeModel {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case requiresCapture = "requires_capture"
    case canceled
    case succeeded
}

public struct StripePaymentIntentsList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePaymentIntent]?
}

public struct StripePaymentIntentPaymentMethodOptions: StripeModel {
    /// If the PaymentIntent’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var alipay: StripePaymentIntentPaymentMethodOptionsAlipay?
    /// If the PaymentIntent’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var bancontact: StripePaymentIntentPaymentMethodOptionsBancontact?
    /// If the PaymentIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var card: StripePaymentIntentPaymentMethodOptionsCard?
    /// If the PaymentIntent’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var oxxo: StripePaymentIntentPaymentMethodOptionsOXXO?
    /// If the PaymentIntent’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var p24: StripePaymentIntentPaymentMethodOptionsP24?
    /// If the PaymentIntent’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sepaDebit: StripePaymentIntentPaymentMethodOptionsSepaDebit?
    /// If the PaymentIntent’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sofort: StripePaymentIntentPaymentMethodOptionsSofort?
}

public struct StripePaymentIntentPaymentMethodOptionsAlipay: StripeModel {
    
}

public struct StripePaymentIntentPaymentMethodOptionsBancontact: StripeModel {
    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
    public var preferredLanguage: String?
}

public struct StripePaymentIntentPaymentMethodOptionsCard: StripeModel {
    /// Installment details for this payment (Mexico only). For more information, see the installments integration guide.
    public var installments: StripePaymentIntentPaymentMethodOptionsCardInstallments?
    /// Selected network to process this PaymentIntent on. Depends on the available networks of the card attached to the PaymentIntent. Can be only set confirm-time.
    public var network: String?
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Permitted values include: `automatic` or `any`. If not provided, defaults to `automatic`. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: String?
}

public struct StripePaymentIntentPaymentMethodOptionsCardInstallments: StripeModel {
    // TODO: - Rename the charge installment plan.
    /// Installment plans that may be selected for this PaymentIntent.
    public var availablePlans: [StripeChargePaymentDetailsCardInstallmentPlan]?
    /// Whether Installments are enabled for this PaymentIntent.
    public var enabled: Bool?
    /// Installment plan selected for this PaymentIntent.
    public var plan: StripeChargePaymentDetailsCardInstallmentPlan?
}

public struct StripePaymentIntentPaymentMethodOptionsOXXO: StripeModel {
    /// The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set `expires_after_days` to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
    public var expiresAfterDays: Int?
}

public struct StripePaymentIntentPaymentMethodOptionsP24: StripeModel {
}

public struct StripePaymentIntentPaymentMethodOptionsSepaDebit: StripeModel {
    /// Additional fields for Mandate creation
    public var mandateOptions: StripePaymentIntentPaymentMethodOptionsSepaDebitMandateOptions?
}

public struct StripePaymentIntentPaymentMethodOptionsSepaDebitMandateOptions: StripeModel {
}

public struct StripePaymentIntentPaymentMethodOptionsSofort: StripeModel {
    /// Preferred language of the SOFORT authorization page that the customer is redirected to.
    public var preferredLanguage: String?
}
