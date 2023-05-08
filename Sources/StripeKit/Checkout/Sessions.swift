//
//  Sessions.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//
import Foundation

/// The [Session Object.](https://stripe.com/docs/api/checkout/sessions/object)
public struct Session: Codable {
    /// Unique identifier for the object. Used to pass to redirectToCheckout in Stripe.js.
    public var id: String
    /// The URL the customer will be directed to if they decide to cancel payment and return to your website.
    public var cancelUrl: String?
    /// A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    public var clientReferenceId: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The ID of the customer for this session. A new customer will be created unless an existing customer was provided in when the session was created.
    @Expandable<Customer> public var customer: String?
    /// If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the `customer` field.
    public var customerEmail: String?
    /// The line items purchased by the customer. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `line_items` field.
    public var lineItems: SessionLineItemList?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The mode of the Checkout Session, one of `payment`, `setup`, or `subscription`.
    public var mode: SessionMode?
    /// The ID of the PaymentIntent created if SKUs or line items were provided.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    /// The payment status of the Checkout Session, one of `paid`, `unpaid`, or `no_payment_required`. You can use this value to decide when to fulfill your customer’s order.
    public var paymentStatus: SessionPaymentStatus?
    /// The status of the Checkout Session, one of `open`, `complete`, or `expired`.
    public var status: SessionStatus?
    /// The URL the customer will be directed to after the payment or subscription creation is successful.
    public var successUrl: String?
    /// The URL to the Checkout Session.
    public var url: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String?
    /// When set, provides configuration for actions to take if this Checkout Session expires.
    public var afterExpiration: SessionAfterExpiration?
    /// Enables user redeemable promotion codes.
    public var allowPromotionCodes: Bool?
    /// Total of all items before discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total of all items after discounts and taxes are applied.
    public var amountTotal: Int?
    /// Details on the state of automatic tax for the session, including the status of the latest tax calculation.
    public var automaticTax: SessionAutomaticTax?
    /// The value (`auto` or `required`) for whether Checkout collected the customer’s billing address.
    public var billingAddressCollection: SessionBillingAddressCollection?
    /// Results of `consent_collection` for this session.
    public var consent: SessionConsent?
    /// When set, provides configuration for the Checkout Session to gather active consent from customers.
    public var consentCollection: SessionConsentCollection?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Currency conversion details for automatic currency conversion sessions
    public var currencyConversion: SessionCurrencyConversion?
    /// Collect additional information from your customer using custom fields. Up to 2 fields are supported.
    public var customFields: [SessionCustomField]?
    /// Display additional text for your customers using custom text.
    public var customText: SessionCustomText?
    /// Configure whether a Checkout Session creates a Customer when the Checkout Session completes.
    public var customerCreation: SessionCustomerCreation?
    /// The customer details including the customer’s tax exempt status and the customer’s tax IDs. Only present on Sessions in `payment` or `subscription` mode.
    public var customerDetails: SessionCustomerDetails?
    /// The timestamp at which the Checkout Session will expire
    public var expiresAt: Date?
    /// ID of the invoice created by the Checkout Session, if it exists.
    @Expandable<StripeInvoice> public var invoice: String?
    /// Details on the state of invoice creation for the Checkout Session.
    public var invoiceCreation: SessionInvoiceCreation?
    /// Has the `value` true if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser’s locale is used.
    public var locale: SessionLocale?
    /// The ID of the Payment Link that created this Session.
    public var paymentLink: String? // TODO: - Add expandable payment link
    /// Configure whether a Checkout Session should collect a payment method.
    public var paymentMethodCollection: SessionPaymentMethodCollection?
    /// Payment-method-specific configuration for the PaymentIntent or SetupIntent of this CheckoutSession.
    public var paymentMethodOptions: SessionPaymentMethodOptions?
    /// A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept.
    public var paymentMethodTypes: [String]?
    /// Details on the state of phone number collection for the session.
    public var phoneNumberCollection: SessionPhoneNumberCollection?
    /// The ID of the original expired Checkout Session that triggered the recovery flow.
    public var recoveredFrom: String?
    /// The ID of the SetupIntent for Checkout Sessions in setup mode.
    @Expandable<SetupIntent> public var setupIntent: String?
    /// When set, provides configuration for Checkout to collect a shipping address from a customer.
    public var shippingAddressCollection: SessionShippingAddressCollection?
    /// The ID of the ShippingRate for Checkout Sessions in payment mode.
    @Expandable<ShippingRate> public var shippingRate: String?
    /// The details of the customer cost of shipping, including the customer chosen ShippingRate.
    public var shippingCost: SessionShippingCost?
    /// Shipping information for this Checkout Session.
    public var shippingDetails: ShippingLabel?
    /// The shipping rate options applied to this Session.
    public var shipppingOptions: [SessionShippingOption]?
    /// Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode.
    public var submitType: SessionSubmitType?
    /// The ID of the subscription created if one or more plans were provided.
    @Expandable<StripeSubscription> public var subscription: String?
    /// Details on the state of tax ID collection for the session.
    public var taxIdCollection: SessionTaxIdCollection?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: SessionTotalDetails?
    
