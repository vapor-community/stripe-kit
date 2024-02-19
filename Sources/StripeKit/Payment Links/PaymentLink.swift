//
//  PaymentLink.swift
//  
//
//  Created by Andrew Edwards on 5/7/23.
//

import Foundation

public struct PaymentLink: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Whether the payment link’s `url` is active. If `false`, customers visiting the URL will be shown a page saying that the link has been deactivated.
    public var active: Bool?
    /// The line items representing what is being sold. This field is not included by default. To include it in the response, expand the `line_items` field.
    public var lineItems: PaymentLinkLineItemList?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The public URL that can be shared with customers.
    public var url: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Behavior after the purchase is complete.
    public var afterCompletion: PaymentLinkAfterCompletion?
    /// Whether user redeemable promotion codes are enabled.
    public var allowPromotionCodes: Bool?
    /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account.
    public var applicationFeeAmount: Int?
    /// This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account.
    public var applicationFeePercent: Decimal?
    /// Configuration details for automatic tax collection.
    public var automaticTax: PaymentLinkAutomaticTax?
    /// Configuration for collecting the customer’s billing address.
    public var billingAddressCollection: PaymentLinkBillingAddressCollection?
    /// When set, provides configuration to gather active consent from customers.
    public var consentCollection: PaymentLinkConsentCollection?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Collect additional information from your customer using custom fields. Up to 2 fields are supported.
    public var customFields: [PaymentLinkCustomField]?
    /// Display additional text for your customers using custom text.
    public var customText: PaymentLinkCustomText?
    /// Configuration for Customer creation during checkout.
    public var customerCreation: PaymentLinkCustomerCreation?
    /// Configuration for creating invoice for payment mode payment links.
    public var invoiceCreation: PaymentLinkInvoiceCreation?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The account on behalf of which to charge. See the Connect documentation for details.
    @Expandable<ConnectAccount> public var onBehalfOf: String?
    /// Indicates the parameters to be passed to PaymentIntent creation during checkout.
    public var paymentIntentData: PaymentLinkPaymentIntentData?
    /// Configuration for collecting a payment method during checkout.
    public var paymentMethodCollection: PaymentLinkPaymentMethodCollection?
    /// The list of payment method types that customers can use. When `null`, Stripe will dynamically show relevant payment methods you’ve enabled in your payment method settings.
    public var paymentMethodTypes: [String]?
    /// Controls phone number collection settings during checkout.
    public var phoneNumberCollection: PaymentLinkPhoneNumberCollection?
    /// Configuration for collecting the customer’s shipping address.
    public var shippingAddressCollection: PaymentLinkShippingAddressCollection?
    /// The shipping rate options applied to the session.
    public var shippingOptions: [PaymentLinkShippingOption]?
    /// Indicates the type of transaction being performed which customizes relevant text on the page, such as the submit button.
    public var submitType: PaymentLinkSubmitType?
    /// When creating a subscription, the specified configuration data will be used. There must be at least one line item with a recurring price to use `subscription_data`.
    public var subscriptionData: PaymentLinkSubscriptionData?
    /// Details on the state of tax ID collection for the payment link.
    public var taxIdCollection: PaymentLinkTaxIdCollection?
    /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to.
    public var transferData: PaymentLinkTransferData?
    
    public init(id: String,
                active: Bool? = nil,
                lineItems: PaymentLinkLineItemList? = nil,
                metadata: [String : String]? = nil,
                url: String? = nil,
                object: String,
                afterCompletion: PaymentLinkAfterCompletion? = nil,
                allowPromotionCodes: Bool? = nil,
                applicationFeeAmount: Int? = nil,
                applicationFeePercent: Decimal? = nil,
                automaticTax: PaymentLinkAutomaticTax? = nil,
                billingAddressCollection: PaymentLinkBillingAddressCollection? = nil,
                consentCollection: PaymentLinkConsentCollection? = nil,
                currency: Currency? = nil,
                customFields: [PaymentLinkCustomField]? = nil,
                customText: PaymentLinkCustomText? = nil,
                customerCreation: PaymentLinkCustomerCreation? = nil,
                invoiceCreation: PaymentLinkInvoiceCreation? = nil,
                livemode: Bool? = nil,
                onBehalfOf: String? = nil,
                paymentIntentData: PaymentLinkPaymentIntentData? = nil,
                paymentMethodCollection: PaymentLinkPaymentMethodCollection? = nil,
                paymentMethodTypes: [String]? = nil,
                phoneNumberCollection: PaymentLinkPhoneNumberCollection? = nil,
                shippingAddressCollection: PaymentLinkShippingAddressCollection? = nil,
                shippingOptions: [PaymentLinkShippingOption]? = nil,
                submitType: PaymentLinkSubmitType? = nil,
                subscriptionData: PaymentLinkSubscriptionData? = nil,
                taxIdCollection: PaymentLinkTaxIdCollection? = nil,
                transferData: PaymentLinkTransferData? = nil) {
        self.id = id
        self.active = active
        self.lineItems = lineItems
        self.metadata = metadata
        self.url = url
        self.object = object
        self.afterCompletion = afterCompletion
        self.allowPromotionCodes = allowPromotionCodes
        self.applicationFeeAmount = applicationFeeAmount
        self.applicationFeePercent = applicationFeePercent
        self.automaticTax = automaticTax
        self.billingAddressCollection = billingAddressCollection
        self.consentCollection = consentCollection
        self.currency = currency
        self.customFields = customFields
        self.customText = customText
        self.customerCreation = customerCreation
        self.invoiceCreation = invoiceCreation
        self.livemode = livemode
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self.paymentIntentData = paymentIntentData
        self.paymentMethodCollection = paymentMethodCollection
        self.paymentMethodTypes = paymentMethodTypes
        self.phoneNumberCollection = phoneNumberCollection
        self.shippingAddressCollection = shippingAddressCollection
        self.shippingOptions = shippingOptions
        self.submitType = submitType
        self.subscriptionData = subscriptionData
        self.taxIdCollection = taxIdCollection
        self.transferData = transferData
    }
}

