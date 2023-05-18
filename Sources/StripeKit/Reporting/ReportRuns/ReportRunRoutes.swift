//
//  ReportRunRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import NIO
import NIOHTTP1

public protocol ReportRunRoutes: StripeAPIRoute {
    /// Creates a new object and begin running the report. (Requires a live-mode API key.)
    /// - Parameter reportType: The ID of the report type to run, such as "balance.summary.1".
    /// - Parameter parameters: Parameters specifying how the report should be run. Different Report Types have different required and optional parameters, listed in the [API Access to Reports](https://stripe.com/docs/reporting/statements/api) documentation.
    func create(reportType: String, parameters: [String: Any]?) async throws -> ReportRun
    
    /// Retrieves the details of an existing Report Run. (Requires a live-mode API key.)
    /// - Parameter reportRun: The ID of the run to retrieve
    func retrieve(reportRun: String) async throws -> ReportRun
    
    /// Returns a list of Report Runs, with the most recent appearing first. (Requires a live-mode API key.)
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/reporting/report_run/list)
    func listAll(filter: [String: Any]?) async throws -> ReportRunList
}

public struct StripeReportRunRoutes: ReportRunRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let reportruns = APIBase + APIVersion + "reporting/report_runs"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(reportType: String, parameters: [String: Any]? = nil) async throws -> ReportRun {
        var body: [String: Any] = ["report_type": reportType]
        
        if let parameters {
            parameters.forEach { body["parameters[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: reportruns, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(reportRun: String) async throws -> ReportRun {
        try await apiHandler.send(method: .GET, path: "\(reportruns)/\(reportRun)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> ReportRunList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: reportruns, query: queryParams, headers: headers)
    }
}
