//
//  TaxCodeRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/16/21.
//

import NIO
import NIOHTTP1

public protocol TaxCodeRoutes: StripeAPIRoute {
    /// Retrieves the details of an existing tax code. Supply the unique tax code ID and Stripe will return the corresponding tax code information.
    ///  - Parameter id: The id of the tax code to retrieve.
    /// - Returns: Returns a tax code object if a valid identifier was provided.
    func retrieve(id: String) async throws -> TaxCode
    
    /// A list of all tax codes available to add to Products in order to allow specific tax calculations.
    /// - Parameter filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/tax_codes/list)
    func listAll(filter: [String: Any]?) async throws -> TaxCodeList
}

public struct StripeTaxCodeRoutes: TaxCodeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let taxcodes = APIBase + APIVersion + "tax_codes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) async throws -> TaxCode {
        try await apiHandler.send(method: .GET, path: "\(taxcodes)/\(id)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TaxCodeList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: taxcodes, query: queryParams, headers: headers)
    }
}
