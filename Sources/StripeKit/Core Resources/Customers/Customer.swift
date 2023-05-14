//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

import Foundation

/// The [Customer Object](https://stripe.com/docs/api/customers/object)
public struct Customer: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The customers address.
    public var address: Address?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// The customer’s email address.
    public var email: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The customers full name or business name.
    public var name: String?
    /// The customers phone number.
    public var phone: String?
    /// Mailing and shipping address for the customer. Appears on invoices emailed to this customer.
    public var shipping: ShippingLabel?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Current balance, if any, being stored on the customer’s account. If negative, the customer has credit to apply to the next invoice. If positive, the customer has an amount owed that will be added to the next invoice. The balance does not refer to any unpaid invoices; it solely takes into account amounts that have yet to be successfully applied to any invoice. This balance is only taken into account as invoices are finalized. Note that the balance does not include unpaid invoices.
    public var balance: Int?
    /// The current funds being held by Stripe on behalf of the customer. These funds can be applied towards payment intents with source `“cash_balance”`. The settings[reconciliation_mode] field describes whether these funds are applied to such payment intents manually or automatically. This field is not included by default. To include it in the response, expand the `cash_balance field`.
    public var cashBalance: CustomerCashBalance?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO code for the currency the customer can be charged in for recurring billing purposes.
    public var currency: Currency?
    /// ID of the default payment source for the customer.
    ///
    /// If you are using payment methods created via the PaymentMethods API, see the `invoice_settings.default_payment_method` field instead.
    @DynamicExpandable<BankAccount, Card> public var defaultSource: String?
    /// When the customer’s latest invoice is billed by charging automatically, delinquent is true if the invoice’s latest charge is failed. When the customer’s latest invoice is billed by sending an invoice, delinquent is true if the invoice is not paid by its due date.
    public var delinquent: Bool?
    /// Describes the current discount active on the customer, if there is one.
    public var discount: Discount?
    /// The current multi-currency balances, if any, being stored on the customer. If positive in a currency, the customer has a credit to apply to their next invoice denominated in that currency. If negative, the customer has an amount owed that will be added to their next invoice denominated in that currency. These balances do not refer to any unpaid invoices. They solely track amounts that have yet to be successfully applied to any invoice. A balance in a particular currency is only applied to any invoice as an invoice in that currency is finalized. This field is not included by default. To include it in the response, expand the `invoice_credit_balance` field.
    public var invoiceCreditBalance: [String: Int]?
    /// The prefix for the customer used to generate unique invoice numbers.
    public var invoicePrefix: String?
    /// The customer’s default invoice settings.
    public var invoiceSettings: CustomerInvoiceSettings?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The suffix of the customer’s next invoice number, e.g., 0001.
    public var nextInvoiceSequence: Int?
    /// The customer’s preferred locales (languages), ordered by preference
    public var preferredLocals: [String]?
    /// The customer’s payment sources, if any.
    public var sources: StripeSourcesList?
    /// The customer’s current subscriptions, if any.
    public var subscriptions: SubscriptionList?
    /// Describes the customer’s tax exemption status. One of `none`, `exempt`, or `reverse`. When set to `reverse`, invoice and receipt PDFs include the text `“Reverse charge”`.
    public var taxExempt: CustomerTaxExempt?
    /// The customers tax IDs
    public var taxIds: TaxIDList?
    /// ID of the test clock this customer belongs to.
    @Expandable<TestClock> public var testClock: String?
    
    public init(id: String,
                address: Address? = nil,
                description: String? = nil,
                email: String? = nil,
                metadata: [String : String]? = nil,
                name: String? = nil,
                phone: String? = nil,
                shipping: ShippingLabel? = nil,
                object: String,
                balance: Int? = nil,
                cashBalance: CustomerCashBalance? = nil,
                created: Date,
                currency: Currency? = nil,
                defaultSource: String? = nil,
                delinquent: Bool? = nil,
                discount: Discount? = nil,
                invoiceCreditBalance: [String : Int]? = nil,
                invoicePrefix: String? = nil,
                invoiceSettings: CustomerInvoiceSettings? = nil,
                livemode: Bool? = nil,
                nextInvoiceSequence: Int? = nil,
                preferredLocals: [String]? = nil,
                sources: StripeSourcesList? = nil,
                subscriptions: SubscriptionList? = nil,
                taxExempt: CustomerTaxExempt? = nil,
                taxIds: TaxIDList? = nil,
                testClock: String? = nil) {
        self.id = id
        self.address = address
        self.description = description
        self.email = email
        self.metadata = metadata
        self.name = name
        self.phone = phone
        self.shipping = shipping
        self.object = object
        self.balance = balance
        self.cashBalance = cashBalance
        self.created = created
        self.currency = currency
        self._defaultSource = DynamicExpandable(id: defaultSource)
        self.delinquent = delinquent
        self.discount = discount
        self.invoiceCreditBalance = invoiceCreditBalance
        self.invoicePrefix = invoicePrefix
        self.invoiceSettings = invoiceSettings
        self.livemode = livemode
        self.nextInvoiceSequence = nextInvoiceSequence
        self.preferredLocals = preferredLocals
        self.sources = sources
        self.subscriptions = subscriptions
        self.taxExempt = taxExempt
        self.taxIds = taxIds
        self._testClock = Expandable(id: testClock)
    }
}