    public init(id: String,
                cancelUrl: String? = nil,
                clientReferenceId: String? = nil,
                currency: Currency? = nil,
                customer: String? = nil,
                customerEmail: String? = nil,
                lineItems: SessionLineItemList? = nil,
                metadata: [String : String]? = nil,
                mode: SessionMode? = nil,
                paymentIntent: String? = nil,
                paymentStatus: SessionPaymentStatus? = nil,
                status: SessionStatus? = nil,
                successUrl: String? = nil,
                url: String? = nil,
                object: String? = nil,
                afterExpiration: SessionAfterExpiration? = nil,
                allowPromotionCodes: Bool? = nil,
                amountSubtotal: Int? = nil,
                amountTotal: Int? = nil,
                automaticTax: SessionAutomaticTax? = nil,
                billingAddressCollection: SessionBillingAddressCollection? = nil,
                consent: SessionConsent? = nil,
                consentCollection: SessionConsentCollection? = nil,
                created: Date,
                currencyConversion: SessionCurrencyConversion? = nil,
                customFields: [SessionCustomField]? = nil,
                customText: SessionCustomText? = nil,
                customerCreation: SessionCustomerCreation? = nil,
                customerDetails: SessionCustomerDetails? = nil,
                expiresAt: Date? = nil,
                invoice: String? = nil,
                invoiceCreation: SessionInvoiceCreation? = nil,
                livemode: Bool? = nil,
                locale: SessionLocale? = nil,
                paymentLink: String? = nil,
                paymentMethodCollection: SessionPaymentMethodCollection? = nil,
                paymentMethodOptions: SessionPaymentMethodOptions? = nil,
                paymentMethodTypes: [String]? = nil,
                phoneNumberCollection: SessionPhoneNumberCollection? = nil,
                recoveredFrom: String? = nil,
                setupIntent: String? = nil,
                shippingAddressCollection: SessionShippingAddressCollection? = nil,
                shippingRate: String? = nil,
                shippingCost: SessionShippingCost? = nil,
                shippingDetails: ShippingLabel? = nil,
                shipppingOptions: [SessionShippingOption]? = nil,
                submitType: SessionSubmitType? = nil,
                subscription: String? = nil,
                taxIdCollection: SessionTaxIdCollection? = nil,
                totalDetails: SessionTotalDetails? = nil) {
        self.id = id
        self.cancelUrl = cancelUrl
        self.clientReferenceId = clientReferenceId
        self.currency = currency
        self._customer = Expandable(id: customer)
        self.customerEmail = customerEmail
        self.lineItems = lineItems
        self.metadata = metadata
        self.mode = mode
        self._paymentIntent = Expandable(id: paymentIntent)
        self.paymentStatus = paymentStatus
        self.status = status
        self.successUrl = successUrl
        self.url = url
        self.object = object
        self.afterExpiration = afterExpiration
        self.allowPromotionCodes = allowPromotionCodes
        self.amountSubtotal = amountSubtotal
        self.amountTotal = amountTotal
        self.automaticTax = automaticTax
        self.billingAddressCollection = billingAddressCollection
        self.consent = consent
        self.consentCollection = consentCollection
        self.created = created
        self.currencyConversion = currencyConversion
        self.customFields = customFields
        self.customText = customText
        self.customerCreation = customerCreation
        self.customerDetails = customerDetails
        self.expiresAt = expiresAt
        self._invoice = Expandable(id: invoice)
        self.invoiceCreation = invoiceCreation
        self.livemode = livemode
        self.locale = locale
        self.paymentLink = paymentLink
        self.paymentMethodCollection = paymentMethodCollection
        self.paymentMethodOptions = paymentMethodOptions
        self.paymentMethodTypes = paymentMethodTypes
        self.phoneNumberCollection = phoneNumberCollection
        self.recoveredFrom = recoveredFrom
        self._setupIntent = Expandable(id: setupIntent)
        self.shippingAddressCollection = shippingAddressCollection
        self._shippingRate = Expandable(id: shippingRate)
        self.shippingCost = shippingCost
        self.shippingDetails = shippingDetails
        self.shipppingOptions = shipppingOptions
        self.submitType = submitType
        self._subscription = Expandable(id: subscription)
        self.taxIdCollection = taxIdCollection
        self.totalDetails = totalDetails
    }
}

