//
//  MandateRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/23/19.
//

import NIO
import NIOHTTP1

public protocol MandateRoutes: StripeAPIRoute {    
    /// Retrieves a Mandate object
    /// - Parameter mandate: ID of the Mandate to retrieve.
    /// - Parameter expand: An array of porperties to expand.
    func retrieve(mandate: String, expand: [String]?) async throws -> Mandate
}

public struct StripeMandateRoutes: MandateRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let mandate = APIBase + APIVersion + "mandates"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(mandate: String, expand: [String]? = nil) async throws -> Mandate {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(self.mandate)/\(mandate)", query: queryParams, headers: headers)
    }
}
