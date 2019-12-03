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
    func retrieve(id: String) -> EventLoopFuture<StripeOrderReturn>
    
    /// Returns a list of your order returns. The returns are returned sorted by creation date, with the most recently created return appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/order_returns/list)
    /// - Returns: A `StripeOrderReturnList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeOrderReturnList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension OrderReturnRoutes {
    public func retrieve(id: String) -> EventLoopFuture<StripeOrderReturn> {
        return retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeOrderReturnList> {
        return listAll(filter: filter)
    }
}

public struct StripeOrderReturnRoutes: OrderReturnRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let orderreturns = APIBase + APIVersion + "order_returns"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeOrderReturn> {
        return apiHandler.send(method: .GET, path: "\(orderreturns)/\(id)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeOrderReturnList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: orderreturns, query: queryParams, headers: headers)
    }
}
