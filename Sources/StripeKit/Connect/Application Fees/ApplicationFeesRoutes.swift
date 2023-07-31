//
//  ApplicationFeesRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import NIO
import NIOHTTP1

public protocol ApplicationFeesRoutes: StripeAPIRoute {
    /// Retrieves the details of an application fee that your account has collected. The same information is returned when refunding the application fee.
    ///
    /// - Parameters:
    ///   - fee: The identifier of the fee to be retrieved.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an application fee object if a valid identifier was provided, and returns an error otherwise.
    func retrieve(fee: String, expand: [String]?) async throws -> ApplicationFee
    
    /// Returns a list of application fees you’ve previously collected. The application fees are returned in sorted order, with the most recent fees appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/application_fees/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` application fees, starting after application fee `starting_after`. Each entry in the array is a separate application fee object. If no more fees are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> ApplicationFeeList
}

public struct StripeApplicationFeeRoutes: ApplicationFeesRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let applicationfees = APIBase + APIVersion + "application_fees"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(fee: String, expand: [String]?) async throws -> ApplicationFee {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(applicationfees)/\(fee)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> ApplicationFeeList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: applicationfees, query: queryParams, headers: headers)
    }
}
