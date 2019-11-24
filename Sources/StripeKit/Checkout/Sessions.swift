//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

/// The [Session Object](https://stripe.com/docs/api/checkout/sessions/object).
public struct StripeSession: StripeModel {
    /// Unique identifier for the object. Used to pass to redirectToCheckout in Stripe.js.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String?
    /// The value (`auto` or `required`) for whether Checkout collected the customer’s billing address.
    public var billingAddressCollection: StripeSessionBillingAddressCollection?
    /// The URL the customer will be directed to if they decide to cancel payment and return to your website.
    public var cancelUrl: String?
    /// A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    public var clientReferenceId: String?
    /// The ID of the customer for this session. A new customer will be created unless an existing customer was provided in when the session was created.
    public var customer: String?
    /// If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the `customer` field.
    public var customerEmail: String?
    /// The line items, plans, or SKUs purchased by the customer.
    public var displayItems: [StripeSessionDisplayItem]?
    /// Has the `value` true if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser’s locale is used.
    public var locale: StripeSessionLocale?
    /// The mode of the Checkout Session, one of `payment`, `setup`, or `subscription`.
    public var mode: StripeSessionMode?
    /// The ID of the PaymentIntent created if SKUs or line items were provided.
    public var paymentIntent: String?
    /// A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept.
    public var paymentMethodTypes: [StripePaymentMethodType]?
    /// The ID of the SetupIntent for Checkout Sessions in setup mode.
    public var setupIntent: String?
    /// Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode. Supported values are `auto`, `book`, `donate`, or `pay`.
    public var submitType: StripeSessionSubmitType?
    /// The ID of the subscription created if one or more plans were provided.
    public var subscription: String?
    /// The URL the customer will be directed to after the payment or subscription creation is successful.
    public var successUrl: String?
}

public enum StripeSessionBillingAddressCollection: String, StripeModel {
    case auto
    case required
}

public struct StripeSessionDisplayItem: StripeModel {
    /// Amount for the display item.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    public var custom: StripeSessionDisplayItemCustom?
    /// Quantity of the display item being purchased.
    public var quantity: Int?
    /// The type of display item. One of custom, plan or sku
    public var type: StripeSessionDisplayItemType?
    public var sku: StripeSKU?
    public var plan: StripePlan?
}

public struct StripeSessionDisplayItemCustom: StripeModel {
    /// The description of the line item.
    public var description: String?
    /// The images of the line item.
    public var images: [String]?
    /// The name of the line item.
    public var name: String?
}

public enum StripeSessionDisplayItemType: String, StripeModel {
    case custom
    case plan
    case sku
}

public enum StripeSessionLocale: String, StripeModel {
    case auto
    case da
    case de
    case en
    case es
    case fi
    case fr
    case it
    case ja
    case nb
    case nl
    case pl
    case pt
    case sv
    case zh
}

public enum StripeSessionMode: String, StripeModel {
    case payment
    case setup
    case subscription
}

public enum StripeSessionSubmitType: String, StripeModel {
    case auto
    case book
    case donate
    case pay
}