public struct SessionCustomField: Codable {
    /// Configuration for `type=dropdown` fields.
    public var dropdown: SessionCustomFieldDropdown?
    /// String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
    public var key: String?
    /// The label for the field, displayed to the customer.
    public var label: SessionCustomFieldLabel?
    /// Configuration for `type=numeric` fields.
    public var numeric: SessionCustomFieldNumeric?
    /// Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
    public var optional: Bool?
    /// Configuration for `type=text` fields.
    public var text: SessionCustomFieldText?
    /// The type of the field.
    public var type: SessionCustomFieldType?
    
    public init(dropdown: SessionCustomFieldDropdown? = nil,
                key: String? = nil,
                label: SessionCustomFieldLabel? = nil,
                numeric: SessionCustomFieldNumeric? = nil,
                optional: Bool? = nil,
                text: SessionCustomFieldText? = nil,
                type: SessionCustomFieldType? = nil) {
        self.dropdown = dropdown
        self.key = key
        self.label = label
        self.numeric = numeric
        self.optional = optional
        self.text = text
        self.type = type
    }
}

public struct SessionCustomFieldDropdown: Codable {
    /// The options available for the customer to select. Up to 200 options allowed
    public var options: [SessionCustomFieldDropdownOption]?
    /// The option selected by the customer. This will be the `value` for the option.
    public var value: String?
    
    public init(options: [SessionCustomFieldDropdownOption]? = nil,
                value: String? = nil) {
        self.options = options
        self.value = value
    }
}

public struct SessionCustomFieldDropdownOption: Codable {
    /// The label for the option, displayed to the customer. Up to 100 characters.
    public var label: String?
    /// The value for this option, not displayed to the customer, used by your integration to reconcile the option selected by the customer. Must be unique to this option, alphanumeric, and up to 100 characters.
    public var value: String?
    
    public init(label: String? = nil, value: String? = nil) {
        self.label = label
        self.value = value
    }
}

public struct SessionCustomFieldLabel: Codable {
    /// Custom text for the label, displayed to the customer. Up to 50 characters.
    public var custom: String?
    ///The type of the label.
    public var type: SessionCustomFieldLabelType?
    
    public init(custom: String? = nil, type: SessionCustomFieldLabelType? = nil) {
        self.custom = custom
        self.type = type
    }
}

public enum SessionCustomFieldLabelType: String, Codable {
    /// Set a custom label for the field.
    case custom
}

public struct SessionCustomFieldNumeric: Codable {
    /// The maximum character length constraint for the customer’s input.
    public var maximumLength: Int?
    /// The minimum character length requirement for the customer’s input.
    public var minimumLength: Int?
    /// The value entered by the customer, containing only digits.
    public var value: String?
    
    public init(maximumLength: Int? = nil,
                minimumLength: Int? = nil,
                value: String? = nil) {
        self.maximumLength = maximumLength
        self.minimumLength = minimumLength
        self.value = value
    }
}

