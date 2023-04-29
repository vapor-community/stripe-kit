//
//  SetupAttemptRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import NIO
import NIOHTTP1

public protocol SetupAttemptRoutes: StripeAPIRoute {
    /// Returns a list of SetupAttempts associated with a provided SetupIntent.
    /// - Parameters:
    ///   - setupIntent: The seyup attempt
    ///   - filter: A filter for the attempts.
    /// - Returns: A dictionary with a data property that contains an array of up to limit SetupAttempts which were created by the specified SetupIntent, starting after SetupAttempts `starting_after`. Each entry in the array is a separate SetupAttempts object. If no more SetupAttempts are available, the resulting array will be empty. This request should never return an error.
    func listAll(setupIntent: String, filter: [String: Any]?) async throws -> SetupAttemptList
}

public struct StripeSetupAttemptRoutes: SetupAttemptRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let setupAttempts = APIBase + APIVersion + "setup_attempts"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func listAll(setupIntent: String, filter: [String: Any]? = nil) async throws -> SetupAttemptList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(setupAttempts)/\(setupIntent)", query: queryParams, headers: headers)
    }
}
