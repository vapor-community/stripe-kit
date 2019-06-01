//
//  OrderReturnRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/25/17.
//
//

import NIO
import NIOHTTP1

public protocol OrderReturnRoutes {
    /// Retrieves the details of an existing order return. Supply the unique order ID from either an order return creation request or the order return list, and Stripe will return the corresponding order information.
    ///
    /// - Parameter id: The identifier of the order return to be retrieved.
    /// - Returns: A `StripeOrderReturn`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String) throws -> EventLoopFuture<StripeOrderReturn>
    
    /// Returns a list of your order returns. The returns are returned sorted by creation date, with the most recently created return appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/order_returns/list)
    /// - Returns: A `StripeOrderReturnList`.
    /// - Throws: A `StripeError`
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeOrderReturnList>
    
    var headers: HTTPHeaders { get set }
}

extension OrderReturnRoutes {
    public func retrieve(id: String) throws -> EventLoopFuture<StripeOrderReturn> {
        return try retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeOrderReturnList> {
        return try listAll(filter: filter)
    }
}

public struct StripeOrderReturnRoutes: OrderReturnRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) throws -> EventLoopFuture<StripeOrderReturn> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.orderReturns(id).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeOrderReturnList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.orderReturn.endpoint, query: queryParams, headers: headers)
    }
}
