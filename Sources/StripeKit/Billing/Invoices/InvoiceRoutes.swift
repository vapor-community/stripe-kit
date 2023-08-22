//
//  InvoiceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import NIO
import NIOHTTP1
import Foundation

public protocol InvoiceRoutes: StripeAPIRoute {
    /// This endpoint creates a draft invoice for a given customer. The draft invoice created pulls in all pending invoice items on that customer, including prorations.
    ///
    /// - Parameters:
    ///   - autoAdvance: Controls whether Stripe will perform [automatic collection](https://stripe.com/docs/billing/invoices/workflow/#auto_advance) of the invoice. When `false`, the invoice’s state will not automatically advance without an explicit action.
    ///   - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions. Defaults to `charge_automatically`.
    ///   - customer: The ID of the customer to create this invoice for.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. Referenced as ‘memo’ in the Dashboard.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - subscription: The ID of the subscription to invoice, if any. If not set, the created invoice will include all pending invoice items for the customer. If set, the created invoice will only include pending invoice items for that subscription and pending invoice items not associated with any subscription. The subscription’s billing cycle and regular subscription events won’t be affected.
    ///   - accountTaxIds: The account tax IDs associated with the invoice. Only editable when the invoice is a draft.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. For more information, see the application fees
    ///   - automaticTax: Settings for automatic tax lookup for this invoice.
    ///   - currency: The currency to create this invoice in. Defaults to that of customer if not specified.
    ///   - customFields: A list of up to 4 custom fields to be displayed on the invoice.
    ///   - daysUntilDue: The number of days from when the invoice is created until it is due. Valid only for invoices where `billing=send_invoice`.
    ///   - defaultPaymentMethod: ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription’s default payment method, if any, or to the default payment method in the customer’s invoice settings.
    ///   - defaultSource: ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription’s default source, if any, or to the customer’s default source.
    ///   - defaultTaxRates: The tax rates that will apply to any line item that does not have `tax_rates` set.
    ///   - discounts: The coupons to redeem into discounts for the invoice. If not specified, inherits the discount from the invoice’s customer. Pass an empty string to avoid inheriting any discounts.
    ///   - dueDate: The date on which payment for this invoice is due. Valid only for invoices where `billing=send_invoice`.
    ///   - footer: Footer to be displayed on the invoice. This will be unset if you POST an empty value.
    ///   - fromInvoice: Revise an existing invoice. The new invoice will be created in `status=draft`. See the [revision documentation](https://stripe.com/docs/invoicing/invoice-revisions) for more details.
    ///   - onBehalfOf: The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the Invoices with Connect documentation for details.
    ///   - paymentSettings: Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
    ///   - pendingInvoiceItemsBehavior: How to handle pending invoice items on invoice creation. One of include or exclude. include will include any pending invoice items, and will create an empty draft invoice if no pending invoice items exist. exclude will always create an empty invoice draft regardless if there are pending invoice items or not. Defaults to exclude if the parameter is omitted.
    ///   - renderingOptions: Options for invoice PDF rendering.
    ///   - shippingCost: Settings for the cost of shipping for this invoice.
    ///   - shippingDetails: Shipping details for the invoice. The Invoice PDF will use the `shipping_details` value if it is set, otherwise the PDF will render the shipping address from the customer.
    ///   - statementDescriptor: Extra information about a charge for the customer’s credit card statement. It must contain at least one letter. If not specified and this invoice is part of a subscription, the default `statement_descriptor` will be set to the first subscription item’s product’s `statement_descriptor`.
    ///   - transferData: If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer will be found on the invoice’s charge.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the invoice object. Returns an error if the customer ID provided is invalid.
    func create(autoAdvance: Bool?,
                collectionMethod: InvoiceCollectionMethod?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                subscription: String?,
                accountTaxIds: [String]?,
                applicationFeeAmount: Int?,
                automaticTax: [String: Any]?,
                currency: Currency?,
                customFields: [[String: Any]]?,
                daysUntilDue: Int?,
                defaultPaymentMethod: String?,
                defaultSource: String?,
                defaultTaxRates: [[String: Any]]?,
                discounts: [[String: Any]]?,
                dueDate: Date?,
                footer: String?,
                fromInvoice: [String: Any]?,
                onBehalfOf: String?,
                paymentSettings: [String: Any]?,
                pendingInvoiceItemsBehavior: String?,
                renderingOptions: [String: Any]?,
                shippingCost: [String: Any]?,
                shippingDetails: [String: Any]?,
                statementDescriptor: String?,
                transferData: [String: Any]?,
                expand: [String]?) async throws -> Invoice
    