public struct SessionCustomFieldText: Codable {
    /// The maximum character length constraint for the customer’s input.
    public var maximumLength: Int?
    /// The minimum character length requirement for the customer’s input.
    public var minimumLength: Int?
    /// The value entered by the customer.
    public var value: String?
    
    public init(maximumLength: Int? = nil,
                minimumLength: Int? = nil,
                value: String? = nil) {
        self.maximumLength = maximumLength
        self.minimumLength = minimumLength
        self.value = value
    }
}

public enum SessionCustomFieldType: String, Codable {
    /// Collect a string field from your customer.
    case text
    /// Collect a numbers-only field from your customer.
    case numeric
    /// Provide a list of options for your customer to select.
    case dropdown
}

public struct SessionCustomText: Codable {
    /// Custom text that should be displayed alongside shipping address collection.
    public var shippingAddress: SessionCustomTextShippingAddress?
    /// Custom text that should be displayed alongside the payment confirmation button.
    public var submit: SessionCustomTextSubmit?
    
    public init(shippingAddress: SessionCustomTextShippingAddress? = nil,
                submit: SessionCustomTextSubmit? = nil) {
        self.shippingAddress = shippingAddress
        self.submit = submit
    }
}

public struct SessionCustomTextShippingAddress: Codable {
    /// Text may be up to 1000 characters in length.
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}

public struct SessionCustomTextSubmit: Codable {
    /// Text may be up to 1000 characters in length.
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}

public enum SessionCustomerCreation: String, Codable {
    /// The Checkout Session will only create a Customer if it is required for Session confirmation. Currently, only `subscription` mode Sessions require a Customer.
    case ifRequired
    /// The Checkout Session will always create a Customer when a Session confirmation is attempted.
    case always
}
public struct SessionInvoiceCreation: Codable {
    /// Indicates whether invoice creation is enabled for the Checkout Session.
    public var enabled: Bool?
    /// Parameters passed when creating invoices for payment-mode Checkout Sessions.
    public var invoiceData: SessionInvoiceCreationInvoiceData?
    
    public init(enabled: Bool? = nil, invoiceData: SessionInvoiceCreationInvoiceData? = nil) {
        self.enabled = enabled
        self.invoiceData = invoiceData
    }
}

public struct SessionInvoiceCreationInvoiceData: Codable {
    /// The account tax IDs associated with the invoice
    @ExpandableCollection<StripeTaxID> public var accountTaxIds: [String]?
    /// Custom fields displayed on the invoice.
    public var customFields: [SessionInvoiceCreationInvoiceDataCustomFields]?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Footer displayed on the invoice.
    public var footer: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Options for invoice PDF rendering.
    public var renderingOptions: SessionInvoiceCreationInvoiceDataRenderingOptions?
    
    public init(accountTaxIds: [String]? = nil,
                customFields: [SessionInvoiceCreationInvoiceDataCustomFields]? = nil,
                description: String? = nil,
                footer: String? = nil,
                metadata: [String : String]? = nil,
                renderingOptions: SessionInvoiceCreationInvoiceDataRenderingOptions? = nil) {
        self._accountTaxIds = ExpandableCollection(ids: accountTaxIds)
        self.customFields = customFields
        self.description = description
        self.footer = footer
        self.metadata = metadata
        self.renderingOptions = renderingOptions
    }
}

public struct SessionInvoiceCreationInvoiceDataCustomFields: Codable {
    /// The name of the custom field.
    public var name: String?
    /// The value of the custom field.
    public var value: String?
    
    public init(name: String? = nil, value: String? = nil) {
        self.name = name
        self.value = value
    }
}

public struct SessionInvoiceCreationInvoiceDataRenderingOptions: Codable {
    /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
    public var amountTaxDisplay: String?
    
    public init(amountTaxDisplay: String? = nil) {
        self.amountTaxDisplay = amountTaxDisplay
    }
}

public struct SessionAfterExpiration: Codable {
    /// When set, configuration used to recover the Checkout Session on expiry.
    public var recovery: SessionAfterExpirationRecovery?
    
    public init(recovery: SessionAfterExpirationRecovery? = nil) {
        self.recovery = recovery
    }
}

