//
//  CreditNoteRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/13/19.
//

import NIO
import NIOHTTP1

public protocol CreditNoteRoutes: StripeAPIRoute {
    /// Issue a credit note to adjust the amount of a finalized invoice. For a `status=open` invoice, a credit note reduces its `amount_due`. For a `status=paid` invoice, a credit note does not affect its `amount_due`. Instead, it can result in any combination of the following:
    ///
    /// - Refund: create a new refund (using `refund_amount`) or link an existing refund (using `refund`).
    /// - Customer balance credit: credit the customer’s balance (using `credit_amount`) which will be automatically applied to their next invoice when it’s finalized.
    /// - Outside of Stripe credit: record the amount that is or will be credited outside of Stripe (using `out_of_band_amount`).
    ///
    ///  For post-payment credit notes the sum of the refund, credit and outside of Stripe amounts must equal the credit note total.
    ///
    ///  You may issue multiple credit notes for an invoice. Each credit note will increment the invoice’s `pre_payment_credit_notes_amount` or `post_payment_credit_notes_amount` depending on its `status` at the time of credit note creation.
    ///
    /// - Parameters:
    ///   - invoice: ID of the invoice.
    ///   - lines: Line items that make up the credit note.
    ///   - memo: The credit note’s memo appears on the credit note PDF. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - reason: Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    ///   - amount: The integer amount in cents representing the total amount of the credit note.
    ///   - creditAmount: The integer amount in cents representing the amount to credit the customer’s balance, which will be automatically applied to their next invoice.
    ///   - outOfBandAmount: The integer amount in `cents` representing the amount that is credited outside of Stripe.
    ///   - refund: ID of an existing refund to link this credit note to.
    ///   - refundAmount: The integer amount in cents representing the amount to refund. If set, a refund will be created for the charge associated with the invoice.
    ///   - shippingCost: When `shipping_cost` contains the `shipping_rate` from the invoice, the `shipping_cost` is included in the credit note.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCreditNote`.
    func create(invoice: String,
                lines: [[String: Any]]?,
                memo: String?,
                metadata: [String: String]?,
                reason: CreditNoteReason?,
                amount: Int?,
                creditAmount: Int?,
                outOfBandAmount: Int?,
                refund: String?,
                refundAmount: Int?,
                shippingCost: [String: Any]?,
                expand: [String]?) async throws -> CreditNote
    
    /// Get a preview of a credit note without creating it.
    /// - Parameters:
    ///   - invoice: ID of the invoice.
    ///   - lines: Line items that make up the credit note.
    ///   - memo: The credit note’s memo appears on the credit note PDF. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object   a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to   `metadata`.
    ///   - reason: Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or   `product_unsatisfactory`
    ///   - amount: The integer amount in cents representing the total amount of the credit note.
    ///   - creditAmount: The integer amount in cents representing the amount to credit the customer’s balance, which will be automatically applie  to their next invoice.
    ///   - outOfBandAmount: The integer amount in `cents` representing the amount that is credited outside of Stripe.
    ///   - refund: ID of an existing refund to link this credit note to.
    ///   - refundAmount: The integer amount in cents representing the amount to refund. If set, a refund will be created for the charge associated with the invoice.
    ///   - shippingCost: When `shipping_cost` contains the `shipping_rate` from the invoice, the `shipping_cost` is included in the credit note.
    ///   - expand: An array of properties to expand.
    func preview(invoice: String,
                 lines: [[String: Any]]?,
                 memo: String?,
                 metadata: [String: String]?,
                 reason: CreditNoteReason?,
                 amount: Int?,
                 creditAmount: Int?,
                 outOfBandAmount: Int?,
                 refund: String?,
                 refundAmount: Int?,
                 shippingCost: [String: Any]?,
                 expand: [String]?) async throws -> CreditNote
    
    /// Retrieves the credit note object with the given identifier.
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a credit note object if a valid identifier was provided.
    func retrieve(id: String, expand: [String]?) async throws -> CreditNote
    
    /// Updates an existing credit note.
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to update.
    ///   - memo: Credit note memo. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the updated credit note object if the call succeeded.
    func update(id: String, memo: String?, metadata: [String: String]?, expand: [String]?) async throws -> CreditNote
    
    /// When retrieving a credit note, you’ll get a lines property containing the the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - id: The id of the credit note.
    ///   - filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/credit_notes/lines?lang=curl)
    func retrieveLineItems(id: String, filter: [String: Any]?) async throws -> CreditNoteLineItemList
    
