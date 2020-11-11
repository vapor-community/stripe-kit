//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

/// The [Session Object.](https://stripe.com/docs/api/checkout/sessions/object)
public struct StripeSession: StripeModel {
    /// Unique identifier for the object. Used to pass to redirectToCheckout in Stripe.js.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String?
    /// Total of all items before discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total of all items after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The value (`auto` or `required`) for whether Checkout collected the customer’s billing address.
    public var billingAddressCollection: StripeSessionBillingAddressCollection?
    /// The URL the customer will be directed to if they decide to cancel payment and return to your website.
    public var cancelUrl: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    public var clientReferenceId: String?
    /// The ID of the customer for this session. A new customer will be created unless an existing customer was provided in when the session was created.
    @Expandable<StripeCustomer> public var customer: String?
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
    @Expandable<StripePaymentIntent> public var paymentIntent: String?
    /// A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept.
    public var paymentMethodTypes: [StripeSessionPaymentMethodType]?
    /// The payment status of the Checkout Session, one of paid, unpaid, or no_payment_required. You can use this value to decide when to fulfill your customer’s order.
    public var paymentStatus: StripeSessionPaymentStatus?
    /// The ID of the SetupIntent for Checkout Sessions in setup mode.
    @Expandable<StripeSetupIntent> public var setupIntent: String?
    /// Shipping information for this Checkout Session.
    public var shipping: StripeShippingLabel?
    /// When set, provides configuration for Checkout to collect a shipping address from a customer.
    public var shippingAddressCollection: StripeSessionShippingAddressCollection?
    /// Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode. Supported values are `auto`, `book`, `donate`, or `pay`.
    public var submitType: StripeSessionSubmitType?
    /// The ID of the subscription created if one or more plans were provided.
    @Expandable<StripeSubscription> public var subscription: String?
    /// The URL the customer will be directed to after the payment or subscription creation is successful.
    public var successUrl: String?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: StripeSessionTotalDetails?
}

public struct StripeSessionList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSession]?
}

public enum StripeSessionBillingAddressCollection: String, StripeModel {
    case auto
    case required
}

public struct StripeSessionLineItem: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Total before any discounts or taxes is applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes.
    public var amountTotal: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
    public var description: String?
    /// The discounts applied to the line item. This field is not included by default. To include it in the response, expand the `discounts` field.
    public var discounts: [StripeSessionLineItemDiscount]?
    /// The price used to generate the line item.
    public var price: StripePrice?
    /// The quantity of products being purchased.
    public var quantity: Int?
    /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [StripeSessionLineItemTax]?
}

public struct StripeSessionLineItemDiscount: StripeModel {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: StripeDiscount?
}

public struct StripeSessionLineItemTax: StripeModel {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: StripeTaxRate?
}

public struct StripeSessionLineItemList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSessionLineItem]?
}

public enum StripeSessionLocale: String, StripeModel {
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
}

public enum StripeSessionMode: String, StripeModel {
    case payment
    case setup
    case subscription
}

public enum StripeSessionPaymentMethodType: String, StripeModel {
    case card
    case ideal
    case fpx
    case bacsDebit = "bacs_debit"
    case bancontact
    case giropay
    case p24
    case eps
}

public struct StripeSessionShippingAddressCollection: StripeModel {
    /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
    public var allowedCountries: [String]?
}

public enum StripeSessionSubmitType: String, StripeModel {
    case auto
    case book
    case donate
    case pay
}

public struct StripeSessionTotalDetails: StripeModel {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals. This field is not included by default. To include it in the response, expand the breakdown field.
    public var breakdown: StripeSessionTotalDetailsBreakdown?
}

public struct StripeSessionTotalDetailsBreakdown: StripeModel {
    /// The aggregated line item discounts.
    public var discounts: [StripeSessionLineItemDiscount]?
    /// The aggregated line item tax amounts by rate.
    public var taxes: [StripeSessionLineItemTax]?
}

public enum StripeSessionPaymentStatus: String, StripeModel {
    /// The payment funds are available in your account.
    case paid
    /// The payment funds are not yet available in your account.
    case unpaid
    /// The Checkout Session is in setup mode and doesn’t require a payment at this time.
    case noPaymentRequired = "no_payment_required"
}
