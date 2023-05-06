//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

/// The [Session Object.](https://stripe.com/docs/api/checkout/sessions/object)
public struct StripeSession: Codable {
    /// Unique identifier for the object. Used to pass to redirectToCheckout in Stripe.js.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String?
    /// Enables user redeemable promotion codes.
    public var allowPromotionCodes: Bool?
    /// Total of all items before discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total of all items after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The value (`auto` or `required`) for whether Checkout collected the customer’s billing address.
    public var billingAddressCollection: StripeSessionBillingAddressCollection?
    /// The URL the customer will be directed to if they decide to cancel payment and return to your website.
    public var cancelUrl: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    public var clientReferenceId: String?
    /// The ID of the customer for this session. A new customer will be created unless an existing customer was provided in when the session was created.
    @Expandable<Customer> public var customer: String?
    /// The customer details including the customer’s tax exempt status and the customer’s tax IDs. Only present on Sessions in `payment` or `subscription` mode.
    public var customerDetails: StripeSessionCustomerDetails?
    /// If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the `customer` field.
    public var customerEmail: String?
    /// The line items purchased by the customer. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `line_items` field.
    public var lineItems: StripeSessionLineItemList?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Has the `value` true if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser’s locale is used.
    public var locale: StripeSessionLocale?
    /// The mode of the Checkout Session, one of `payment`, `setup`, or `subscription`.
    public var mode: StripeSessionMode?
    /// The ID of the PaymentIntent created if SKUs or line items were provided.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    /// Payment-method-specific configuration for the PaymentIntent or SetupIntent of this CheckoutSession.
    public var paymentMethodOptions: StripeSessionPaymentMethodOptions?
    /// Details on the state of phone number collection for the session.
    public var phoneNumberCOllection: StripeSessionPhoneNumberCollection?
    /// A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept.
    public var paymentMethodTypes: [StripeSessionPaymentMethodType]?
    /// The payment status of the Checkout Session, one of `paid`, `unpaid`, or `no_payment_required`. You can use this value to decide when to fulfill your customer’s order.
    public var paymentStatus: StripeSessionPaymentStatus?
    /// The ID of the SetupIntent for Checkout Sessions in setup mode.
    @Expandable<SetupIntent> public var setupIntent: String?
    /// Shipping information for this Checkout Session.
    public var shipping: ShippingLabel?
    /// When set, provides configuration for Checkout to collect a shipping address from a customer.
    public var shippingAddressCollection: StripeSessionShippingAddressCollection?
    /// The shipping rate options applied to this Session.
    public var shipppingOptions: [StripeSessionShippingOption]?
    /// The ID of the ShippingRate for Checkout Sessions in payment mode.
    @Expandable<StripeShippingRate> public var shippingRate: String?
    /// Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode. Supported values are `auto`, `book`, `donate`, or `pay`.
    public var submitType: StripeSessionSubmitType?
    /// The status of the Checkout Session, one of `open`, `complete`, or `expired`.
    public var status: StripeSessionStatus?
    /// The ID of the subscription created if one or more plans were provided.
    @Expandable<StripeSubscription> public var subscription: String?
    /// The URL the customer will be directed to after the payment or subscription creation is successful.
    public var successUrl: String?
    /// Details on the state of tax ID collection for the session.
    public var taxIdCollection: StripeSessionTaxIdCollection?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: StripeSessionTotalDetails?
    /// The URL to the Checkout Session.
    public var url: String?
}

public struct StripeSessionList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSession]?
}

public enum StripeSessionBillingAddressCollection: String, Codable {
    case auto
    case required
}

public struct StripeSessionCustomerDetails: Codable {
    /// The customer’s email at time of checkout.
    public var email: String?
    /// The customer’s tax exempt status at time of checkout.
    public var taxExempt: String?
    /// The customer’s tax IDs at time of checkout.
    public var taxIds: [StripeSessionCustomerDetailsTaxId]?
    /// The customer’s phone number at the time of checkout
    public var phone: String?
}

public struct StripeSessionCustomerDetailsTaxId: Codable {
    /// The type of the tax ID.
    public var type: StripeTaxIDType
    /// The value of the tax ID.
    public var value: String?
}

public struct StripeSessionLineItem: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Total before any discounts or taxes is applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes.
    public var amountTotal: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
    public var description: String?
    /// The discounts applied to the line item. This field is not included by default. To include it in the response, expand the `discounts` field.
    public var discounts: [StripeSessionLineItemDiscount]?
    /// The price used to generate the line item.
    public var price: Price?
    /// The quantity of products being purchased.
    public var quantity: Int?
    /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [StripeSessionLineItemTax]?
}

public struct StripeSessionLineItemDiscount: Codable {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: StripeDiscount?
}

public struct StripeSessionLineItemTax: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: StripeTaxRate?
}

public struct StripeSessionLineItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSessionLineItem]?
}

