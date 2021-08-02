//
//  VerificationReportRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/24/21.
//

import NIO
import NIOHTTP1

public protocol VerificationReportRoutes {
    /// Retrieves an existing VerificationReport
    /// - Parameter verificationReportId: The id of the verification report.
    ///
    /// - Returns: A `StripeVerificationReport`
    func retrieve(verificationReportId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationReport>
    
    /// List all verification reports.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// 
    /// - Returns: A `StripeVerificationReportList`
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeVerificationReportList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension VerificationReportRoutes {
    func retrieve(verificationReportId: String, expand: [String]? = nil) -> EventLoopFuture<StripeVerificationReport> {
        retrieve(verificationReportId: verificationReportId, expand: expand)
    }
    
    func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeVerificationReportList> {
        listAll(filter: filter)
    }
}

public struct StripeVerificationReportRoutes: VerificationReportRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let verificationreport = APIBase + APIVersion + "identity/verification_reports"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(verificationReportId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationReport> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: verificationreport + "/\(verificationReportId)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeVerificationReportList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: verificationreport, query: queryParams, headers: headers)
    }
}