    /// Retrieves the invoice with the given ID.
    ///
    /// - Parameters:
    ///   - invoice: The identifier of the desired invoice.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an invoice object if a valid invoice ID was provided. Returns an error otherwise.
    ///
    /// The invoice object contains a `lines` hash that contains information about the subscriptions and invoice items that have been applied to the invoice, as well as any prorations that Stripe has automatically calculated. Each line on the invoice has an `amount` attribute that represents the amount actually contributed to the invoice’s total. For invoice items and prorations, the amount attribute is the same as for the invoice item or proration respectively. For subscriptions, the amount may be different from the plan’s regular price depending on whether the invoice covers a trial period or the invoice period differs from the plan’s usual interval.
    /// The invoice object has both a `subtotal` and a `total`. The subtotal represents the total before any discounts, while the total is the final amount to be charged to the customer after all coupons have been applied.
    /// The invoice also has a `next_payment_attempt` attribute that tells you the next time (as a Unix timestamp) payment for the invoice will be automatically attempted. For invoices with manual payment collection, that have been closed, or that have reached the maximum number of retries (specified in your [subscriptions settings](https://dashboard.stripe.com/account/billing/automatic)), the `next_payment_attempt` will be null.
    func retrieve(invoice: String, expand: [String]?) async throws -> Invoice
    
    /// Draft invoices are fully editable. Once an invoice is [finalized](https://stripe.com/docs/billing/invoices/workflow#finalized), monetary values, as well as `collection_method`, become uneditable.
    ///
    /// If you would like to stop the Stripe Billing engine from automatically finalizing, reattempting payments on, sending reminders for, or [automatically reconciling](https://stripe.com/docs/billing/invoices/reconciliation) invoices, pass `auto_advance=false`.
    /// - Parameters:
    ///   - invoice: The ID of the invoice to be updated.
    ///   - autoAdvance: Controls whether Stripe will perform automatic collection of the invoice.
    ///   - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions. Defaults to `charge_automatically`.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. Referenced as ‘memo’ in the Dashboard.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - accountTaxIds: The account tax IDs associated with the invoice. Only editable when the invoice is a draft.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. For more information, see the application fees documentation.
    ///   - automaticTax: Settings for automatic tax lookup for this invoice.
    ///   - customFields: A list of up to 4 custom fields to be displayed on the invoice. If a value for `custom_fields` is specified, the list specified will replace the existing custom field list on this invoice.
    ///   - daysUntilDue: The number of days from which the invoice is created until it is due. Only valid for invoices where `billing=send_invoice`. This field can only be updated on draft invoices.
    ///   - defaultPaymentMethod: ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription’s default payment method, if any, or to the default payment method in the customer’s invoice settings.
    ///   - defaultSource: ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription’s default source, if any, or to the customer’s default source.
    ///   - defaultTaxRates: The tax rates that will apply to any line item that does not have `tax_rates` set. Pass an empty string to remove previously-defined tax rates.
    ///   - dueDate: The date on which payment for this invoice is due. Only valid for invoices where `billing=send_invoice`. This field can only be updated on draft invoices.
    ///   - footer: Footer to be displayed on the invoice. This will be unset if you POST an empty value.
    ///   - onBehalfOf: The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the Invoices with Connect documentation for details.
    ///   - paymentSettings: Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
    ///   - renderingOptions: Options for invoice PDF rendering.
    ///   - shippingCost: Settings for the cost of shipping for this invoice.
    ///   - shippingDetails: Shipping details for the invoice. The Invoice PDF will use the `shipping_details` value if it is set, otherwise the PDF will render the shipping address from the customer.
    ///   - statementDescriptor: Extra information about a charge for the customer’s credit card statement. It must contain at least one letter. If not specified and this invoice is part of a subscription, the default `statement_descriptor` will be set to the first subscription item’s product’s `statement_descriptor`.
    ///   - transferData: If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer will be found on the invoice’s charge. This will be unset if you POST an empty value.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the invoice object.
    func update(invoice: String,
                autoAdvance: Bool?,
                collectionMethod: InvoiceCollectionMethod?,
                description: String?,
                metadata: [String: String]?,
                accountTaxIds: [String]?,
                applicationFeeAmount: Int?,
                automaticTax: [String: Any]?,
                customFields: [[String: Any]]?,
                daysUntilDue: Int?,
                defaultPaymentMethod: String?,
                defaultSource: String?,
                defaultTaxRates: [[String: Any]]?,
                discounts: [[String: Any]]?,
                dueDate: Date?,
                footer: String?,
                onBehalfOf: String?,
                paymentSettings: [String: Any]?,
                renderingOptions: [String: Any]?,
                shippingCost: [String: Any]?,
                shippingDetails: [String: Any]?,
                statementDescriptor: String?,
                transferData: [String: Any]?,
                expand: [String]?) async throws -> Invoice
    