public enum StripeSessionLocale: String, Codable {
    case auto
    case bg
    case cs
    case da
    case de
    case el
    case en
    case enGB = "en-GB"
    case es
    case es419 = "es-419"
    case et
    case fi
    case fr
    case frCA = "fr-CA"
    case hu
    case id
    case it
    case ja
    case lt
    case lv
    case ms
    case mt
    case nb
    case nl
    case pl
    case pt
    case ptBR = "pt-BR"
    case ro
    case ru
    case sk
    case sl
    case sv
    case tr
    case zh
    case zhHk = "zh-HK"
    case zhTw = "zh-TW"
}

public enum StripeSessionMode: String, Codable {
    case payment
    case setup
    case subscription
}

public struct StripeSessionPaymentMethodOptions: Codable {
    /// If the Checkout Session’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var acssDebit: StripeSessionPaymentMethodOptionsAcssDebit?
    /// If the Checkout Session’s `payment_method_types` includes boleto, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var boleto: StripeSessionPaymentMethodOptionsBoleto?
    /// If the Checkout Session’s `payment_method_types` includes oxxo, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var oxxo: StripeSessionPaymentMethodOptionsOXXO?
}

public struct StripeSessionPhoneNumberCollection: Codable {
    /// Indicates whether phone number collection is enabled for the session
    public var enabled: Bool
}

public struct StripeSessionPaymentMethodOptionsAcssDebit: Codable {
    /// Currency supported by the bank account. Returned when the Session is in `setup` mode.
    public var currency: StripeSessionPaymentMethodOptionsAcssDebitCurrency?
    /// Additional fields for Mandate creation
    public var mandateOptions: StripeSessionPaymentMethodOptionsAcssDebitMandateOptions?
    /// Bank account verification method.
    public var verificationMethod: StripeSessionPaymentMethodOptionsAcssDebitVerificationMethod?
}

public enum StripeSessionPaymentMethodOptionsAcssDebitCurrency: String, Codable {
    case cad
    case usd
}

public struct StripeSessionPaymentMethodOptionsAcssDebitMandateOptions: Codable {
    /// A URL for custom mandate text
    public var customMandateUrl: String?
    /// Description of the interval. Only required if `payment_schedule` parmeter is `interval` or `combined`.
    public var intervalDescription: String?
    /// Payment schedule for the mandate.
    public var paymentSchedule: StripeSessionPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule?
    /// Transaction type of the mandate.
    public var transactionType: StripeSessionPaymentMethodOptionsAcssDebitMandateOptionsTransactionType?
}

public enum StripeSessionPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum StripeSessionPaymentMethodOptionsAcssDebitMandateOptionsTransactionType: String, Codable {
    /// Transaction are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

public enum StripeSessionPaymentMethodOptionsAcssDebitVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

public struct StripeSessionPaymentMethodOptionsBoleto: Codable {
    /// The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set  `expires_after_days` to 2, the Boleto voucher will expire on Wednesday at 23:59 America/Sao_Paulo time.
    public var expiresAfterDays: Int?
}

public struct StripeSessionPaymentMethodOptionsOXXO: Codable {
    /// The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set `expires_after_days` to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
    public var expiresAfterDays: Int?
}

public enum StripeSessionPaymentMethodType: String, Codable {
    case alipay
    case card
    case ideal
    case fpx
    case bacsDebit = "bacs_debit"
    case bancontact
    case giropay
    case p24
    case eps
    case sofort
    case sepaDebit = "sepa_debit"
    case grabpay
    case afterpayClearpay = "afterpay_clearpay"
    case acssDebit = "acss_debit"
    case wechatPay = "wechat_pay"
    case boleto
    case oxxo
}

public struct StripeSessionShippingAddressCollection: Codable {
    /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
    public var allowedCountries: [String]?
}

public struct StripeSessionShippingOption: Codable {
    /// A non-negative integer in cents representing how much to charge.
    public var shippingAmount: Int?
    /// The shipping rate.
    @Expandable<StripeShippingRate> public var shippingRate: String?
}

public enum StripeSessionSubmitType: String, Codable {
    case auto
    case book
    case donate
    case pay
}

public enum StripeSessionStatus: String, Codable {
    /// The checkout session is still in progress. Payment processing has not started
    case open
    /// The checkout session is complete. Payment processing may still be in progress
    case complete
    /// The checkout session has expired. No further processing will occur
    case expired
}

public struct StripeSessionTotalDetails: Codable {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item shipping amounts.
    public var amountShipping: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals. This field is not included by default. To include it in the response, expand the breakdown field.
    public var breakdown: StripeSessionTotalDetailsBreakdown?
}

public struct StripeSessionTotalDetailsBreakdown: Codable {
    /// The aggregated line item discounts.
    public var discounts: [StripeSessionLineItemDiscount]?
    /// The aggregated line item tax amounts by rate.
    public var taxes: [StripeSessionLineItemTax]?
}

public enum StripeSessionPaymentStatus: String, Codable {
    /// The payment funds are available in your account.
    case paid
    /// The payment funds are not yet available in your account.
    case unpaid
    /// The Checkout Session is in setup mode and doesn’t require a payment at this time.
    case noPaymentRequired = "no_payment_required"
}

public struct StripeSessionTaxIdCollection: Codable {
    /// Indicates whether tax ID collection is enabled for the session
    public var enabled: Bool?
}
