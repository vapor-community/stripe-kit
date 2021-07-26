//
//  ReportRunRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol ReportRunRoutes {
    
    /// Creates a new object and begin running the report. (Requires a live-mode API key.)
    /// - Parameter reportType: The ID of the report type to run, such as "balance.summary.1".
    /// - Parameter parameters: Parameters specifying how the report should be run. Different Report Types have different required and optional parameters, listed in the [API Access to Reports](https://stripe.com/docs/reporting/statements/api) documentation.
    func create(reportType: String, parameters: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeReportRun>
    
    /// Retrieves the details of an existing Report Run. (Requires a live-mode API key.)
    /// - Parameter reportRun: The ID of the run to retrieve
    func retrieve(reportRun: String, context: LoggingContext) -> EventLoopFuture<StripeReportRun>
    
    /// Returns a list of Report Runs, with the most recent appearing first. (Requires a live-mode API key.)
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/reporting/report_run/list)
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeReportRunList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ReportRunRoutes {
    public func create(reportType: String, parameters: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeReportRun> {
        return create(reportType: reportType, parameters: parameters, context: context)
    }
    
    public func retrieve(reportRun: String, context: LoggingContext) -> EventLoopFuture<StripeReportRun> {
        return retrieve(reportRun: reportRun, context: context)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeReportRunList> {
        return listAll(filter: filter, context: context)
    }
}

public struct StripeReportRunRoutes: ReportRunRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let reportruns = APIBase + APIVersion + "reporting/report_runs"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(reportType: String, parameters: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeReportRun> {
        var body: [String: Any] = ["report_type": reportType]
        
        if let parameters = parameters {
            parameters.forEach { body["parameters[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: reportruns, body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func retrieve(reportRun: String, context: LoggingContext) -> EventLoopFuture<StripeReportRun> {
        return apiHandler.send(method: .GET, path: "\(reportruns)/\(reportRun)", headers: headers, context: context)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeReportRunList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: reportruns, query: queryParams, headers: headers, context: context)
    }
}
