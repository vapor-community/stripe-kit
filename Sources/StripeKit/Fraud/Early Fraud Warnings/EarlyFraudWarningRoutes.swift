//
//  EarlyFraudWarningRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import NIO
import NIOHTTP1

public protocol EarlyFraudWarningRoutes: StripeAPIRoute {
    /// Retrieves the details of an early fraud warning that has previously been created.
    /// - Parameter earlyFraudWarning: The identifier of the early fraud warning to be retrieved.
    /// - Parameter expand: An array of properties to expand.
    func retrieve(earlyFraudWarning: String, expand: [String]?) async throws -> EarlyFraudWarning
    
    /// Returns a list of early fraud warnings.
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/radar/early_fraud_warnings/list)
    func listAll(filter: [String: Any]?) async throws -> EarlyFraudWarningList
}

public struct StripeEarlyFraudWarningRoutes: EarlyFraudWarningRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let earlyfraudwarnings = APIBase + APIVersion + "radar/early_fraud_warnings"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(earlyFraudWarning: String, expand: [String]? = nil) async throws -> EarlyFraudWarning {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(earlyfraudwarnings)/\(earlyFraudWarning)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> EarlyFraudWarningList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: earlyfraudwarnings, query: queryParams, headers: headers)
    }
}