public struct PaymentLinkLineItem: Codable {
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
    public var discounts: [PaymentLinkLineItemDiscount]?
    /// The price used to generate the line item.
    public var price: Price?
    /// The quantity of products being purchased.
    public var quantity: Int?
    /// The taxes applied to the line item. This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [PaymentLinkLineItemTax]?
    
    public init(id: String,
                object: String,
                amountDiscount: Int? = nil,
                amountSubtotal: Int? = nil,
                amountTax: Int? = nil,
                amountTotal: Int? = nil,
                currency: Currency? = nil,
                description: String? = nil,
                discounts: [PaymentLinkLineItemDiscount]? = nil,
                price: Price? = nil,
                quantity: Int? = nil,
                taxes: [PaymentLinkLineItemTax]? = nil) {
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

public struct PaymentLinkLineItemDiscount: Codable {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: Discount?
    
    public init(amount: Int? = nil, discount: Discount? = nil) {
        self.amount = amount
        self.discount = discount
    }
}

public struct PaymentLinkLineItemTax: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: TaxRate?
    
    public init(amount: Int? = nil, rate: TaxRate? = nil) {
        self.amount = amount
        self.rate = rate
    }
}

public struct PaymentLinkLineItemList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value `list`.
    public var object: String
    /// Details about each object.
    public var data: [PaymentLinkLineItem]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    
    public init(object: String,
                data: [PaymentLinkLineItem]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

public struct PaymentLinkAfterCompletion: Codable {
    /// Configuration when `type=hosted_confirmation`
    public var hostedConfirmation: PaymentLinkAfterCompletionHostedConfirmation?
    /// Configuration when `type=redirect`
    public var redirect: PaymentLinkAfterCompletionRedirect?
    /// The specified behavior after the purchase is complete.
    public var type: PaymentLinkAfterCompletionType?
    
    public init(hostedConfirmation: PaymentLinkAfterCompletionHostedConfirmation? = nil,
                redirect: PaymentLinkAfterCompletionRedirect? = nil,
                type: PaymentLinkAfterCompletionType? = nil) {
        self.hostedConfirmation = hostedConfirmation
        self.redirect = redirect
        self.type = type
    }
}

public struct PaymentLinkAfterCompletionHostedConfirmation: Codable {
    /// The custom message that is displayed to the customer after the purchase is complete.
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}

public struct PaymentLinkAfterCompletionRedirect: Codable {
    /// The URL the customer will be redirected to after the purchase is complete
    public var url: String?
    
    public init(url: String? = nil) {
        self.url = url
    }
}

public enum PaymentLinkAfterCompletionType: String, Codable {
    /// Redirects the customer to the specified url after the purchase is complete.
    case redirect
    /// Displays a message on the hosted surface after the purchase is complete.
    case hostedConfirmation = "hosted_confirmation"
}

public struct PaymentLinkAutomaticTax: Codable {
    /// If `true`, tax will be calculated automatically using the customer’s location.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public enum PaymentLinkBillingAddressCollection: String, Codable {
    /// Checkout will only collect the billing address when necessary. When using `automatic_tax`, Checkout will collect the minimum number of fields required for tax calculation
    case auto
    /// Checkout will always collect the customer’s billing address.
    case `required`
}

public struct PaymentLinkConsentCollection: Codable {
    /// If set to `auto`, enables the collection of customer consent for promotional communications.
    public var promotions: String?
    /// If set to `required`, it requires cutomers to accept the terms of service before being able to pay. If set to none, customers won’t be shown a checkbox to accept the terms of service.
    public var termsOfService: String?
    
    public init(promotions: String? = nil, termsOfService: String? = nil) {
        self.promotions = promotions
        self.termsOfService = termsOfService
    }
}

public struct PaymentLinkCustomField: Codable {
    /// Configuration for `type=dropdown` fields.
    public var dropdown: PaymentLinkCustomFieldDropdown?
    /// String of your choice that your integration can use to reconcile this field. Must be unique to this field, alphanumeric, and up to 200 characters.
    public var key: String?
    /// The label for the field, displayed to the customer.
    public var label: PaymentLinkCustomFieldLabel?
    /// Configuration for `type=numeric` fields.
    public var numeric: PaymentLinkCustomFieldNumeric?
    /// Whether the customer is required to complete the field before completing the Checkout Session. Defaults to `false`.
    public var optional: Bool?
    /// Configuration for `type=text` fields.
    public var text: PaymentLinkCustomFieldText?
    /// The type of the field.
    public var type: PaymentLinkCustomFieldType?
    
    public init(dropdown: PaymentLinkCustomFieldDropdown? = nil,
                key: String? = nil,
                label: PaymentLinkCustomFieldLabel? = nil,
                numeric: PaymentLinkCustomFieldNumeric? = nil,
                optional: Bool? = nil,
                text: PaymentLinkCustomFieldText? = nil,
                type: PaymentLinkCustomFieldType? = nil) {
        self.dropdown = dropdown
        self.key = key
        self.label = label
        self.numeric = numeric
        self.optional = optional
        self.text = text
        self.type = type
    }
}

public struct PaymentLinkCustomFieldDropdown: Codable {
    /// The options available for the customer to select. Up to 200 options allowed
    public var options: [PaymentLinkCustomFieldDropdownOption]?
    /// The option selected by the customer. This will be the `value` for the option.
    public var value: String?
    
    public init(options: [PaymentLinkCustomFieldDropdownOption]? = nil,
                value: String? = nil) {
        self.options = options
        self.value = value
    }
}

public struct PaymentLinkCustomFieldDropdownOption: Codable {
    /// The label for the option, displayed to the customer. Up to 100 characters.
    public var label: String?
    /// The value for this option, not displayed to the customer, used by your integration to reconcile the option selected by the customer. Must be unique to this option, alphanumeric, and up to 100 characters.
    public var value: String?
    
    public init(label: String? = nil, value: String? = nil) {
        self.label = label
        self.value = value
    }
}

public struct PaymentLinkCustomFieldLabel: Codable {
    /// Custom text for the label, displayed to the customer. Up to 50 characters.
    public var custom: String?
    ///The type of the label.
    public var type: PaymentLinkCustomFieldLabelType?
    
    public init(custom: String? = nil, type: PaymentLinkCustomFieldLabelType? = nil) {
        self.custom = custom
        self.type = type
    }
}

public enum PaymentLinkCustomFieldLabelType: String, Codable {
    /// Set a custom label for the field.
    case custom
}

public struct PaymentLinkCustomFieldNumeric: Codable {
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

public struct PaymentLinkCustomFieldText: Codable {
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

public enum PaymentLinkCustomFieldType: String, Codable {
    /// Collect a string field from your customer.
    case text
    /// Collect a numbers-only field from your customer.
    case numeric
    /// Provide a list of options for your customer to select.
    case dropdown
}

public struct PaymentLinkCustomText: Codable {
    /// Custom text that should be displayed alongside shipping address collection.
    public var shippingAddress: PaymentLinkCustomTextShippingAddress?
    /// Custom text that should be displayed alongside the payment confirmation button.
    public var submit: PaymentLinkCustomTextSubmit?
    
    public init(shippingAddress: PaymentLinkCustomTextShippingAddress? = nil,
                submit: PaymentLinkCustomTextSubmit? = nil) {
        self.shippingAddress = shippingAddress
        self.submit = submit
    }
}

public struct PaymentLinkCustomTextShippingAddress: Codable {
    /// Text may be up to 1000 characters in length.
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}

public struct PaymentLinkCustomTextSubmit: Codable {
    /// Text may be up to 1000 characters in length.
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}

public enum PaymentLinkCustomerCreation: String, Codable {
    /// The Checkout Session will only create a Customer if it is required for Session confirmation. Currently, only `subscription` mode Sessions require a Customer.
    case ifRequired = "if_required"
    /// The Checkout Session will always create a Customer when a Session confirmation is attempted.
    case always
}
public struct PaymentLinkInvoiceCreation: Codable {
    /// Indicates whether invoice creation is enabled for the Checkout Session.
    public var enabled: Bool?
    /// Parameters passed when creating invoices for payment-mode Checkout Sessions.
    public var invoiceData: PaymentLinkInvoiceCreationInvoiceData?
    
    public init(enabled: Bool? = nil, invoiceData: PaymentLinkInvoiceCreationInvoiceData? = nil) {
        self.enabled = enabled
        self.invoiceData = invoiceData
    }
}

public struct PaymentLinkInvoiceCreationInvoiceData: Codable {
    /// The account tax IDs associated with the invoice
    @ExpandableCollection<TaxID> public var accountTaxIds: [String]?
    /// Custom fields displayed on the invoice.
    public var customFields: [PaymentLinkInvoiceCreationInvoiceDataCustomFields]?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Footer displayed on the invoice.
    public var footer: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Options for invoice PDF rendering.
    public var renderingOptions: PaymentLinkInvoiceCreationInvoiceDataRenderingOptions?
    
    public init(accountTaxIds: [String]? = nil,
                customFields: [PaymentLinkInvoiceCreationInvoiceDataCustomFields]? = nil,
                description: String? = nil,
                footer: String? = nil,
                metadata: [String : String]? = nil,
                renderingOptions: PaymentLinkInvoiceCreationInvoiceDataRenderingOptions? = nil) {
        self._accountTaxIds = ExpandableCollection(ids: accountTaxIds)
        self.customFields = customFields
        self.description = description
        self.footer = footer
        self.metadata = metadata
        self.renderingOptions = renderingOptions
    }
}

public struct PaymentLinkInvoiceCreationInvoiceDataCustomFields: Codable {
    /// The name of the custom field.
    public var name: String?
    /// The value of the custom field.
    public var value: String?
    
    public init(name: String? = nil, value: String? = nil) {
        self.name = name
        self.value = value
    }
}

public struct PaymentLinkInvoiceCreationInvoiceDataRenderingOptions: Codable {
    /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
    public var amountTaxDisplay: String?
    
    public init(amountTaxDisplay: String? = nil) {
        self.amountTaxDisplay = amountTaxDisplay
    }
}

public struct PaymentLinkPaymentIntentData: Codable {
    /// Indicates when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentLinkPaymentIntentDataCaptureMethod?
    /// Indicates that you intend to make future payments with the payment method collected during checkout.
    public var setupFutureUsage: PaymentLinkPaymentIntentDataSetupFutureUsage?
    
    public init(captureMethod: PaymentLinkPaymentIntentDataCaptureMethod? = nil,
                setupFutureUsage: PaymentLinkPaymentIntentDataSetupFutureUsage? = nil) {
        self.captureMethod = captureMethod
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentLinkPaymentIntentDataCaptureMethod: String, Codable {
    /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
    case automatic
    /// Stripe asynchronously captures funds when the customer authorizes the payment. Recommended over `capture_method=automatic` due to improved latency, but [may require additional integration changes](https://stripe.com/docs/payments/payment-intents/asynchronous-capture-automatic-async) .
    case automaticAsync = "automatic_async"
    /// Place a hold on the funds when the customer authorizes the payment, but [don’t capture the funds until later](https://stripe.com/docs/payments/capture-later). (Not all payment methods support this.)
    case manual
}

public enum PaymentLinkPaymentIntentDataSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
}

public enum PaymentLinkPaymentMethodCollection: String, Codable {
    /// The Checkout Session will always collect a PaymentMethod.
    case always
    /// The Checkout Session will only collect a PaymentMethod if there is an amount due.
    case ifRequired = "if_required"
}

public struct PaymentLinkPhoneNumberCollection: Codable {
    /// Indicates whether phone number collection is enabled for the session
    public var enabled: Bool
    
    public init(enabled: Bool) {
        self.enabled = enabled
    }
}

public struct PaymentLinkShippingAddressCollection: Codable {
    /// An array of two-letter ISO country codes representing which countries Checkout should provide as options for shipping locations. Unsupported country codes: `AS, CX, CC, CU, HM, IR, KP, MH, FM, NF, MP, PW, SD, SY, UM, VI`.
    public var allowedCountries: [String]?
    
    public init(allowedCountries: [String]? = nil) {
        self.allowedCountries = allowedCountries
    }
}

public struct PaymentLinkShippingOption: Codable {
    /// A non-negative integer in cents representing how much to charge.
    public var shippingAmount: Int?
    /// The shipping rate.
    @Expandable<ShippingRate> public var shippingRate: String?
    
    public init(shippingAmount: Int? = nil, shippingRate: String? = nil) {
        self.shippingAmount = shippingAmount
        self._shippingRate = Expandable(id: shippingRate)
    }
}

public enum PaymentLinkSubmitType: String, Codable {
    case auto
    case book
    case donate
    case pay
}

public struct PaymentLinkSubscriptionData: Codable {
    /// The subscription’s description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
    public var description: String?
    /// Integer representing the number of trial period days before the customer is charged for the first time.
    public var trialPeriodDays: Int?
    
    public init(description: String? = nil, trialPeriodDays: Int? = nil) {
        self.description = description
        self.trialPeriodDays = trialPeriodDays
    }
}

public struct PaymentLinkTaxIdCollection: Codable {
    /// Indicates whether tax ID collection is enabled for the session
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct PaymentLinkTransferData: Codable {
    /// The amount in cents that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
    public var amount: Int?
    /// The connected account receiving the transfer.
    @Expandable<ConnectAccount> public var destination: String?
    
    public init(amount: Int? = nil, destination: String? = nil) {
        self.amount = amount
        self._destination = Expandable(id: destination)
    }
}

public struct PaymentLinkList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value `list`.
    public var object: String
    /// Details about each object.
    public var data: [PaymentLink]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    
    public init(object: String,
                data: [PaymentLink]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