public struct SessionAfterExpirationRecovery: Codable {
    /// Enables user redeemable promotion codes on the recovered Checkout Sessions. Defaults to `false`
    public var allowPromotionCodes: Bool?
    /// If `true`, a recovery url will be generated to recover this Checkout Session if it expires before a transaction is completed. It will be attached to the Checkout Session object upon expiration.
    public var enabled: Bool?
    /// The timestamp at which the recovery URL will expire.
    public var expiresAt: Date?
    /// URL that creates a new Checkout Session when clicked that is a copy of this expired Checkout Session
    public var url: String?
    
    public init(allowPromotionCodes: Bool? = nil,
                enabled: Bool? = nil,
                expiresAt: Date? = nil,
                url: String? = nil) {
        self.allowPromotionCodes = allowPromotionCodes
        self.enabled = enabled
        self.expiresAt = expiresAt
        self.url = url
    }
}

public struct SessionAutomaticTax: Codable {
    /// Indicates whether automatic tax is enabled for the session.
    public var enabled: Bool?
    /// The status of the most recent automated tax calculation for this session.
    public var status: SessionAutomaticTaxStatus?
}

public enum SessionAutomaticTaxStatus: String, Codable {
    /// The location details entered by the customer aren’t valid or don’t provide enough location information to accurately determine tax rates.
    case requiresLocationInputs = "requires_location_inputs"
    /// Stripe successfully calculated tax automatically for this session.
    case complete
    /// The Stripe Tax service failed.
    case failed
}

public enum SessionBillingAddressCollection: String, Codable {
    /// Checkout will only collect the billing address when necessary. When using `automatic_tax`, Checkout will collect the minimum number of fields required for tax calculation.
    case auto
    /// Checkout will always collect the customer’s billing address.
    case required
}

public struct SessionConsent: Codable {
    /// If `opt_in`, the customer consents to receiving promotional communications from the merchant about this Checkout Session.
    public var promotions: String?
    /// If `accepted`, the customer in this Checkout Session has agreed to the merchant’s terms of service.
    public var termsOfService: SessionConsentTermsOfService?
    
    public init(promotions: String? = nil,
                termsOfService: SessionConsentTermsOfService? = nil) {
        self.promotions = promotions
        self.termsOfService = termsOfService
    }
}

public enum SessionConsentTermsOfService: String, Codable {
    /// The customer has accepted the specified terms of service agreement.
    case accepted
}

public struct SessionConsentCollection: Codable {
    /// If set to `auto`, enables the collection of customer consent for promotional communications. The Checkout Session will determine whether to display an option to opt into promotional communication from the merchant depending on the customer’s locale. Only available to US merchants.
    public var promotions: String?
    /// If set to `required`, it requires customers to accept the terms of service before being able to pay.
    public var termsOfService: String?
    
    public init(promotions: String? = nil, termsOfService: String? = nil) {
        self.promotions = promotions
        self.termsOfService = termsOfService
    }
}

public struct SessionCurrencyConversion: Codable {
    /// Total of all items in source currency before discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total of all items in source currency after discounts and taxes are applied.
    public var amountTotal: Int?
    /// Exchange rate used to convert source currency amounts to customer currency amounts
    public var fxRate: String?
    /// Creation currency of the CheckoutSession before localization
    public var sourceCurrency: Currency?
    
    public init(amountSubtotal: Int? = nil,
                amountTotal: Int? = nil,
                fxRate: String? = nil,
                sourceCurrency: Currency? = nil) {
        self.amountSubtotal = amountSubtotal
        self.amountTotal = amountTotal
        self.fxRate = fxRate
        self.sourceCurrency = sourceCurrency
    }
}

public struct SessionCustomerDetails: Codable {
    /// The customer’s address after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
    public var address: Address?
    /// The customer’s email at time of checkout.
    public var email: String?
    /// The customer’s name after a completed Checkout Session. Note: This property is populated only for sessions on or after March 30, 2022.
    public var name: String?
    /// The customer’s phone number at the time of checkout
    public var phone: String?
    /// The customer’s tax exempt status at time of checkout.
    public var taxExempt: String?
    /// The customer’s tax IDs at time of checkout.
    public var taxIds: [SessionCustomerDetailsTaxId]?
    
