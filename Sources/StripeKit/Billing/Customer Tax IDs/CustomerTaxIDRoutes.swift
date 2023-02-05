//
//  CustomerTaxIDRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

import NIO
import NIOHTTP1

public protocol CustomerTaxIDRoutes {
    /// Creates a new `TaxID` object for a customer.
    ///
    /// - Parameters:
    ///   - customer: ID of the customer.
    ///   - type: Type of the tax ID, one of `eu_vat`, `nz_gst`, or `au_abn`
    ///   - value: Value of the tax ID.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTaxID`.
    func create(customer: String,
                type: StripeTaxIDType,
                value: String,
                expand: [String]?) -> EventLoopFuture<StripeTaxID>
    
    /// Retrieves the TaxID object with the given identifier.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the TaxID object to retrieve.
    ///   - customer: ID of the customer.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTaxID`.
    func retrieve(id: String, customer: String, expand: [String]?) -> EventLoopFuture<StripeTaxID>
    
    /// Deletes an existing TaxID object.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the `TaxID` object to delete.
    ///   - customer: ID of the customer.
    /// - Returns: A `StripeDeletedObject`.
    func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject>
    
    /// Returns a list of tax IDs for a customer.
    ///
    /// - Parameters:
    ///   - customer: ID of the customer whose tax IDs will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/customer_tax_ids/list).
    /// - Returns: A `StripeTaxIDList`.
    func listAll(customer: String, filter: [String: Any]?) -> EventLoopFuture<StripeTaxIDList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct StripeCustomerTaxIDRoutes: CustomerTaxIDRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let taxids = APIBase + APIVersion + "customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, type: StripeTaxIDType, value: String, expand: [String]?) -> EventLoopFuture<StripeTaxID> {
        var body: [String: Any] = ["type": type.rawValue,
                                   "value": value]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(taxids)/\(customer)/tax_ids", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, customer: String, expand: [String]?) -> EventLoopFuture<StripeTaxID> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(taxids)/\(customer)/tax_ids/\(id)", query: queryParams, headers: headers)
    }
    
    public func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(taxids)/\(customer)/tax_ids/\(id)", headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeTaxIDList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(taxids)/\(customer)/tax_ids", query: queryParams, headers: headers)
    }
}
