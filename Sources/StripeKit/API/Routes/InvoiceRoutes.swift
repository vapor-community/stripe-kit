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

public protocol InvoiceRoutes {
    /// This endpoint creates a draft invoice for a given customer. The draft invoice created pulls in all pending invoice items on that customer, including prorations.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer to create this invoice for.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. For more information, see the application fees
    ///   - autoAdvance: Controls whether Stripe will perform [automatic collection](https://stripe.com/docs/billing/invoices/workflow/#auto_advance) of the invoice. When `false`, the invoice’s state will not automatically advance without an explicit action.
    ///   - billing: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions. Defaults to `charge_automatically`.
    ///   - customFields: A list of up to 4 custom fields to be displayed on the invoice.
    ///   - daysUntilDue: The number of days from when the invoice is created until it is due. Valid only for invoices where `billing=send_invoice`.
    ///   - defaultPaymentMethod: ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription’s default payment method, if any, or to the default payment method in the customer’s invoice settings.
    ///   - defaultSource: ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription’s default source, if any, or to the customer’s default source.
    ///   - defaultTaxRates:
    ///   - description:
    ///   - dueDate: The date on which payment for this invoice is due. Valid only for invoices where `billing=send_invoice`.
    ///   - footer: Footer to be displayed on the invoice. This will be unset if you POST an empty value.
    ///   - metadata:
    ///   - statementDescriptor: Extra information about a charge for the customer’s credit card statement. It must contain at least one letter. If not specified and this invoice is part of a subscription, the default `statement_descriptor` will be set to the first subscription item’s product’s `statement_descriptor`.
    ///   - subscription: The ID of the subscription to invoice, if any. If not set, the created invoice will include all pending invoice items for the customer. If set, the created invoice will only include pending invoice items for that subscription and pending invoice items not associated with any subscription. The subscription’s billing cycle and regular subscription events won’t be affected.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func create(customer: String,
                applicationFeeAmount: Int?,
                autoAdvance: Bool?,
                billing: StripeInvoiceBiling?,
                customFields: [[String: Any]]?,
                daysUntilDue: Int?,
                defaultPaymentMethod: String?,
                defaultSource: String?,
                defaultTaxRates: [[String: Any]]?,
                description: String?,
                dueDate: Date?,
                footer: String?,
                metadata: [String: String]?,
                statementDescriptor: String?,
                subscription: String?) throws -> EventLoopFuture<StripeInvoice>
    
    /// Retrieves the invoice with the given ID.
    ///
    /// - Parameter invoice: The identifier of the desired invoice.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func retrieve(invoice: String) throws -> EventLoopFuture<StripeInvoice>
    
    /// Draft invoices are fully editable. Once an invoice is [finalized](https://stripe.com/docs/billing/invoices/workflow#finalized), monetary values, as well as `billing`, become uneditable.
    ///
    /// - Parameters:
    ///   - invoice: The ID of the invoice to be updated.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. For more information, see the application fees documentation.
    ///   - autoAdvance: Controls whether Stripe will perform automatic collection of the invoice.
    ///   - customFields: A list of up to 4 custom fields to be displayed on the invoice. If a value for custom_fields is specified, the list specified will replace the existing custom field list on this invoice.
    ///   - daysUntilDue: The number of days from which the invoice is created until it is due. Only valid for invoices where billing=send_invoice. This field can only be updated on draft invoices.
    ///   - defaultPaymentMethod: ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription’s default payment method, if any, or to the default payment method in the customer’s invoice settings.
    ///   - defaultSource: ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription’s default source, if any, or to the customer’s default source.
    ///   - defaultTaxRates:
    ///   - description:
    ///   - dueDate: The date on which payment for this invoice is due. Only valid for invoices where `billing=send_invoice`. This field can only be updated on draft invoices.
    ///   - footer: Footer to be displayed on the invoice. This will be unset if you POST an empty value.
    ///   - metadata:
    ///   - statementDescriptor: Extra information about a charge for the customer’s credit card statement. It must contain at least one letter. If not specified and this invoice is part of a subscription, the default `statement_descriptor` will be set to the first subscription item’s product’s `statement_descriptor`.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func update(invoice: String,
                applicationFeeAmount: Int?,
                autoAdvance: Bool?,
                customFields: [[String: Any]]?,
                daysUntilDue: Int?,
                defaultPaymentMethod: String?,
                defaultSource: String?,
                defaultTaxRates: [[String: Any]]?,
                description: String?,
                dueDate: Date?,
                footer: String?,
                metadata: [String: String]?,
                statementDescriptor: String?) throws -> EventLoopFuture<StripeInvoice>
    
    /// Permanently deletes a draft invoice. This cannot be undone. Attempts to delete invoices that are no longer in a draft state will fail; once an invoice has been finalized, it must be [voided](https://stripe.com/docs/api/invoices/delete#void_invoice).
    ///
    /// - Parameter invoice: The identifier of the invoice to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func delete(invoice: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// Stripe automatically finalizes drafts before sending and attempting payment on invoices. However, if you’d like to finalize a draft invoice manually, you can do so using this method.
    ///
    /// - Parameters:
    ///   - invoice: The invoice to be finalized, it must have `status=draft`.
    ///   - autoAdvance: Controls whether Stripe will perform automatic collection of the invoice. When false, the invoice’s state will not automatically advance without an explicit action.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func finalize(invoice: String, autoAdvance: Bool?) throws -> EventLoopFuture<StripeInvoice>
    
    /// Stripe automatically creates and then attempts to collect payment on invoices for customers on subscriptions according to your subscriptions settings. However, if you’d like to attempt payment on an invoice out of the normal collection schedule or for some other reason, you can do so.
    ///
    /// - Parameters:
    ///   - invoice: ID of invoice to pay.
    ///   - forgive: In cases where the source used to pay the invoice has insufficient funds, passing `forgive=true` controls whether a charge should be attempted for the full amount available on the source, up to the amount to fully pay the invoice. This effectively forgives the difference between the amount available on the source and the amount due. /n Passing `forgive=false` will fail the charge if the source hasn’t been pre-funded with the right amount. An example for this case is with ACH Credit Transfers and wires: if the amount wired is less than the amount due by a small amount, you might want to forgive the difference.
    ///   - paidOutOfBand: Boolean representing whether an invoice is paid outside of Stripe. This will result in no charge being made.
    ///   - paymentMethod: A PaymentMethod to be charged. The PaymentMethod must be the ID of a PaymentMethod belonging to the customer associated with the invoice being paid.
    ///   - source: A payment source to be charged. The source must be the ID of a source belonging to the customer associated with the invoice being paid.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func pay(invoice: String,
             forgive: Bool?,
             paidOutOfBand: Bool?,
             paymentMethod: String?,
             source: String?) throws -> EventLoopFuture<StripeInvoice>
    
    /// Stripe will automatically send invoices to customers according to your subscriptions settings. However, if you’d like to manually send an invoice to your customer out of the normal schedule, you can do so. When sending invoices that have already been paid, there will be no reference to the payment in the email. /n Requests made in test-mode result in no emails being sent, despite sending an invoice.sent event.
    ///
    /// - Parameter invoice: The invoice you would like to send. The billing mode for this invoice must be `send_invoice`.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func send(invoice: String) throws -> EventLoopFuture<StripeInvoice>
    
    /// Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is similar to [deletion](https://stripe.com/docs/api/invoices/void#delete_invoice), however it only applies to finalized invoices and maintains a papertrail where the invoice can still be found.
    ///
    /// - Parameter invoice: ID of invoice to void. It must be finalized.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func void(invoice: String) throws -> EventLoopFuture<StripeInvoice>
    
    /// Marking an invoice as uncollectible is useful for keeping track of bad debts that can be written off for accounting purposes.
    ///
    /// - Parameter invoice: The identifier of the invoice to be marked as uncollectible. The invoice must be `open`.
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func markUncollectible(invoice: String) throws -> EventLoopFuture<StripeInvoice>
    
    /// When retrieving an invoice, you’ll get a lines property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    ///
    /// - Parameters:
    ///   - invoice: The ID of the invoice containing the lines to be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/invoice_lines).
    /// - Returns: A `StripeInvoiceLineItemList`.
    /// - Throws: A `StripeError`.
    func retrieveLineItems(invoice: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoiceLineItemList>
    
    ///  At any time, you can preview the upcoming invoice for a customer. This will show you all the charges that are pending, including subscription renewal charges, invoice item charges, etc. It will also show you any discount that is applicable to the customer. /n Note that when you are viewing an upcoming invoice, you are simply viewing a preview – the invoice has not yet been created. As such, the upcoming invoice will not show up in invoice listing calls, and you cannot use the API to pay or edit the invoice. If you want to change the amount that your customer will be billed, you can add, remove, or update pending invoice items, or update the customer’s discount. /n You can preview the effects of updating a subscription, including a preview of what proration will take place. To ensure that the actual proration is calculated exactly the same as the previewed proration, you should pass a `proration_date` parameter when doing the actual subscription update. The value passed in should be the same as the `subscription_proration_date` returned on the upcoming invoice resource. The recommended way to get only the prorations being previewed is to consider only proration line items where `period[start]` is equal to the `subscription_proration_date` on the upcoming invoice resource.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/upcoming).
    /// - Returns: A `StripeInvoice`.
    /// - Throws: A `StripeError`.
    func retrieveUpcomingInvoice(filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoice>
    
    /// When retrieving an upcoming invoice, you’ll get a lines property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/upcoming_invoice_lines).
    /// - Returns: A `StripeInvoiceLineItemList`.
    /// - Throws: A `StripeError`.
    func retrieveUpcomingLineItems(filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoiceLineItemList>
    
    /// You can list all invoices, or list the invoices for a specific customer. The invoices are returned sorted by creation date, with the most recently created invoices appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/list).
    /// - Returns: A `StripeInvoiceList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoiceList>
    
    var headers: HTTPHeaders { get set }
}

extension InvoiceRoutes {
    public func create(customer: String,
                       applicationFeeAmount: Int? = nil,
                       autoAdvance: Bool? = nil,
                       billing: StripeInvoiceBiling? = nil,
                       customFields: [[String: Any]]? = nil,
                       daysUntilDue: Int? = nil,
                       defaultPaymentMethod: String? = nil,
                       defaultSource: String? = nil,
                       defaultTaxRates: [[String: Any]]? = nil,
                       description: String? = nil,
                       dueDate: Date? = nil,
                       footer: String? = nil,
                       metadata: [String: String]? = nil,
                       statementDescriptor: String? = nil,
                       subscription: String? = nil) throws -> EventLoopFuture<StripeInvoice> {
        return try create(customer: customer,
                          applicationFeeAmount: applicationFeeAmount,
                          autoAdvance: autoAdvance,
                          billing: billing,
                          customFields: customFields,
                          daysUntilDue: daysUntilDue,
                          defaultPaymentMethod: defaultPaymentMethod,
                          defaultSource: defaultSource,
                          defaultTaxRates: defaultTaxRates,
                          description: description,
                          dueDate: dueDate,
                          footer: footer,
                          metadata: metadata,
                          statementDescriptor: statementDescriptor,
                          subscription: subscription)
    }
    
    public func retrieve(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try retrieve(invoice: invoice)
    }
    
    public func update(invoice: String,
                       applicationFeeAmount: Int? = nil,
                       autoAdvance: Bool? = nil,
                       customFields: [[String: Any]]? = nil,
                       daysUntilDue: Int? = nil,
                       defaultPaymentMethod: String? = nil,
                       defaultSource: String? = nil,
                       defaultTaxRates: [[String: Any]]? = nil,
                       description: String? = nil,
                       dueDate: Date? = nil,
                       footer: String? = nil,
                       metadata: [String: String]? = nil,
                       statementDescriptor: String? = nil) throws -> EventLoopFuture<StripeInvoice> {
        return try update(invoice: invoice,
                          applicationFeeAmount: applicationFeeAmount,
                          autoAdvance: autoAdvance,
                          customFields: customFields,
                          daysUntilDue: daysUntilDue,
                          defaultPaymentMethod: defaultPaymentMethod,
                          defaultSource: defaultSource,
                          defaultTaxRates: defaultTaxRates,
                          description: description,
                          dueDate: dueDate,
                          footer: footer,
                          metadata: metadata,
                          statementDescriptor: statementDescriptor)
    }
    
    public func delete(invoice: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try delete(invoice: invoice)
    }
    
    public func finalize(invoice: String, autoAdvance: Bool? = nil) throws -> EventLoopFuture<StripeInvoice> {
        return try finalize(invoice: invoice, autoAdvance: autoAdvance)
    }
    
    public func pay(invoice: String,
                    forgive: Bool? = nil,
                    paidOutOfBand: Bool? = nil,
                    paymentMethod: String? = nil,
                    source: String? = nil) throws -> EventLoopFuture<StripeInvoice> {
        return try pay(invoice: invoice,
                       forgive: forgive,
                       paidOutOfBand: paidOutOfBand,
                       paymentMethod: paymentMethod,
                       source: source)
    }
    
    public func send(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try send(invoice: invoice)
    }
    
    public func void(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try void(invoice: invoice)
    }
    
    public func markUncollectible(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try markUncollectible(invoice: invoice)
    }
    
    public func retrieveLineItems(invoice: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeInvoiceLineItemList> {
        return try retrieveLineItems(invoice: invoice, filter: filter)
    }
    
    public func retrieveUpcomingInvoice(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeInvoice> {
        return try retrieveUpcomingInvoice(filter: filter)
    }
    
    public func retrieveUpcomingLineItems(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeInvoiceLineItemList> {
        return try retrieveUpcomingLineItems(filter: filter)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> EventLoopFuture<StripeInvoiceList> {
        return try listAll(filter: filter)
    }
}

public struct StripeInvoiceRoutes: InvoiceRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String,
                       applicationFeeAmount: Int?,
                       autoAdvance: Bool?,
                       billing: StripeInvoiceBiling?,
                       customFields: [[String: Any]]?,
                       daysUntilDue: Int?,
                       defaultPaymentMethod: String?,
                       defaultSource: String?,
                       defaultTaxRates: [[String: Any]]?,
                       description: String?,
                       dueDate: Date?,
                       footer: String?,
                       metadata: [String: String]?,
                       statementDescriptor: String?,
                       subscription: String?) throws -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        body["customer"] = customer
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let autoAdvance = autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let billing = billing {
            body["billing"] = billing.rawValue
        }
        
        if let customFields = customFields {
            body["custom_fields"] = customFields
        }
        
        if let daysUntilDue = daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let defaultPaymentMethod = defaultPaymentMethod {
            body["default_payment_method"] = defaultPaymentMethod
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let defaultTaxRates = defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let dueDate = dueDate {
            body["due_date"] = Int(dueDate.timeIntervalSince1970)
        }
        
        if let footer = footer {
            body["footer"] = footer
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let subscription = subscription {
            body["subscription"] = subscription
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoice.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.invoices(invoice).endpoint)
    }
    
    public func update(invoice: String,
                       applicationFeeAmount: Int?,
                       autoAdvance: Bool?,
                       customFields: [[String: Any]]?,
                       daysUntilDue: Int?,
                       defaultPaymentMethod: String?,
                       defaultSource: String?,
                       defaultTaxRates: [[String: Any]]?,
                       description: String?,
                       dueDate: Date?,
                       footer: String?,
                       metadata: [String: String]?,
                       statementDescriptor: String?) throws -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let autoAdvance = autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let customFields = customFields {
            body["custom_fields"] = customFields
        }
        
        if let daysUntilDue = daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let defaultPaymentMethod = defaultPaymentMethod {
            body["default_payment_method"] = defaultPaymentMethod
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let defaultTaxRates = defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let dueDate = dueDate {
            body["due_date"] = Int(dueDate.timeIntervalSince1970)
        }
        
        if let footer = footer {
            body["footer"] = footer
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoices(invoice).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(invoice: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.invoices(invoice).endpoint, headers: headers)
    }
    
    public func finalize(invoice: String, autoAdvance: Bool?) throws -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let autoAdvance = autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoicesFinalize(invoice).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func pay(invoice: String,
                    forgive: Bool?,
                    paidOutOfBand: Bool?,
                    paymentMethod: String?,
                    source: String?) throws -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let forgive = forgive {
            body["forgive"] = forgive
        }
        
        if let paidOutOfBand = paidOutOfBand {
            body["paid_out_of_band"] = paidOutOfBand
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let source = source {
            body["source"] = source
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoicesPay(invoice).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func send(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoicesSend(invoice).endpoint, headers: headers)
    }
    
    public func void(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoicesVoid(invoice).endpoint, headers: headers)
    }
    
    public func markUncollectible(invoice: String) throws -> EventLoopFuture<StripeInvoice> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.invoicesMarkUncollectible(invoice).endpoint, headers: headers)
    }
    
    public func retrieveLineItems(invoice: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoiceLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.invoicesLineItems(invoice).endpoint, query: queryParams, headers: headers)
    }
    
    public func retrieveUpcomingInvoice(filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoice> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.invoicesUpcoming.endpoint, query: queryParams, headers: headers)
    }
    
    public func retrieveUpcomingLineItems(filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoiceLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.invoicesUpcomingLineItems.endpoint, query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeInvoiceList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.invoice.endpoint, query: queryParams, headers: headers)
    }
}