    /// Permanently deletes a draft invoice. This cannot be undone. Attempts to delete invoices that are no longer in a draft state will fail; once an invoice has been finalized, it must be [voided](https://stripe.com/docs/api/invoices/delete#void_invoice).
    ///
    /// - Parameter invoice: The identifier of the invoice to be deleted.
    /// - Returns: A successfully deleted invoice. Otherwise, this call returns [an error](https://stripe.com/docs/api/invoices/delete?lang=curl#errors), such as if the invoice has already been deleted.
    func delete(invoice: String) async throws -> DeletedObject
    
    /// Stripe automatically finalizes drafts before sending and attempting payment on invoices. However, if you’d like to finalize a draft invoice manually, you can do so using this method.
    ///
    /// - Parameters:
    ///   - invoice: The invoice to be finalized, it must have `status=draft`.
    ///   - autoAdvance: Controls whether Stripe will perform automatic collection of the invoice. When false, the invoice’s state will not automatically advance without an explicit action.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an invoice object with `status=open`.
    func finalize(invoice: String, autoAdvance: Bool?, expand: [String]?) async throws -> Invoice
    
    /// Stripe automatically creates and then attempts to collect payment on invoices for customers on subscriptions according to your subscriptions settings. However, if you’d like to attempt payment on an invoice out of the normal collection schedule or for some other reason, you can do so.
    ///
    /// - Parameters:
    ///   - invoice: ID of invoice to pay.
    ///   - forgive: In cases where the source used to pay the invoice has insufficient funds, passing `forgive=true` controls whether a charge should be attempted for the full amount available on the source, up to the amount to fully pay the invoice. This effectively forgives the difference between the amount available on the source and the amount due. /n Passing `forgive=false` will fail the charge if the source hasn’t been pre-funded with the right amount. An example for this case is with ACH Credit Transfers and wires: if the amount wired is less than the amount due by a small amount, you might want to forgive the difference.
    ///   - mandate: ID of the mandate to be used for this invoice. It must correspond to the payment method used to pay the invoice, including the `payment_method` param or the invoice’s `default_payment_method` or `default_source`, if set.
    ///   - offSession: Indicates if a customer is on or off-session while an invoice payment is attempted. Defaults to `true` (off-session).
    ///   - paidOutOfBand: Boolean representing whether an invoice is paid outside of Stripe. This will result in no charge being made.
    ///   - paymentMethod: A PaymentMethod to be charged. The PaymentMethod must be the ID of a PaymentMethod belonging to the customer associated with the invoice being paid.
    ///   - source: A payment source to be charged. The source must be the ID of a source belonging to the customer associated with the invoice being paid.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the invoice object.
    func pay(invoice: String,
             forgive: Bool?,
             mandate: String?,
             offSession: Bool?,
             paidOutOfBand: Bool?,
             paymentMethod: String?,
             source: String?,
             expand: [String]?) async throws -> Invoice
    
    /// Stripe will automatically send invoices to customers according to your subscriptions settings. However, if you’d like to manually send an invoice to your customer out of the normal schedule, you can do so. When sending invoices that have already been paid, there will be no reference to the payment in the email.
    ///
    /// Requests made in test-mode result in no emails being sent, despite sending an invoice.sent event.
    ///
    /// - Parameters:
    ///   - invoice: The invoice you would like to send. The billing mode for this invoice must be `send_invoice`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the invoice object.
    func send(invoice: String, expand: [String]?) async throws -> Invoice
    
    /// Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is similar to [deletion](https://stripe.com/docs/api/invoices/void#delete_invoice), however it only applies to finalized invoices and maintains a papertrail where the invoice can still be found.
    ///
    /// - Parameters:
    ///   - invoice: ID of invoice to void. It must be finalized.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the voided invoice object.
    func void(invoice: String, expand: [String]?) async throws -> Invoice
    
    /// Marking an invoice as uncollectible is useful for keeping track of bad debts that can be written off for accounting purposes.
    ///
    /// - Parameters:
    ///   - invoice: The identifier of the invoice to be marked as uncollectible. The invoice must be `open`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the invoice object
    func markUncollectible(invoice: String, expand: [String]?) async throws -> Invoice
    
