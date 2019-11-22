//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

import Foundation

/// The [Customer Object](https://stripe.com/docs/api/customers/object)
public struct StripeCustomer: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The customers address.
    public var addrress: StripeAddress?
    /// Current balance, if any, being stored on the customer’s account. If negative, the customer has credit to apply to the next invoice. If positive, the customer has an amount owed that will be added to the next invoice. The balance does not refer to any unpaid invoices; it solely takes into account amounts that have yet to be successfully applied to any invoice. This balance is only taken into account as invoices are finalized. Note that the balance does not include unpaid invoices.
    public var balance: Int?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO code for the currency the customer can be charged in for recurring billing purposes.
    public var currency: StripeCurrency?
    /// ID of the default payment source for the customer.
    public var defaultSource: String?
    /// When the customer’s latest invoice is billed by charging automatically, delinquent is true if the invoice’s latest charge is failed. When the customer’s latest invoice is billed by sending an invoice, delinquent is true if the invoice is not paid by its due date.
    public var delinquent: Bool?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Describes the current discount active on the customer, if there is one.
    public var discount: StripeDiscount?
    /// The customer’s email address.
    public var email: String?
    /// The prefix for the customer used to generate unique invoice numbers.
    public var invoicePrefix: String?
    /// The customer’s default invoice settings.
    public var invoiceSettings: StripeCustomerInvoiceSettings?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The customers full name or business name.
    public var name: String?
    /// The customers phone number.
    public var phone: String?
    /// The customer’s preferred locales (languages), ordered by preference
    public var preferredLocals: [String]?
    /// Mailing and shipping address for the customer. Appears on invoices emailed to this customer.
    public var shipping: StripeShippingLabel?
    /// The customer’s payment sources, if any.
    public var sources: StripeSourcesList?
    /// The customer’s current subscriptions, if any.
    public var subscriptions: StripeSubscriptionList?
    /// Describes the customer’s tax exemption status. One of `none`, `exempt`, or `reverse`. When set to `reverse`, invoice and receipt PDFs include the text `“Reverse charge”`.
    public var taxExempt: StripeCustomerTaxExempt?
    /// The customers tax IDs
    public var taxIds: StripeTaxIDList?
}

public struct StripeCustomerInvoiceSettings: StripeModel {
    /// Default footer to be displayed on invoices for this customer.
    public var footer: String?
    /// Default custom fields to be displayed on invoices for this customer.
    public var customFields: [StripeCustomerInvoiceSettingsCustomFields]?
}

public struct StripeCustomerInvoiceSettingsCustomFields: StripeModel {
    /// The name of the custom field.
    public var name: String?
    /// The value of the custom field.
    public var value: String?
}

public enum StripeCustomerTaxExempt: String, StripeModel {
    case none
    case exempt
    case reverse
}

public struct StripeCustomerList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeCustomer]?
}
