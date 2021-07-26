//
//  SetupAttemptRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import NIO
import NIOHTTP1
import Baggage

public protocol SetupAttemptRoutes {
    func listAll(setupIntent: String, filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeSetupAttemptList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SetupAttemptRoutes {
    public func listAll(setupIntent: String, filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeSetupAttemptList> {
        listAll(setupIntent: setupIntent, filter: filter)
    }
}

public struct StripeSetupAttemptRoutes: SetupAttemptRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let setupAttempts = APIBase + APIVersion + "setup_attempts"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func listAll(setupIntent: String, filter: [String: Any]?, context: LoggingContext)-> EventLoopFuture<StripeSetupAttemptList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(setupAttempts)/\(setupIntent)", query: queryParams, headers: headers)
    }
}
