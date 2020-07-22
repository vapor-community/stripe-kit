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
    ///   - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions. Defaults to `charge_automatically`.
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
    ///   - transferData: If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer will be found on the invoice’s charge.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func create(customer: String,
                applicationFeeAmount: Int?,
                autoAdvance: Bool?,
                collectionMethod: StripeInvoiceCollectionMethod?,
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
                subscription: String?,
                transferData: [String: Any]?,
                expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Retrieves the invoice with the given ID.
    ///
    /// - Parameters:
    ///   - invoice: The identifier of the desired invoice.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func retrieve(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Draft invoices are fully editable. Once an invoice is [finalized](https://stripe.com/docs/billing/invoices/workflow#finalized), monetary values, as well as `billing`, become uneditable.
    ///
    /// - Parameters:
    ///   - invoice: The ID of the invoice to be updated.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. For more information, see the application fees documentation.
    ///   - autoAdvance: Controls whether Stripe will perform automatic collection of the invoice.
    ///   - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions. Defaults to `charge_automatically`.
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
    ///   - transferData: If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer will be found on the invoice’s charge. This will be unset if you POST an empty value.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func update(invoice: String,
                applicationFeeAmount: Int?,
                autoAdvance: Bool?,
                collectionMethod: StripeInvoiceCollectionMethod?,
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
                transferData: [String: Any]?,
                expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Permanently deletes a draft invoice. This cannot be undone. Attempts to delete invoices that are no longer in a draft state will fail; once an invoice has been finalized, it must be [voided](https://stripe.com/docs/api/invoices/delete#void_invoice).
    ///
    /// - Parameter invoice: The identifier of the invoice to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    func delete(invoice: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Stripe automatically finalizes drafts before sending and attempting payment on invoices. However, if you’d like to finalize a draft invoice manually, you can do so using this method.
    ///
    /// - Parameters:
    ///   - invoice: The invoice to be finalized, it must have `status=draft`.
    ///   - autoAdvance: Controls whether Stripe will perform automatic collection of the invoice. When false, the invoice’s state will not automatically advance without an explicit action.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func finalize(invoice: String, autoAdvance: Bool?, expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Stripe automatically creates and then attempts to collect payment on invoices for customers on subscriptions according to your subscriptions settings. However, if you’d like to attempt payment on an invoice out of the normal collection schedule or for some other reason, you can do so.
    ///
    /// - Parameters:
    ///   - invoice: ID of invoice to pay.
    ///   - forgive: In cases where the source used to pay the invoice has insufficient funds, passing `forgive=true` controls whether a charge should be attempted for the full amount available on the source, up to the amount to fully pay the invoice. This effectively forgives the difference between the amount available on the source and the amount due. /n Passing `forgive=false` will fail the charge if the source hasn’t been pre-funded with the right amount. An example for this case is with ACH Credit Transfers and wires: if the amount wired is less than the amount due by a small amount, you might want to forgive the difference.
    ///   - paidOutOfBand: Boolean representing whether an invoice is paid outside of Stripe. This will result in no charge being made.
    ///   - paymentMethod: A PaymentMethod to be charged. The PaymentMethod must be the ID of a PaymentMethod belonging to the customer associated with the invoice being paid.
    ///   - source: A payment source to be charged. The source must be the ID of a source belonging to the customer associated with the invoice being paid.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func pay(invoice: String,
             forgive: Bool?,
             paidOutOfBand: Bool?,
             paymentMethod: String?,
             source: String?,
             expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Stripe will automatically send invoices to customers according to your subscriptions settings. However, if you’d like to manually send an invoice to your customer out of the normal schedule, you can do so. When sending invoices that have already been paid, there will be no reference to the payment in the email. /n Requests made in test-mode result in no emails being sent, despite sending an invoice.sent event.
    ///
    /// - Parameters:
    ///   - invoice: The invoice you would like to send. The billing mode for this invoice must be `send_invoice`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func send(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is similar to [deletion](https://stripe.com/docs/api/invoices/void#delete_invoice), however it only applies to finalized invoices and maintains a papertrail where the invoice can still be found.
    ///
    /// - Parameters:
    ///   - invoice: ID of invoice to void. It must be finalized.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func void(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// Marking an invoice as uncollectible is useful for keeping track of bad debts that can be written off for accounting purposes.
    ///
    /// - Parameters:
    ///   - invoice: The identifier of the invoice to be marked as uncollectible. The invoice must be `open`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoice`.
    func markUncollectible(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice>
    
    /// When retrieving an invoice, you’ll get a lines property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    ///
    /// - Parameters:
    ///   - invoice: The ID of the invoice containing the lines to be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/invoice_lines).
    /// - Returns: A `StripeInvoiceLineItemList`.
    func retrieveLineItems(invoice: String, filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceLineItemList>
    
    ///  At any time, you can preview the upcoming invoice for a customer. This will show you all the charges that are pending, including subscription renewal charges, invoice item charges, etc. It will also show you any discount that is applicable to the customer. /n Note that when you are viewing an upcoming invoice, you are simply viewing a preview – the invoice has not yet been created. As such, the upcoming invoice will not show up in invoice listing calls, and you cannot use the API to pay or edit the invoice. If you want to change the amount that your customer will be billed, you can add, remove, or update pending invoice items, or update the customer’s discount. /n You can preview the effects of updating a subscription, including a preview of what proration will take place. To ensure that the actual proration is calculated exactly the same as the previewed proration, you should pass a `proration_date` parameter when doing the actual subscription update. The value passed in should be the same as the `subscription_proration_date` returned on the upcoming invoice resource. The recommended way to get only the prorations being previewed is to consider only proration line items where `period[start]` is equal to the `subscription_proration_date` on the upcoming invoice resource.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/upcoming).
    /// - Returns: A `StripeInvoice`.
    func retrieveUpcomingInvoice(filter: [String: Any]?) -> EventLoopFuture<StripeInvoice>
    
    /// When retrieving an upcoming invoice, you’ll get a lines property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/upcoming_invoice_lines).
    /// - Returns: A `StripeInvoiceLineItemList`.
    func retrieveUpcomingLineItems(filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceLineItemList>
    
    /// You can list all invoices, or list the invoices for a specific customer. The invoices are returned sorted by creation date, with the most recently created invoices appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoices/list).
    /// - Returns: A `StripeInvoiceList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension InvoiceRoutes {
    public func create(customer: String,
                       applicationFeeAmount: Int? = nil,
                       autoAdvance: Bool? = nil,
                       collectionMethod: StripeInvoiceCollectionMethod? = nil,
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
                       subscription: String? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return create(customer: customer,
                      applicationFeeAmount: applicationFeeAmount,
                      autoAdvance: autoAdvance,
                      collectionMethod: collectionMethod,
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
                      subscription: subscription,
                      transferData: transferData,
                      expand: expand)
    }
    
    public func retrieve(invoice: String, expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return retrieve(invoice: invoice, expand: expand)
    }
    
    public func update(invoice: String,
                       applicationFeeAmount: Int? = nil,
                       autoAdvance: Bool? = nil,
                       collectionMethod: StripeInvoiceCollectionMethod? = nil,
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
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return update(invoice: invoice,
                      applicationFeeAmount: applicationFeeAmount,
                      autoAdvance: autoAdvance,
                      collectionMethod: collectionMethod,
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
                      transferData: transferData,
                      expand: expand)
    }
    
    public func delete(invoice: String) -> EventLoopFuture<StripeDeletedObject> {
        return delete(invoice: invoice)
    }
    
    public func finalize(invoice: String, autoAdvance: Bool? = nil, expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return finalize(invoice: invoice, autoAdvance: autoAdvance, expand: expand)
    }
    
    public func pay(invoice: String,
                    forgive: Bool? = nil,
                    paidOutOfBand: Bool? = nil,
                    paymentMethod: String? = nil,
                    source: String? = nil,
                    expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return pay(invoice: invoice,
                   forgive: forgive,
                   paidOutOfBand: paidOutOfBand,
                   paymentMethod: paymentMethod,
                   source: source,
                   expand: expand)
    }
    
    public func send(invoice: String, expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return send(invoice: invoice, expand: expand)
    }
    
    public func void(invoice: String, expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return void(invoice: invoice, expand: expand)
    }
    
    public func markUncollectible(invoice: String, expand: [String]? = nil) -> EventLoopFuture<StripeInvoice> {
        return markUncollectible(invoice: invoice, expand: expand)
    }
    
    public func retrieveLineItems(invoice: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeInvoiceLineItemList> {
        return retrieveLineItems(invoice: invoice, filter: filter)
    }
    
    public func retrieveUpcomingInvoice(filter: [String: Any]? = nil) -> EventLoopFuture<StripeInvoice> {
        return retrieveUpcomingInvoice(filter: filter)
    }
    
    public func retrieveUpcomingLineItems(filter: [String: Any]? = nil) -> EventLoopFuture<StripeInvoiceLineItemList> {
        return retrieveUpcomingLineItems(filter: filter)
    }
    
    public func listAll(filter: [String : Any]? = nil) -> EventLoopFuture<StripeInvoiceList> {
        return listAll(filter: filter)
    }
}

public struct StripeInvoiceRoutes: InvoiceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let invoices = APIBase + APIVersion + "invoices"
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String,
                       applicationFeeAmount: Int?,
                       autoAdvance: Bool?,
                       collectionMethod: StripeInvoiceCollectionMethod?,
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
                       subscription: String?,
                       transferData: [String: Any]?,
                       expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        body["customer"] = customer
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let autoAdvance = autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let collectionMethod = collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
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
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: invoices, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(invoices)/\(invoice)", query: queryParams)
    }
    
    public func update(invoice: String,
                       applicationFeeAmount: Int?,
                       autoAdvance: Bool?,
                       collectionMethod: StripeInvoiceCollectionMethod?,
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
                       transferData: [String: Any]?,
                       expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let autoAdvance = autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let collectionMethod = collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
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
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(invoice: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(invoices)/\(invoice)", headers: headers)
    }
    
    public func finalize(invoice: String, autoAdvance: Bool?, expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let autoAdvance = autoAdvance {
            body["auto_advance"] = autoAdvance
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/finalize", body: .string(body.queryParameters), headers: headers)
    }
    
    public func pay(invoice: String,
                    forgive: Bool?,
                    paidOutOfBand: Bool?,
                    paymentMethod: String?,
                    source: String?,
                    expand: [String]?) -> EventLoopFuture<StripeInvoice> {
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/pay", body: .string(body.queryParameters), headers: headers)
    }
    
    public func send(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/send", body: .string(body.queryParameters), headers: headers)
    }
    
    public func void(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/void", body: .string(body.queryParameters), headers: headers)
    }
    
    public func markUncollectible(invoice: String, expand: [String]?) -> EventLoopFuture<StripeInvoice> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoices)/\(invoice)/mark_uncollectible", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieveLineItems(invoice: String, filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(invoices)/\(invoice)/lines", query: queryParams, headers: headers)
    }
    
    public func retrieveUpcomingInvoice(filter: [String: Any]?) -> EventLoopFuture<StripeInvoice> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(invoices)/upcoming", query: queryParams, headers: headers)
    }
    
    public func retrieveUpcomingLineItems(filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(invoices)/upcoming/lines", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: invoices, query: queryParams, headers: headers)
    }
}