    /// When retrieving an invoice, you’ll get a lines property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    ///
    /// - Parameters:
    ///   - invoice: The ID of the invoice containing the lines to be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/invoices/invoice_lines).
    /// - Returns: Returns a list of `line_item` objects.
    func retrieveLineItems(invoice: String, filter: [String: Any]?) async throws -> InvoiceLineItemList
    
    ///  At any time, you can preview the upcoming invoice for a customer. This will show you all the charges that are pending, including subscription renewal charges, invoice item charges, etc. It will also show you any discount that is applicable to the customer. /n Note that when you are viewing an upcoming invoice, you are simply viewing a preview – the invoice has not yet been created. As such, the upcoming invoice will not show up in invoice listing calls, and you cannot use the API to pay or edit the invoice. If you want to change the amount that your customer will be billed, you can add, remove, or update pending invoice items, or update the customer’s discount. /n You can preview the effects of updating a subscription, including a preview of what proration will take place. To ensure that the actual proration is calculated exactly the same as the previewed proration, you should pass a `proration_date` parameter when doing the actual subscription update. The value passed in should be the same as the `subscription_proration_date` returned on the upcoming invoice resource. The recommended way to get only the prorations being previewed is to consider only proration line items where `period[start]` is equal to the `subscription_proration_date` on the upcoming invoice resource.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/invoices/upcoming).
    /// - Returns: Returns an invoice if valid customer information is provided. Returns an error otherwise.
    func retrieveUpcomingInvoice(filter: [String: Any]?) async throws -> Invoice
    
    /// When retrieving an upcoming invoice, you’ll get a lines property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/invoices/upcoming_invoice_lines).
    /// - Returns: Returns a list of `line_item` objects.
    func retrieveUpcomingLineItems(filter: [String: Any]?) async throws -> InvoiceLineItemList
    
    /// You can list all invoices, or list the invoices for a specific customer. The invoices are returned sorted by creation date, with the most recently created invoices appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/invoices/list).
    /// - Returns: A dictionary with a data property that contains an array invoice attachments.
    func listAll(filter: [String: Any]?) async throws -> InvoiceList
    
    
    /// Search for invoices you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for invoices.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` invoices. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?) async throws -> InvoiceSearchResult
}

