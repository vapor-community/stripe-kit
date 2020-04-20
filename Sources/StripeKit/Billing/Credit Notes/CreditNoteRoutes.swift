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
    ///   - lines: Line items that make up the credit note.
    ///   - outOfBandAmount: The integer amount in `cents` representing the amount that is credited outside of Stripe.
    ///   - creditAmount: The integer amount in cents representing the amount to credit the customer’s balance, which will be automatically applied to their next invoice.
    ///   - memo: The credit note’s memo appears on the credit note PDF. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - reason: Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    ///   - refund: ID of an existing refund to link this credit note to.
    ///   - refundAmount: The integer amount in cents representing the amount to refund. If set, a refund will be created for the charge associated with the invoice.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCreditNote`.
    func create(amount: Int,
                invoice: String,
                lines: [[String: Any]]?,
                outOfBandAmount: Int?,
                creditAmount: Int?,
                memo: String?,
                metadata: [String: String]?,
                reason: StripeCreditNoteReason?,
                refund: String?,
                refundAmount: Int?,
                expand: [String]?) -> EventLoopFuture<StripeCreditNote>
    
    /// Get a preview of a credit note without creating it.
    /// - Parameters:
    ///   - invoice: ID of the invoice.
    ///   - lines: Line items that make up the credit note.
    ///   - amount: The integer amount in cents representing the total amount of the credit note.
    ///   - creditAmount: The integer amount in cents representing the amount to credit the customer’s balance, which will be automatically applie  to their next invoice.
    ///   - outOfBandAmount: The integer amount in `cents` representing the amount that is credited outside of Stripe.
    ///   - memo: The credit note’s memo appears on the credit note PDF. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object   a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to   `metadata`.
    ///   - reason: Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or   `product_unsatisfactory`
    ///   - refund: ID of an existing refund to link this credit note to.
    ///   - refundAmount: The integer amount in cents representing the amount to refund. If set, a refund will be created for the charge associated with the invoice.
    ///   - expand: An array of properties to expand.
    func preview(invoice: String,
                 lines: [[String: Any]]?,
                 amount: Int?,
                 creditAmount: Int?,
                 outOfBandAmount: Int?,
                 memo: String?,
                 metadata: [String: String]?,
                 reason: StripeCreditNoteReason?,
                 refund: String?,
                 refundAmount: Int?,
                 expand: [String]?) -> EventLoopFuture<StripeCreditNote>
    
    /// Retrieves the credit note object with the given identifier.
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCreditNote`.
    func retrieve(id: String, expand: [String]?) -> EventLoopFuture<StripeCreditNote>
    
    /// Updates an existing credit note.
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to update.
    ///   - memo: Credit note memo. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCreditNote`.
    func update(id: String, memo: String?, metadata: [String: String]?, expand: [String]?) -> EventLoopFuture<StripeCreditNote>
    
    /// When retrieving a credit note, you’ll get a lines property containing the the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - id: The id of the credit note.
    ///   - filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/credit_notes/lines?lang=curl)
    func retrieveLineItems(id: String, filter: [String: Any]?) -> EventLoopFuture<StripeCreditNoteLineItemList>
    
    /// When retrieving a credit note preview, you’ll get a lines property containing the first handful of those items. This URL you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - id: ID of the invoice.
    ///   - filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/credit_notes/preview_lines?lang=curl)
    func retrievePreviewLineItems(invoice: String, filter: [String: Any]?) -> EventLoopFuture<StripeCreditNoteLineItemList>
    
    
    /// Marks a credit note as void. Learn more about [voiding credit notes.](https://stripe.com/docs/billing/invoices/credit-notes#voiding)
    ///
    /// - Parameters:
    ///   - id: ID of the credit note object to void.
    ///   - expand: An array of properties to expand.
    func void(id: String, expand: [String]?) -> EventLoopFuture<StripeCreditNote>
    
    /// Returns a list of credit notes.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/credit_notes/list)
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeCreditNoteList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension CreditNoteRoutes {
    public func create(amount: Int,
                       invoice: String,
                       lines: [[String: Any]]? = nil,
                       outOfBandAmount: Int? = nil,
                       creditAmount: Int? = nil,
                       memo: String? = nil,
                       metadata: [String: String]? = nil,
                       reason: StripeCreditNoteReason? = nil,
                       refund: String? = nil,
                       refundAmount: Int? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeCreditNote> {
        return create(amount: amount,
                      invoice: invoice,
                      lines: lines,
                      outOfBandAmount: outOfBandAmount,
                      creditAmount: creditAmount,
                      memo: memo,
                      metadata: metadata,
                      reason: reason,
                      refund: refund,
                      refundAmount: refundAmount,
                      expand: expand)
    }
    
    public func preview(invoice: String,
                        lines: [[String: Any]]?,
                        amount: Int? = nil,
                        creditAmount: Int? = nil,
                        outOfBandAmount: Int? = nil,
                        memo: String? = nil,
                        metadata: [String: String]? = nil,
                        reason: StripeCreditNoteReason? = nil,
                        refund: String? = nil,
                        refundAmount: Int? = nil,
                        expand: [String]? = nil) -> EventLoopFuture<StripeCreditNote> {
        return preview(invoice: invoice,
                       lines: lines,
                       amount: amount,
                       creditAmount: creditAmount,
                       outOfBandAmount: outOfBandAmount,
                       memo: memo,
                       metadata: metadata,
                       reason: reason,
                       refund: refund,
                       refundAmount: refundAmount,
                       expand: expand)
    }
    
    public func retrieve(id: String, expand: [String]? = nil) -> EventLoopFuture<StripeCreditNote> {
        return retrieve(id: id, expand: expand)
    }
    
    public func update(id: String,
                       memo: String? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeCreditNote> {
        return update(id: id, memo: memo, metadata: metadata, expand: expand)
    }
    
    public func retrieveLineItems(id: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeCreditNoteLineItemList> {
        retrieveLineItems(id: id, filter: filter)
    }
    
    public func retrievePreviewLineItems(invoice: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeCreditNoteLineItemList> {
        retrievePreviewLineItems(invoice: invoice, filter: filter)
    }
    
    public func void(id: String, expand: [String]? = nil) -> EventLoopFuture<StripeCreditNote> {
        return void(id: id, expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeCreditNoteList> {
        return listAll(filter: filter)
    }
}

public struct StripeCreditNoteRoutes: CreditNoteRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let creditnotes = APIBase + APIVersion + "credit_notes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       invoice: String,
                       lines: [[String: Any]]?,
                       outOfBandAmount: Int?,
                       creditAmount: Int?,
                       memo: String?,
                       metadata: [String: String]?,
                       reason: StripeCreditNoteReason?,
                       refund: String?,
                       refundAmount: Int?,
                       expand: [String]?) -> EventLoopFuture<StripeCreditNote> {
        var body: [String: Any] = ["amount": amount,
                                   "invoice": invoice]
        
        if let lines = lines {
            body["lines"] = lines
        }
        
        if let outOfBandAmount = outOfBandAmount {
            body["out_of_band_amount"] = outOfBandAmount
        }
        
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: creditnotes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func preview(invoice: String,
                        lines: [[String: Any]]?,
                        amount: Int?,
                        creditAmount: Int?,
                        outOfBandAmount: Int?,
                        memo: String?,
                        metadata: [String: String]?,
                        reason: StripeCreditNoteReason?,
                        refund: String?,
                        refundAmount: Int?,
                        expand: [String]?) -> EventLoopFuture<StripeCreditNote> {
        var body: [String: Any] = ["invoice": invoice]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let lines = lines {
            body["lines"] = lines
        }
        
        if let creditAmount = creditAmount {
            body["credit_amount"] = creditAmount
        }
        
        if let outOfBandAmount = outOfBandAmount {
            body["out_of_band_amount"] = outOfBandAmount
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(creditnotes)/preview", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, expand: [String]?) -> EventLoopFuture<StripeCreditNote> {
        var queryParams = ""
        if let expand = expand {
            queryParams += ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(creditnotes)/\(id)", query: queryParams, headers: headers)
    }
    
    public func update(id: String,
                       memo: String?,
                       metadata: [String: String]?,
                       expand: [String]?) -> EventLoopFuture<StripeCreditNote> {
        var body: [String: Any] = [:]
        
        if let memo = memo {
            body["memo"] = memo
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(creditnotes)/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieveLineItems(id: String, filter: [String: Any]?) -> EventLoopFuture<StripeCreditNoteLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(creditnotes)/\(id)/lines", query: queryParams, headers: headers)
    }
    
    public func retrievePreviewLineItems(invoice: String, filter: [String: Any]?) -> EventLoopFuture<StripeCreditNoteLineItemList> {
        var queryParams = "invoice=\(invoice)"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(creditnotes)/preview/lines", query: queryParams, headers: headers)
    }
    
    public func void(id: String, expand: [String]?) -> EventLoopFuture<StripeCreditNote> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(creditnotes)/\(id)/void", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeCreditNoteList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: creditnotes, query: queryParams, headers: headers)
    }
}

