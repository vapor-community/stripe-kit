//
//  MandateRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/23/19.
//

import NIO
import NIOHTTP1

public protocol MandateRoutes {
    
    /// Retrieves a Mandate object
    /// - Parameter mandate: ID of the Mandate to retrieve.
    func retrieve(mandate: String) -> EventLoopFuture<StripeMandate>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension MandateRoutes {
    func retrieve(mandate: String) -> EventLoopFuture<StripeMandate> {
        return retrieve(mandate: mandate)
    }
}

public struct StripeMandateRoutes: MandateRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let mandate = APIBase + APIVersion + "mandates"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(mandate: String) -> EventLoopFuture<StripeMandate> {
        return apiHandler.send(method: .GET, path: "\(self.mandate)/\(mandate)", headers: headers)
    }
}
