//
//  ScheduledQueryRunRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol ScheduledQueryRunRoutes: StripeAPIRoute {
    /// Retrieves the details of an scheduled query run.
    ///
    /// - Parameter scheduledQueryRun: Unique identifier for the object.
    /// - Returns: A `StripeScheduledQueryRun`.
    func retrieve(scheduledQueryRun: String) async throws -> ScheduledQueryRun
    
    /// Returns a list of scheduled query runs.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/sigma/scheduled_queries/list)
    /// - Returns: A `StripeScheduledQueryRunList`.
    func listAll(filter: [String: Any]?) async throws -> ScheduledQueryRunList
}

public struct StripeScheduledQueryRunRoutes: ScheduledQueryRunRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let scheduledqueryruns = APIBase + APIVersion + "scheduled_query_runs"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(scheduledQueryRun: String) async throws -> ScheduledQueryRun {
        try await apiHandler.send(method: .GET, path: "\(scheduledqueryruns)/\(scheduledQueryRun)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> ScheduledQueryRunList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: scheduledqueryruns, query: queryParams, headers: headers)
    }
}
