//
//  EarlyFraudWarningRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import NIO
import NIOHTTP1

public protocol EarlyFraudWarningRoutes {
    
    /// Retrieves the details of an early fraud warning that has previously been created.
    /// - Parameter earlyFraudWarning: The identifier of the early fraud warning to be retrieved.
    func retrieve(earlyFraudWarning: String) -> EventLoopFuture<StripeEarlyFraudWarning>
    
    /// Returns a list of early fraud warnings.
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/radar/early_fraud_warnings/list).
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeEarlyFraudWarningList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension EarlyFraudWarningRoutes {
    public func retrieve(earlyFraudWarning: String) -> EventLoopFuture<StripeEarlyFraudWarning> {
        return retrieve(earlyFraudWarning: earlyFraudWarning)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeEarlyFraudWarningList> {
        return listAll(filter: filter)
    }
}

public struct StripeEarlyFraudWarningRoutes: EarlyFraudWarningRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let earlyfraudwarnings = APIBase + APIVersion + "radar/early_fraud_warnings"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(earlyFraudWarning: String) -> EventLoopFuture<StripeEarlyFraudWarning> {
        return apiHandler.send(method: .GET, path: "\(earlyfraudwarnings)/\(earlyFraudWarning)", headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil) -> EventLoopFuture<StripeEarlyFraudWarningList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: earlyfraudwarnings, query: queryParams, headers: headers)
    }
}