public struct CustomerCashBalance: Codable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A hash of all cash balances available to this customer. You cannot delete a customer with any cash balances, even if the balance is 0. Amounts are represented in the smallest currency unit.
    public var available: [String: Int]?
    /// The ID of the customer whose cash balance this object represents.
    public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// A hash of settings for this cash balance.
    public var settings: CustomerCashBalanceSettings?
    
    public init(object: String,
                available: [String : Int]? = nil,
                customer: String? = nil,
                livemode: Bool,
                settings: CustomerCashBalanceSettings? = nil) {
        self.object = object
        self.available = available
        self.customer = customer
        self.livemode = livemode
        self.settings = settings
    }
}

public struct CustomerCashBalanceSettings: Codable {
    /// The configuration for how funds that land in the customer cash balance are reconciled
    public var reconciliationMode: String?
    /// A flag to indicate if reconciliation mode returned is the user’s default or is specific to this customer cash balance
    public var usingMerchantDefault: Bool?
    
    public init(reconciliationMode: String? = nil, usingMerchantDefault: Bool? = nil) {
        self.reconciliationMode = reconciliationMode
        self.usingMerchantDefault = usingMerchantDefault
    }
}

public struct CustomerInvoiceSettings: Codable {
    /// Default custom fields to be displayed on invoices for this customer.
    public var customFields: [CustomerInvoiceSettingsCustomFields]?
    /// ID of the default payment method used for subscriptions and invoices for the customer.
    @Expandable<PaymentMethod> public var defaultPaymentMethod: String?
    /// Default footer to be displayed on invoices for this customer.
    public var footer: String?
    /// Default options for invoice PDF rendering for this customer.
    public var renderingOptions: CustomerInvoiceSettingsRenderingOptions?
    
    public init(customFields: [CustomerInvoiceSettingsCustomFields]? = nil,
                defaultPaymentMethod: String? = nil,
                footer: String? = nil,
                renderingOptions: CustomerInvoiceSettingsRenderingOptions? = nil) {
        self.customFields = customFields
        self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
        self.footer = footer
        self.renderingOptions = renderingOptions
    }
}

public struct CustomerInvoiceSettingsCustomFields: Codable {
    /// The name of the custom field.
    public var name: String?
    /// The value of the custom field.
    public var value: String?
    
    public init(name: String? = nil, value: String? = nil) {
        self.name = name
        self.value = value
    }
}

public struct CustomerInvoiceSettingsRenderingOptions: Codable {
    /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
    public var amountTaxDisplay: String?
    
    public init(amountTaxDisplay: String? = nil) {
        self.amountTaxDisplay = amountTaxDisplay
    }
}

public enum CustomerTaxExempt: String, Codable {
    case none
    case exempt
    case reverse
}

public struct CustomerList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Customer]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Customer]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public struct CustomerSearchResult: Codable {
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