    public init(address: Address? = nil,
                email: String? = nil,
                name: String? = nil,
                phone: String? = nil,
                taxExempt: String? = nil,
                taxIds: [SessionCustomerDetailsTaxId]? = nil) {
        self.address = address
        self.email = email
        self.name = name
        self.phone = phone
        self.taxExempt = taxExempt
        self.taxIds = taxIds
    }
}

public struct SessionCustomerDetailsTaxId: Codable {
    /// The type of the tax ID.
    public var type: StripeTaxIDType
    /// The value of the tax ID.
    public var value: String?
    
    public init(type: StripeTaxIDType, value: String? = nil) {
        self.type = type
        self.value = value
    }
}

public struct SessionLineItem: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Total discount amount applied. If no discounts were applied, defaults to 0.
    public var amountDiscount: Int?
    /// Total before any discounts or taxes is applied.
    public var amountSubtotal: Int?
    /// Total tax amount applied. If no tax was applied, defaults to 0.
    public var amountTax: Int?
    /// Total after discounts and taxes.
    public var amountTotal: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
    public var description: String?
    /// The discounts applied to the line item. This field is not included by default. To include it in the response, expand the `discounts` field.
    public var discounts: [SessionLineItemDiscount]?
    /// The price used to generate the line item.
    public var price: Price?
    /// The quantity of products being purchased.
    public var quantity: Int?
    /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [SessionLineItemTax]?
    
    public init(id: String,
                object: String,
                amountDiscount: Int? = nil,
                amountSubtotal: Int? = nil,
                amountTax: Int? = nil,
                amountTotal: Int? = nil,
                currency: Currency? = nil,
                description: String? = nil,
                discounts: [SessionLineItemDiscount]? = nil,
                price: Price? = nil,
                quantity: Int? = nil,
                taxes: [SessionLineItemTax]? = nil) {
        self.id = id
        self.object = object
        self.amountDiscount = amountDiscount
        self.amountSubtotal = amountSubtotal
        self.amountTax = amountTax
        self.amountTotal = amountTotal
        self.currency = currency
        self.description = description
        self.discounts = discounts
        self.price = price
        self.quantity = quantity
        self.taxes = taxes
    }
}

public struct SessionLineItemDiscount: Codable {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: Discount?
    
    public init(amount: Int? = nil, discount: Discount? = nil) {
        self.amount = amount
        self.discount = discount
    }
}

public struct SessionLineItemTax: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: TaxRate?
    
    public init(amount: Int? = nil, rate: TaxRate? = nil) {
        self.amount = amount
        self.rate = rate
    }
}

public struct SessionLineItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [SessionLineItem]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [SessionLineItem]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public enum SessionLocale: String, Codable {
    case auto = "auto"
    case bg = "bg"
    case cs = "cs"
    case da = "da"
    case de = "de"
    case el = "el"
    case en = "en"
    case enGB = "en-GB"
    case es = "es"
    case es419 = "es-419"
    case et = "et"
    case fi = "fi"
    case fil = "fil"
    case fr = "fr"
    case frCA = "fr-CA"
    case hr = "hr"
    case hu = "hu"
    case id = "id"
    case it = "it"
    case ja = "ja"
    case ko = "ko"
    case lt = "lt"
    case lv = "lv"
    case ms = "ms"
    case mt = "mt"
    case nb = "nb"
    case nl = "nl"
    case pl = "pl"
    case pt = "pt"
    case ptBR = "pt-BR"
    case ro = "ro"
    case ru = "ru"
    case sk = "sk"
    case sl = "sl"
    case sv = "sv"
    case th = "th"
    case tr = "tr"
    case vi = "vi"
    case zh = "zh"
    case zhHK = "zh-HK"
    case zhTW = "zh-TW"
}

public enum SessionMode: String, Codable {
    /// Accept one-time payments for cards, iDEAL, and more.
    case payment
    /// Save payment details to charge your customers later.
    case setup
    /// Use Stripe Billing to set up fixed-price subscriptions.
    case subscription
}

