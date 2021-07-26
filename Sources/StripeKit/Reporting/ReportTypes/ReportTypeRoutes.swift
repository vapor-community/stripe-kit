//
//  ReportTypeRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol ReportTypeRoutes {
    
    /// Retrieves the details of a Report Type. (Requires a live-mode API key.)
    /// - Parameter reportType: The ID of the Report Type to retrieve, such as `balance.summary.1`.
    func retrieve(reportType: String, context: LoggingContext) -> EventLoopFuture<StripeReportType>
    
    /// Returns a full list of Report Types. (Requires a live-mode API key.)
    func listAll(context: LoggingContext) -> EventLoopFuture<StripeReportTypeList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct StripeReportTypeRoutes: ReportTypeRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let reporttypes = APIBase + APIVersion + "reporting/report_types"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(reportType: String, context: LoggingContext) -> EventLoopFuture<StripeReportType> {
        return apiHandler.send(method: .GET, path: "\(reporttypes)/\(reportType)", headers: headers)
    }
    
    public func listAll(context: LoggingContext) -> EventLoopFuture<StripeReportTypeList> {
        return apiHandler.send(method: .GET, path: reporttypes, headers: headers)
    }
}
