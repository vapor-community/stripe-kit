//
//  CreditNoteRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/13/19.
//

import NIO
import NIOHTTP1

public protocol CreditNoteRoutes {
    /// Issue a credit note to adjust the amount of a finalized invoice. For a `status=open` invoice, a credit note reduces its `amount_due`. For a `status=paid` invoice, a credit note does not affect its `amount_due`. Instead, it can result in any combination of the following: /n - Refund: create a new refund (using `refund_amount`) or link an existing refund (using `refund`). - Customer balance credit: credit the customer’s balance (using `credit_amount`) which will be automatically applied to their next invoice when it’s finalized. - Outside of Stripe credit: any positive value from the result of `amount - refund_amount - credit_amount` is represented as an “outside of Stripe” credit. /n You may issue multiple credit notes for an invoice. Each credit note will increment the invoice’s `pre_payment_credit_notes_amount` or `post_payment_credit_notes_amount` depending on its `status` at the time of credit note creation.
    ///
    /// - Parameters:
    ///   - amount: The integer amount in cents representing the total amount of the credit note.
    ///   - invoice: ID of the invoice.
    ///   - creditAmount: The integer amount in cents representing the amount to credit the customer’s balance, which will be automatically applied to their next invoice.
    ///   - memo: The credit note’s memo appears on the credit note PDF. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - reason: Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    ///   - refund: ID of an existing refund to link this credit note to.
    ///   - refundAmount: The integer amount in cents representing the amount to refund. If set, a refund will be created for the charge associated with the invoice.
    /// - Returns: A `StripeCreditNote`.
    /// - Throws: A `StripeError`.
    func create(amount: Int,
                invoice: String,
                creditAmount: Int?,
                memo: String?,
                metadata: [String: String]?,
                reason: StripeCreditNoteReason?,
                refund: String?,
                refundAmount: Int?) throws -> EventLoopFuture<StripeCreditNote>
    
    /// Retrieves the credit note object with the given identifier.
    ///
    /// - Parameter id: ID of the credit note object to retrieve.
    /// - Returns: A `StripeCreditNote`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String) throws -> EventLoopFuture<StripeCreditNote>
    
    /// Updates an existing credit note.
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to update.
    ///   - memo: Credit note memo. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeCreditNote`.
    /// - Throws: A `StripeError`.
    func update(id: String, memo: String?, metadata: [String: String]?) throws -> EventLoopFuture<StripeCreditNote>
    
    /// Marks a credit note as void. Learn more about [voiding credit notes](https://stripe.com/docs/billing/invoices/credit-notes#voiding).
    ///
    /// - Parameter id: ID of the credit note object to void.
    /// - Returns: A `StripeCreditNote`.
    /// - Throws: A `StripeError`.
    func void(id: String) throws -> EventLoopFuture<StripeCreditNote>
    
    /// Returns a list of credit notes.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/credit_notes/list)
    /// - Returns: A `StripeCreditNoteList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeCreditNoteList>
    
    var headers: HTTPHeaders { get set }
}

extension CreditNoteRoutes {
    public func create(amount: Int,
                       invoice: String,
                       creditAmount: Int? = nil,
                       memo: String? = nil,
                       metadata: [String: String]? = nil,
                       reason: StripeCreditNoteReason? = nil,
                       refund: String? = nil,
                       refundAmount: Int? = nil) throws -> EventLoopFuture<StripeCreditNote> {
        return try create(amount: amount,
                          invoice: invoice,
                          creditAmount: creditAmount,
                          memo: memo,
                          metadata: metadata,
                          reason: reason,
                          refund: refund,
                          refundAmount: refundAmount)
    }
    
    public func retrieve(id: String) throws -> EventLoopFuture<StripeCreditNote> {
        return try retrieve(id: id)
    }
    
    public func update(id: String, memo: String? = nil, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeCreditNote> {
        return try update(id: id, memo: memo, metadata: metadata)
    }
    
    public func void(id: String) throws -> EventLoopFuture<StripeCreditNote> {
        return try void(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeCreditNoteList> {
        return try listAll(filter: filter)
    }
}

public struct StripeCreditNoteRoutes: CreditNoteRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       invoice: String,
                       creditAmount: Int?,
                       memo: String?,
                       metadata: [String: String]?,
                       reason: StripeCreditNoteReason?,
                       refund: String?,
                       refundAmount: Int?) throws -> EventLoopFuture<StripeCreditNote> {
        var body: [String: Any] = ["amount": amount,
                                   "invoice": invoice]
        
        if let creditAmount = creditAmount {
            body["credit_amount"] = creditAmount
        }
        
        if let memo = memo {
            body["memo"] = memo
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let reason = reason {
            body["reason"] = reason.rawValue
        }
        
        if let refund = refund {
            body["refund"] = refund
        }
        
        if let refundAmount = refundAmount {
            body["refund_amount"] = refundAmount
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.creditNote.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String) throws -> EventLoopFuture<StripeCreditNote> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.creditNotes(id).endpoint, headers: headers)
    }
    
    public func update(id: String, memo: String?, metadata: [String: String]?) throws -> EventLoopFuture<StripeCreditNote> {
        var body: [String: Any] = [:]
        
        if let memo = memo {
            body["memo"] = memo
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.creditNotes(id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func void(id: String) throws -> EventLoopFuture<StripeCreditNote> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.creditNotesVoid(id).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeCreditNoteList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.creditNote.endpoint, query: queryParams, headers: headers)
    }
}

