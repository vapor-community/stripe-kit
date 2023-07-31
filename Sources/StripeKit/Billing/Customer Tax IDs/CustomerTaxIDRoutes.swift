//
//  CustomerTaxIDRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

import NIO
import NIOHTTP1

public protocol CustomerTaxIDRoutes: StripeAPIRoute {
    /// Creates a new `TaxID` object for a customer.
    ///
    /// - Parameters:
    ///   - customer: ID of the customer.
    ///   - type: Type of the tax ID.
    ///   - value: Value of the tax ID.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: The created ``TaxID`` object.
    func create(customer: String,
                type: TaxIDType,
                value: String,
                expand: [String]?) async throws -> TaxID
    
    /// Retrieves the TaxID object with the given identifier.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the TaxID object to retrieve.
    ///   - customer: ID of the customer.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a ``TaxID`` object if a valid identifier was provided.
    func retrieve(id: String, customer: String, expand: [String]?) async throws -> TaxID
    
    /// Deletes an existing TaxID object.
    ///
    /// - Parameters:
    ///   - id: Unique identifier of the `TaxID` object to delete.
    ///   - customer: ID of the customer.
    /// - Returns: Returns an object with a deleted parameter on success. If the TaxID object does not exist, this call returns an error.
    func delete(id: String, customer: String) async throws -> DeletedObject
    
    /// Returns a list of tax IDs for a customer.
    ///
    /// - Parameters:
    ///   - customer: ID of the customer whose tax IDs will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/customer_tax_ids/list) .
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` tax IDs, starting after tax ID `starting_after`. Each entry in the array is a separate `TaxID` object. If no more tax IDs are available, the resulting array will be empty. Returns an error if the customer ID is invalid.
    func listAll(customer: String, filter: [String: Any]?) async throws -> TaxIDList
}

public struct StripeCustomerTaxIDRoutes: CustomerTaxIDRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let taxids = APIBase + APIVersion + "customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, type: TaxIDType, value: String, expand: [String]? = nil) async throws -> TaxID {
        var body: [String: Any] = ["type": type.rawValue,
                                   "value": value]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(taxids)/\(customer)/tax_ids", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, customer: String, expand: [String]? = nil) async throws -> TaxID {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(taxids)/\(customer)/tax_ids/\(id)", query: queryParams, headers: headers)
    }
    
    public func delete(id: String, customer: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(taxids)/\(customer)/tax_ids/\(id)", headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) async throws -> TaxIDList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(taxids)/\(customer)/tax_ids", query: queryParams, headers: headers)
    }
}
