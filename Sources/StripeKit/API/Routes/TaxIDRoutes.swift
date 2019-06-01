//
//  TaxIDRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

import NIO
import NIOHTTP1

public protocol TaxIDRoutes {
    /// Creates a new `TaxID` object for a customer.
    ///
    /// - Parameters:
    ///   - customer: ID of the customer.
    ///   - type: Type of the tax ID, one of `eu_vat`, `nz_gst`, or `au_abn`
    ///   - value: Value of the tax ID.
    /// - Returns: A `StripeTaxID`.
    /// - Throws: A `StripeError`.
    func create(customer: String, type: StripeTaxIDType, value: String) throws -> EventLoopFuture<StripeTaxID>
    
    /// Retrieves the TaxID object with the given identifier.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the TaxID object to retrieve.
    ///   - customer: ID of the customer.
    /// - Returns: A `StripeTaxID`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeTaxID>
    
    /// Deletes an existing TaxID object.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the `TaxID` object to delete.
    ///   - customer: ID of the customer.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of tax IDs for a customer.
    ///
    /// - Parameters:
    ///   - customer: ID of the customer whose tax IDs will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/customer_tax_ids/list).
    /// - Returns: A `StripeTaxIDList`.
    /// - Throws: A `StripeError`.
    func listAll(customer: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeTaxIDList>
    
    var headers: HTTPHeaders { get set }
}

public struct StripeTaxIDRoutes: TaxIDRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, type: StripeTaxIDType, value: String) throws -> EventLoopFuture<StripeTaxID> {
        let body: [String: Any] = ["type": type.rawValue,
                                   "value": value]
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.taxid(customer).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeTaxID> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.taxids(customer, id).endpoint, headers: headers)
    }
    
    public func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.taxids(customer, id).endpoint, headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeTaxIDList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.taxid(customer).endpoint, query: queryParams, headers: headers)
    }
}
