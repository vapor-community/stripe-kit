//
//  ValueListItemRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import NIO
import NIOHTTP1

public protocol ValueListItemRoutes: StripeAPIRoute {
    /// Creates a new `ValueListItem` object, which is added to the specified parent value list.
    ///
    /// - Parameters:
    ///   - value: The value of the item (whose type must match the type of the parent value list).
    ///   - valueList: The identifier of the value list which the created item will be added to.
    /// - Returns: A `StripeValueListItem`.
    func create(value: String, valueList: String) async throws -> ValueListItem
    
    /// Retrieves a `ValueListItem` object.
    ///
    /// - Parameter item: The identifier of the value list item to be retrieved.
    /// - Returns: A `StripeValueListItem`.
    func retrieve(item: String) async throws -> ValueListItem
    
    /// Deletes a `ValueListItem` object, removing it from its parent value list.
    ///
    /// - Parameter item: The identifier of the value list item to be deleted.
    /// - Returns: A `StripeValueListItem`.
    func delete(item: String) async throws -> DeletedObject
    
    /// Returns a list of `ValueListItem` objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/radar/value_list_items/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` items, starting after item `starting_after`. Each entry in the array is a separate ValueListItem object. If no more items are available, the resulting array will be empty.
    func listAll(valueList: String, filter: [String: Any]?) async throws -> ValueListItemList
}

public struct StripeValueListItemRoutes: ValueListItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let valuelistitems = APIBase + APIVersion + "radar/value_list_items"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(value: String, valueList: String) async throws -> ValueListItem {
        let body = ["value": value, "value_list": valueList]
        return try await apiHandler.send(method: .POST, path: valuelistitems, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(item: String) async throws -> ValueListItem {
        try await apiHandler.send(method: .GET, path: "\(valuelistitems)/\(item)", headers: headers)
    }
    
    public func delete(item: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(valuelistitems)/\(item)", headers: headers)
    }
    
    public func listAll(valueList: String, filter: [String: Any]?) async throws -> ValueListItemList {
        var queryParams = "value_list=\(valueList)"
        if let filter {
            queryParams += "&" + filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: valuelistitems, query: queryParams, headers: headers)
    }
}
