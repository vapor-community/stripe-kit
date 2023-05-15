//
//  ValueListRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import NIO
import NIOHTTP1

public protocol ValueListRoutes: StripeAPIRoute {
    /// Creates a new `ValueList` object, which can then be referenced in rules.
    ///
    /// - Parameters:
    ///   - alias: The name of the value list for use in rules.
    ///   - name: The human-readable name of the value list.
    ///   - itemType: Type of the items in the value list. One of `card_fingerprint`, `card_bin`, `email`, `ip_address`, `country`, `string`, or`case_sensitive_string`. Use string if the item type is unknown or mixed.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: Returns a ValueList object if creation succeeds.
    func create(alias: String, name: String, itemType: ValueListItemType?, metadata: [String: String]?) async throws -> ValueList
    
    /// Retrieves a `ValueList` object.
    ///
    /// - Parameter valueList: The identifier of the value list to be retrieved.
    /// - Returns: Returns a ValueList object if a valid identifier was provided.
    func retrieve(valueList: String) async throws -> ValueList
    
    /// Updates a `ValueList` object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Note that `item_type` is immutable.
    ///
    /// - Parameters:
    ///   - valueList: The identifier of the value list to be updated.
    ///   - alias: The name of the value list for use in rules.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - name: The human-readable name of the value list.
    /// - Returns: Returns an updated ValueList object if a valid identifier was provided.
    func update(valueList: String, alias: String?, metadata: [String: String]?, name: String?) async throws -> ValueList
    
    /// Deletes a `ValueList` object, also deleting any items contained within the value list. To be deleted, a value list must not be referenced in any rules.
    ///
    /// - Parameter valueList: The identifier of the value list to be deleted.
    /// - Returns: Returns an object with the deleted ValueList object’s ID and a deleted parameter on success. Otherwise, this call returns an error.
    func delete(valueList: String) async throws -> DeletedObject
    
    /// Returns a list of `ValueList` objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/radar/value_lists/list)
    /// - Returns: A `StripeValueListList`
    func listAll(filter: [String: Any]?) async throws -> ValueListList
}

public struct StripeValueListRoutes: ValueListRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let valuelists = APIBase + APIVersion + "radar/value_lists"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(alias: String,
                       name: String,
                       itemType: ValueListItemType? = nil,
                       metadata: [String: String]? = nil) async throws -> ValueList {
        var body: [String: Any] = ["alias": alias,
                                   "name": name]
        
        if let itemType {
            body["item_type"] = itemType.rawValue
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: valuelists, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(valueList: String) async throws -> ValueList {
        try await apiHandler.send(method: .GET, path: "\(valuelists)/\(valueList)", headers: headers)
    }
    
    public func update(valueList: String,
                       alias: String? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil) async throws -> ValueList {
        var body: [String: Any] = [:]
        
        if let alias {
            body["alias"] = alias
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name {
            body["name"] = name
        }
        
        return try await apiHandler.send(method: .POST, path: "\(valuelists)/\(valueList)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(valueList: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(valuelists)/\(valueList)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> ValueListList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: valuelists, query: queryParams, headers: headers)
    }
}
