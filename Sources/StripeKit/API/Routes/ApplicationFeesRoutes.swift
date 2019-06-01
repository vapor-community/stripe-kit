//
//  ApplicationFeesRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import NIO
import NIOHTTP1

public protocol ApplicationFeesRoutes {
    /// Retrieves the details of an application fee that your account has collected. The same information is returned when refunding the application fee.
    ///
    /// - Parameter fee: The identifier of the fee to be retrieved.
    /// - Returns: A `StripeApplicationFee`.
    /// - Throws: A `StripeError`.
    func retrieve(fee: String) throws -> EventLoopFuture<StripeApplicationFee>
    
    /// Returns a list of application fees you’ve previously collected. The application fees are returned in sorted order, with the most recent fees appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/application_fees/list)
    /// - Returns: A `StripeApplicationFeeList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeApplicationFeeList>
    
    var headers: HTTPHeaders { get set }
}

extension ApplicationFeesRoutes {
    public func retrieve(fee: String) throws -> EventLoopFuture<StripeApplicationFee> {
        return try retrieve(fee: fee)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeApplicationFeeList> {
        return try listAll(filter: filter)
    }
}

public struct StripeApplicationFeeRoutes: ApplicationFeesRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(fee: String) throws -> EventLoopFuture<StripeApplicationFee> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.applicationFees(fee).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeApplicationFeeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.applicationFee.endpoint, query: queryParams, headers: headers)
    }
}
