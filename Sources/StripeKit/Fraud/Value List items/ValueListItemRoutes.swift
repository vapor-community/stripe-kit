//
//  ValueListItemRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import NIO
import NIOHTTP1

public protocol ValueListItemRoutes {
    /// Creates a new `ValueListItem` object, which is added to the specified parent value list.
    ///
    /// - Parameters:
    ///   - value: The value of the item (whose type must match the type of the parent value list).
    ///   - valueList: The identifier of the value list which the created item will be added to.
    /// - Returns: A `StripeValueListItem`.
    func create(value: String, valueList: String) -> EventLoopFuture<StripeValueListItem>
    
    /// Retrieves a `ValueListItem` object.
    ///
    /// - Parameter item: The identifier of the value list item to be retrieved.
    /// - Returns: A `StripeValueListItem`.
    func retrieve(item: String) -> EventLoopFuture<StripeValueListItem>
    
    /// Deletes a `ValueListItem` object, removing it from its parent value list.
    ///
    /// - Parameter item: The identifier of the value list item to be deleted.
    /// - Returns: A `StripeValueListItem`.
    func delete(item: String) -> EventLoopFuture<DeletedObject>
    
    /// Returns a list of `ValueListItem` objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/radar/value_list_items/list).
    /// - Returns: A `StripeValueListItemList`.
    func listAll(valueList: String, filter: [String: Any]?) -> EventLoopFuture<StripeValueListItemList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ValueListItemRoutes {
    func create(value: String, valueList: String) -> EventLoopFuture<StripeValueListItem> {
        return create(value: value, valueList: valueList)
    }
    
    func retrieve(item: String) -> EventLoopFuture<StripeValueListItem> {
        return retrieve(item: item)
    }
    
    func delete(item: String) -> EventLoopFuture<DeletedObject> {
        return delete(item: item)
    }
    
    func listAll(valueList: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeValueListItemList> {
        return listAll(valueList: valueList, filter: filter)
    }
}

public struct StripeValueListItemRoutes: ValueListItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let valuelistitems = APIBase + APIVersion + "radar/value_list_items"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(value: String, valueList: String) -> EventLoopFuture<StripeValueListItem> {
        let body = ["value": value, "value_list": valueList]
        return apiHandler.send(method: .POST, path: valuelistitems, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(item: String) -> EventLoopFuture<StripeValueListItem> {
        return apiHandler.send(method: .GET, path: "\(valuelistitems)/\(item)", headers: headers)
    }
    
    public func delete(item: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(valuelistitems)/\(item)", headers: headers)
    }
    
    public func listAll(valueList: String, filter: [String: Any]?) -> EventLoopFuture<StripeValueListItemList> {
        var queryParams = "value_list=\(valueList)"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: valuelistitems, query: queryParams, headers: headers)
    }
}
