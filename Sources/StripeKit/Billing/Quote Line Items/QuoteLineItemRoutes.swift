//
//  QuoteLineItemRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/25/21.
//

import NIO
import NIOHTTP1

public protocol QuoteLineItemRoutes {
    /// When retrieving a quote, there is an includable `line_items` property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    /// - Parameter quote: The ID of the quote
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A `StripeQuoteLineItemList`.
    func retrieve(quote: String, filter: [String: Any]?) -> EventLoopFuture<StripeQuoteLineItemList>
    
    /// When retrieving a quote, there is an includable `upfront.line_items` property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of upfront line items.
    /// - Parameter quote: The ID of the quote
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A `StripeQuoteLineItemList`.
    func retrieveUpfront(quote: String, filter: [String: Any]?) -> EventLoopFuture<StripeQuoteLineItemList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension QuoteLineItemRoutes {
    public func retrieve(quote: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeQuoteLineItemList> {
        retrieve(quote: quote, filter: filter)
    }
    
    public func retrieveUpfront(quote: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeQuoteLineItemList> {
        retrieveUpfront(quote: quote, filter: filter)
    }
}

public struct StripeQuoteLineItemRoutes: QuoteLineItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let quotelineitems = APIBase + APIVersion + "quotes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(quote: String, filter: [String: Any]?) -> EventLoopFuture<StripeQuoteLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(quotelineitems)/\(quote)/line_items", query: queryParams, headers: headers)
    }
    
    public func retrieveUpfront(quote: String, filter: [String: Any]?) -> EventLoopFuture<StripeQuoteLineItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(quotelineitems)/\(quote)/computed_upfront_line_items", query: queryParams, headers: headers)
    }
}
