//
//  TerminalHardwareSKURoutes.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation
import NIO
import NIOHTTP1

public protocol TerminalHardwareSKURoutes: StripeAPIRoute {
    /// Retrieves an available ``TerminalHardwareSKU`` object.
    /// - Parameter sku: Id of the hardware sku
    /// - Returns: Returns an available ``TerminalHardwareSKU`` object if a valid identifier was provided.
    func retrieve(sku: String) async throws -> TerminalHardwareSKU
    
    /// List all ``TerminalHardwareSKU`` objects.
    /// - Parameter filter: A dictionary used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of terminal hardware SKUs. Each entry in the array is a separate SKU object.
    func listAll(filter: [String: Any]?) async throws -> TerminalHardwareSKUList
}

public struct StripeTerminalHardwareSKURoutes: TerminalHardwareSKURoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let terminalhardwaresku = APIBase + APIVersion + "terminal/hardware_skus"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(sku: String) async throws -> TerminalHardwareSKU {
        try await apiHandler.send(method: .GET, path: "\(terminalhardwaresku)/\(sku)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TerminalHardwareSKUList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: terminalhardwaresku, query: queryParams, headers: headers)
    }
}