public enum SessionPaymentMethodCollection: String, Codable {
    /// The Checkout Session will always collect a PaymentMethod.
    case always
    /// The Checkout Session will only collect a PaymentMethod if there is an amount due.
    case ifRequired = "if_required"
}

public struct SessionPhoneNumberCollection: Codable {
    /// Indicates whether phone number collection is enabled for the session
    public var enabled: Bool
    
    public init(enabled: Bool) {
        self.enabled = enabled
    }
}

public struct SessionShippingAddressCollection: Codable {
    /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
    public var allowedCountries: [String]?
    
    public init(allowedCountries: [String]? = nil) {
        self.allowedCountries = allowedCountries
    }
}

public struct SessionShippingCost: Codable {
    /// Total shipping cost before any discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
    public var amountTax: Int?
    /// Total shipping cost after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The ID of the ShippingRate for this order.
    @Expandable<ShippingRate> public var shippingRate: String?
    /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [SessionShippingCostTaxes]?
    
    public init(amountSubtotal: Int? = nil,
                amountTax: Int? = nil,
                amountTotal: Int? = nil,
                shippingRate: String? = nil,
                taxes: [SessionShippingCostTaxes]? = nil) {
        self.amountSubtotal = amountSubtotal
        self.amountTax = amountTax
        self.amountTotal = amountTotal
        self._shippingRate = Expandable(id: shippingRate)
        self.taxes = taxes
    }
}

public struct SessionShippingCostTaxes: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: TaxRate?
    
    public init(amount: Int? = nil, rate: TaxRate? = nil) {
        self.amount = amount
        self.rate = rate
    }
}

public struct SessionShippingOption: Codable {
    /// A non-negative integer in cents representing how much to charge.
    public var shippingAmount: Int?
    /// The shipping rate.
    @Expandable<ShippingRate> public var shippingRate: String?
    
    public init(shippingAmount: Int? = nil, shippingRate: String? = nil) {
        self.shippingAmount = shippingAmount
        self._shippingRate = Expandable(id: shippingRate)
    }
}

public enum SessionSubmitType: String, Codable {
    case auto
    case book
    case donate
    case pay
}

public enum SessionStatus: String, Codable {
    /// The checkout session is still in progress. Payment processing has not started
    case open
    /// The checkout session is complete. Payment processing may still be in progress
    case complete
    /// The checkout session has expired. No further processing will occur
    case expired
}

public struct SessionTotalDetails: Codable {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item shipping amounts.
    public var amountShipping: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals. This field is not included by default. To include it in the response, expand the breakdown field.
    public var breakdown: SessionTotalDetailsBreakdown?
    
    public init(amountDiscount: Int? = nil,
                amountShipping: Int? = nil,
                amountTax: Int? = nil,
                breakdown: SessionTotalDetailsBreakdown? = nil) {
        self.amountDiscount = amountDiscount
        self.amountShipping = amountShipping
        self.amountTax = amountTax
        self.breakdown = breakdown
    }
}

public struct SessionTotalDetailsBreakdown: Codable {
    /// The aggregated discounts.
    public var discounts: [SessionTotalDetailsBreakdownDiscount]?
    /// The aggregated tax amounts by rate.
    public var taxes: [SessionTotalDetailsBreakdownTax]?
}

public struct SessionTotalDetailsBreakdownDiscount: Codable {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: Discount?
    
    public init(amount: Int? = nil, discount: Discount? = nil) {
        self.amount = amount
        self.discount = discount
    }
}

public struct SessionTotalDetailsBreakdownTax: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: TaxRate?
    
    public init(amount: Int? = nil, rate: TaxRate? = nil) {
        self.amount = amount
        self.rate = rate
    }
}

public enum SessionPaymentStatus: String, Codable {
    /// The payment funds are available in your account.
    case paid
    /// The payment funds are not yet available in your account.
    case unpaid
    /// The Checkout Session is in setup mode and doesn’t require a payment at this time.
    case noPaymentRequired = "no_payment_required"
}

public struct SessionTaxIdCollection: Codable {
    /// Indicates whether tax ID collection is enabled for the session
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct SessionList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Session]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Session]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