public struct StripeInvoiceRoutes: InvoiceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let invoices = APIBase + APIVersion + "invoices"
    private let search = APIBase + APIVersion + "invoices/search"
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(autoAdvance: Bool? = nil,
                       collectionMethod: InvoiceCollectionMethod? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       subscription: String? = nil,
                       accountTaxIds: [String]? = nil,
                       applicationFeeAmount: Int? = nil,
                       automaticTax: [String: Any]? = nil,
                       currency: Currency? = nil,
                       customFields: [[String: Any]]? = nil,
                       daysUntilDue: Int? = nil,
                       defaultPaymentMethod: String? = nil,
                       defaultSource: String? = nil,
                       defaultTaxRates: [[String: Any]]? = nil,
                       discounts: [[String: Any]]? = nil,
                       dueDate: Date? = nil,
                       footer: String? = nil,
                       fromInvoice: [String: Any]? = nil,
                       onBehalfOf: String? = nil,
                       paymentSettings: [String: Any]? = nil,
                       pendingInvoiceItemsBehavior: String? = nil,
                       renderingOptions: [String: Any]? = nil,
                       shippingCost: [String: Any]? = nil,
                       shippingDetails: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let subscription {
            body["subscription"] = subscription
        }
        
        if let accountTaxIds {
            body["account_tax_ids"] = accountTaxIds
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let automaticTax {
            automaticTax.forEach { body["automatic_tax[\($0)]"] = $1 }
        }
        
        if let currency {
            body["currency"] = currency.rawValue
        }
        
        if let customFields {
            body["custom_fields"] = customFields
        }
        
        if let daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let defaultPaymentMethod {
            body["default_payment_method"] = defaultPaymentMethod
        }
        
        if let defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let discounts {
            body["discounts"] = discounts
        }
        
        if let dueDate {
            body["due_date"] = Int(dueDate.timeIntervalSince1970)
        }
        
        if let footer {
            body["footer"] = footer
        }
        
        if let fromInvoice {
            fromInvoice.forEach { body["from_invoice[\($0)]"] = $1 }
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentSettings {
            paymentSettings.forEach { body["payment_settings[\($0)]"] = $1 }
        }
        
        if let pendingInvoiceItemsBehavior {
            body["pending_invoice_items_behavior"] = pendingInvoiceItemsBehavior
        }
        
        if let renderingOptions {
            renderingOptions.forEach { body["rendering_options[\($0)]"] = $1 }
        }
        
        if let shippingCost {
            shippingCost.forEach { body["shippping_cost[\($0)]"] = $1 }
        }
        
        if let shippingDetails {
            shippingDetails.forEach { body["shipping_details[\($0)]"] = $1 }
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: invoices, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(invoice: String, expand: [String]? = nil) async throws -> Invoice {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(invoices)/\(invoice)", query: queryParams, headers: headers)
    }
    
    public func update(invoice: String,
                       autoAdvance: Bool? = nil,
                       collectionMethod: InvoiceCollectionMethod? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       accountTaxIds: [String]? = nil,
                       applicationFeeAmount: Int? = nil,
                       automaticTax: [String: Any]? = nil,
                       customFields: [[String: Any]]? = nil,
                       daysUntilDue: Int? = nil,
                       defaultPaymentMethod: String? = nil,
                       defaultSource: String? = nil,
                       defaultTaxRates: [[String: Any]]? = nil,
                       discounts: [[String: Any]]? = nil,
                       dueDate: Date? = nil,
                       footer: String? = nil,
                       onBehalfOf: String? = nil,
                       paymentSettings: [String: Any]? = nil,
                       renderingOptions: [String: Any]? = nil,
                       shippingCost: [String: Any]? = nil,
                       shippingDetails: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let accountTaxIds {
            body["account_tax_ids"] = accountTaxIds
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let automaticTax {
            automaticTax.forEach { body["automatic_tax[\($0)]"] = $1 }
        }
        
        if let customFields {
            body["custom_fields"] = customFields
        }
        
        if let daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let defaultPaymentMethod {
            body["default_payment_method"] = defaultPaymentMethod
        }
        
        if let defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }

        if let discounts {
            body["discounts"] = discounts
        }
        
        if let dueDate {
            body["due_date"] = Int(dueDate.timeIntervalSince1970)
        }
        
        if let footer {
            body["footer"] = footer
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentSettings {
            paymentSettings.forEach { body["payment_settings[\($0)]"] = $1 }
        }
        
        if let renderingOptions {
            renderingOptions.forEach { body["rendering_options[\($0)]"] = $1 }
        }
        
        if let shippingCost {
            shippingCost.forEach { body["shippping_cost[\($0)]"] = $1 }
        }
        
        if let shippingDetails {
            shippingDetails.forEach { body["shipping_details[\($0)]"] = $1 }
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(invoice: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(invoices)/\(invoice)", headers: headers)
    }
    
    public func finalize(invoice: String, autoAdvance: Bool? = nil, expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/finalize", body: .string(body.queryParameters), headers: headers)
    }
    
    public func pay(invoice: String,
                    forgive: Bool? = nil,
                    mandate: String? = nil,
                    offSession: Bool? = nil,
                    paidOutOfBand: Bool? = nil,
                    paymentMethod: String? = nil,
                    source: String? = nil,
                    expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let forgive {
            body["forgive"] = forgive
        }
        
        if let mandate {
            body["mandate"] = mandate
        }
        
        if let offSession {
            body["off_session"] = offSession
        }
        
        if let paidOutOfBand {
            body["paid_out_of_band"] = paidOutOfBand
        }
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let source {
            body["source"] = source
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/pay", body: .string(body.queryParameters), headers: headers)
    }
    
    public func send(invoice: String, expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/send", body: .string(body.queryParameters), headers: headers)
    }
    
    public func void(invoice: String, expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/void", body: .string(body.queryParameters), headers: headers)
    }
    
    public func markUncollectible(invoice: String, expand: [String]? = nil) async throws -> Invoice {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/mark_uncollectible", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieveLineItems(invoice: String, filter: [String: Any]? = nil) async throws -> InvoiceLineItemList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(invoices)/\(invoice)/lines", query: queryParams, headers: headers)
    }
    
    public func retrieveUpcomingInvoice(filter: [String: Any]? = nil) async throws -> Invoice {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(invoices)/upcoming", query: queryParams, headers: headers)
    }
    
    public func retrieveUpcomingLineItems(filter: [String: Any]?) async throws -> InvoiceLineItemList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(invoices)/upcoming/lines", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> InvoiceList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: invoices, query: queryParams, headers: headers)
    }
    
    public func search(query: String, limit: Int? = nil, page: String? = nil) async throws -> InvoiceSearchResult {
        var queryParams: [String: Any] = ["query": query]
        if let limit {
            queryParams["limit"] = limit
        }
        
        if let page {
            queryParams["page"] = page
        }
        
        return try await apiHandler.send(method: .GET, path: search, query: queryParams.queryParameters, headers: headers)
    }
}