    /// When retrieving a credit note preview, you’ll get a lines property containing the first handful of those items. This URL you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - id: ID of the invoice.
    ///   - filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/credit_notes/preview_lines?lang=curl)
    func retrievePreviewLineItems(invoice: String, filter: [String: Any]?) async throws -> CreditNoteLineItemList
    
    
    /// Marks a credit note as void. Learn more about [voiding credit notes.](https://stripe.com/docs/billing/invoices/credit-notes#voiding)
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to void.
    ///   - expand: An array of properties to expand.
    func void(id: String, expand: [String]?) async throws -> CreditNote
    
    /// Returns a list of credit notes.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/credit_notes/list)
    func listAll(filter: [String: Any]?) async throws -> CreditNoteList
}

public struct StripeCreditNoteRoutes: CreditNoteRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let creditnotes = APIBase + APIVersion + "credit_notes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(invoice: String,
                       lines: [[String: Any]]? = nil,
                       memo: String? = nil,
                       metadata: [String: String]? = nil,
                       reason: CreditNoteReason? = nil,
                       amount: Int? = nil,
                       creditAmount: Int? = nil,
                       outOfBandAmount: Int? = nil,
                       refund: String? = nil,
                       refundAmount: Int? = nil,
                       shippingCost: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> CreditNote {
        
        var body: [String: Any] = ["invoice": invoice]
        
        if let lines {
            body["lines"] = lines
        }
        
        if let memo {
            body["memo"] = memo
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let reason {
            body["reason"] = reason.rawValue
        }
        
        if let amount {
            body["amount"] = amount
        }
        
        if let creditAmount {
            body["credit_amount"] = creditAmount
        }
        
        if let outOfBandAmount {
            body["out_of_band_amount"] = outOfBandAmount
        }
        
        if let refund {
            body["refund"] = refund
        }
        
        if let refundAmount {
            body["refund_amount"] = refundAmount
        }
        
        if let shippingCost {
            shippingCost.forEach { body["shipping_cost[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: creditnotes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func preview(invoice: String,
                        lines: [[String: Any]]? = nil,
                        memo: String? = nil,
                        metadata: [String: String]? = nil,
                        reason: CreditNoteReason? = nil,
                        amount: Int? = nil,
                        creditAmount: Int? = nil,
                        outOfBandAmount: Int? = nil,
                        refund: String? = nil,
                        refundAmount: Int? = nil,
                        shippingCost: [String: Any]? = nil,
                        expand: [String]? = nil) async throws -> CreditNote {
        var body: [String: Any] = ["invoice": invoice]

        if let lines {
            body["lines"] = lines
        }
        
        if let memo {
            body["memo"] = memo
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let reason {
            body["reason"] = reason.rawValue
        }
        
        if let amount {
            body["amount"] = amount
        }
        
        if let creditAmount {
            body["credit_amount"] = creditAmount
        }
        
        if let outOfBandAmount {
            body["out_of_band_amount"] = outOfBandAmount
        }
        
        if let refund {
            body["refund"] = refund
        }
        
        if let refundAmount {
            body["refund_amount"] = refundAmount
        }
        
        if let shippingCost {
            shippingCost.forEach { body["shipping_cost[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(creditnotes)/preview", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, expand: [String]? = nil) async throws -> CreditNote {
        var queryParams = ""
        if let expand {
            queryParams += ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(creditnotes)/\(id)", query: queryParams, headers: headers)
    }
    
    public func update(id: String,
                       memo: String? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> CreditNote {
        var body: [String: Any] = [:]
        
        if let memo {
            body["memo"] = memo
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(creditnotes)/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieveLineItems(id: String, filter: [String: Any]? = nil) async throws -> CreditNoteLineItemList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(creditnotes)/\(id)/lines", query: queryParams, headers: headers)
    }
    
    public func retrievePreviewLineItems(invoice: String, filter: [String: Any]? = nil) async throws -> CreditNoteLineItemList {
        var queryParams = "invoice=\(invoice)"
        if let filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(creditnotes)/preview/lines", query: queryParams, headers: headers)
    }
    
    public func void(id: String, expand: [String]? = nil) async throws -> CreditNote {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(creditnotes)/\(id)/void", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> CreditNoteList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: creditnotes, query: queryParams, headers: headers)
    }
}

