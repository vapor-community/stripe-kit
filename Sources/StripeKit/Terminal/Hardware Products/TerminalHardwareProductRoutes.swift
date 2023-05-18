//
//  TerminalHardwareProductRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation
import NIO
import NIOHTTP1

public protocol TerminalHardwareProductRoutes: StripeAPIRoute {
    /// Retrieves a TerminalHardwareProduct object.
    /// - Parameter product: Id of the hardware product
    /// - Returns: Returns a ``TerminalHardwareProduct`` object if a valid identifier was provided.
    func retrieve(product: String) async throws -> TerminalHardwareProduct
    
    /// List all ``TerminalHardwareProduct`` objects.
    /// - Parameter filter: A dictionary used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of terminal hardware products. Each entry in the array is a separate Product object.
    func listAll(filter: [String: Any]?) async throws -> TerminalHardwareProductList
}

public struct StripeTerminalHardwareProductRoutes: TerminalHardwareProductRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let terminalhardwareproducts = APIBase + APIVersion + "terminal/hardware_products"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(product: String) async throws -> TerminalHardwareProduct {
        try await apiHandler.send(method: .GET, path: "\(terminalhardwareproducts)/\(product)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TerminalHardwareProductList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: terminalhardwareproducts, query: queryParams, headers: headers)
    }
}
