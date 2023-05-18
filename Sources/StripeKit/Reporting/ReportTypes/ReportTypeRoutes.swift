//
//  ReportTypeRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import NIO
import NIOHTTP1

public protocol ReportTypeRoutes: StripeAPIRoute {
    /// Retrieves the details of a Report Type. (Certain report types require a live-mode API key.)
    /// - Parameter reportType: The ID of the Report Type to retrieve, such as `balance.summary.1`.
    func retrieve(reportType: String) async throws -> ReportType
    
    /// Returns a full list of Report Types.
    func listAll() async throws -> ReportTypeList
}

public struct StripeReportTypeRoutes: ReportTypeRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let reporttypes = APIBase + APIVersion + "reporting/report_types"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(reportType: String) async throws -> ReportType {
        try await apiHandler.send(method: .GET, path: "\(reporttypes)/\(reportType)", headers: headers)
    }
    
    public func listAll() async throws -> ReportTypeList {
        try await apiHandler.send(method: .GET, path: reporttypes, headers: headers)
    }
}
