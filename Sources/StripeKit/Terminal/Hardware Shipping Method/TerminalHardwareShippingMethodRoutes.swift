//
//  TerminalHardwareShippingMethodRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation
import NIO
import NIOHTTP1

public protocol TerminalHardwareShippingMethodRoutes: StripeAPIRoute {
    /// Retrieves an available ``TerminalHardwareShippingMethod`` object.
    /// - Parameter shippingMethod: Id of the hardware shipping method
    /// - Returns: Returns an available ``TerminalHardwareShippingMethod`` object if a valid identifier was provided.
    func retrieve(shippingMethod: String) async throws -> TerminalHardwareShippingMethod
    
    /// List all ``TerminalHardwareShippingMethod`` objects.
    /// - Parameter filter: A dictionary used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of terminal hardware SKUs. Each entry in the array is a separate SKU object.
    func listAll(filter: [String: Any]?) async throws -> TerminalHardwareShippingMethodList
}

public struct StripeTerminalHardwareShippingMethodRoutes: TerminalHardwareShippingMethodRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let terminalhardwareshippingmethods = APIBase + APIVersion + "terminal/hardware_shipping_methods"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(shippingMethod: String) async throws -> TerminalHardwareShippingMethod {
        try await apiHandler.send(method: .GET, path: "\(terminalhardwareshippingmethods)/\(shippingMethod)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TerminalHardwareShippingMethodList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: terminalhardwareshippingmethods, query: queryParams, headers: headers)
    }
}

