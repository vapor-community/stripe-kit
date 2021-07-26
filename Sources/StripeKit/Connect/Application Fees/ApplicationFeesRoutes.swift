//
//  ApplicationFeesRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol ApplicationFeesRoutes {
    /// Retrieves the details of an application fee that your account has collected. The same information is returned when refunding the application fee.
    ///
    /// - Parameters:
    ///   - fee: The identifier of the fee to be retrieved.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeApplicationFee`.
    func retrieve(fee: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFee>
    
    /// Returns a list of application fees you’ve previously collected. The application fees are returned in sorted order, with the most recent fees appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/application_fees/list)
    /// - Returns: A `StripeApplicationFeeList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ApplicationFeesRoutes {
    public func retrieve(fee: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeApplicationFee> {
        return retrieve(fee: fee, expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeList> {
        return listAll(filter: filter)
    }
}

public struct StripeApplicationFeeRoutes: ApplicationFeesRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let applicationfees = APIBase + APIVersion + "application_fees"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(fee: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFee> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(applicationfees)/\(fee)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: applicationfees, query: queryParams, headers: headers)
    }
}
