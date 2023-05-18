//
//  VerificationReportRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/24/21.
//

import NIO
import NIOHTTP1

public protocol VerificationReportRoutes: StripeAPIRoute {
    /// Retrieves an existing VerificationReport
    /// - Parameter verificationReportId: The id of the verification report.
    ///
    /// - Returns: Returns a ``VerificationReport`` object
    func retrieve(verificationReportId: String, expand: [String]?) async throws -> VerificationReport
    
    /// List all verification reports.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// 
    /// - Returns: List of ``VerificationReport`` objects that match the provided filter criteria.
    func listAll(filter: [String: Any]?) async throws -> VerificationReportList
}

public struct StripeVerificationReportRoutes: VerificationReportRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let verificationreport = APIBase + APIVersion + "identity/verification_reports"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(verificationReportId: String,
                         expand: [String]? = nil) async throws -> VerificationReport {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: verificationreport + "/\(verificationReportId)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> VerificationReportList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: verificationreport, query: queryParams, headers: headers)
    }
}
