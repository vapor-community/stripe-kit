//
//  MandateRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/23/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol MandateRoutes {
    
    /// Retrieves a Mandate object
    /// - Parameter mandate: ID of the Mandate to retrieve.
    /// - Parameter expand: An array of porperties to expand.
    func retrieve(mandate: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeMandate>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension MandateRoutes {
    func retrieve(mandate: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeMandate> {
        return retrieve(mandate: mandate, expand: expand)
    }
}

public struct StripeMandateRoutes: MandateRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let mandate = APIBase + APIVersion + "mandates"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(mandate: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeMandate> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(self.mandate)/\(mandate)", query: queryParams, headers: headers)
    }
}
