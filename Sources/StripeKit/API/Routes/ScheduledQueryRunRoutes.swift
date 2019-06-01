//
//  ScheduledQueryRunRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol ScheduledQueryRunRoutes {
    /// Retrieves the details of an scheduled query run.
    ///
    /// - Parameter scheduledQueryRun: Unique identifier for the object.
    /// - Returns: A `StripeScheduledQueryRun`.
    /// - Throws: A `StripeError`.
    func retrieve(scheduledQueryRun: String) throws -> EventLoopFuture<StripeScheduledQueryRun>
    
    /// Returns a list of scheduled query runs.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/sigma/scheduled_queries/list)
    /// - Returns: A `StripeScheduledQueryRunList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeScheduledQueryRunList>
    
    var headers: HTTPHeaders { get set }
}

extension ScheduledQueryRunRoutes {
    func retrieve(scheduledQueryRun: String) throws -> EventLoopFuture<StripeScheduledQueryRun> {
        return try retrieve(scheduledQueryRun: scheduledQueryRun)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeScheduledQueryRunList> {
        return try listAll(filter: filter)
    }
}

public struct StripeScheduledQueryRunRoutes: ScheduledQueryRunRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(scheduledQueryRun: String) throws -> EventLoopFuture<StripeScheduledQueryRun> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.scheduledQueryRuns(scheduledQueryRun).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeScheduledQueryRunList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.scheduledQueryRun.endpoint, query: queryParams, headers: headers)
    }
}
