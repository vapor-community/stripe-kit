//
//  TaxCodeRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/16/21.
//

import NIO
import NIOHTTP1

public protocol TaxCodeRoutes {
    /// Retrieves the details of an existing tax code. Supply the unique tax code ID and Stripe will return the corresponding tax code information.
    ///  - Parameter id: The id of the tax code to retrieve.
    /// - Returns: A `StripeTaxCode`
    func retrieve(id: String) -> EventLoopFuture<StripeTaxCode>
    
    /// Returns a list of TaxCodes
    /// - Parameter filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/tax_codes/list)
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeTaxCodeList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension TaxCodeRoutes {
    public func retrieve(id: String) -> EventLoopFuture<StripeTaxCode> {
        retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeTaxCodeList> {
        listAll(filter: filter)
    }
}

public struct StripeTaxCodeRoutes: TaxCodeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let taxcodes = APIBase + APIVersion + "tax_codes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeTaxCode> {
        apiHandler.send(method: .GET, path: "\(taxcodes)/\(id)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeTaxCodeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: taxcodes, query: queryParams, headers: headers)
    }
}

