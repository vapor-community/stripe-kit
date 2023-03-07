//
//  EventRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/27/19.
//

import NIO
import NIOHTTP1

public protocol EventRoutes: StripeAPIRoute {
    /// Retrieves the details of an event. Supply the unique identifier of the event, which you might have received in a webhook.
    /// - Parameter id: The identifier of the event to be retrieved.
    /// - Returns: Returns an event object if a valid identifier was provided. All events share a common structure, detailed to the right. The only property that will differ is the data property.
    /// In each case, the data dictionary will have an attribute called object and its value will be the same as retrieving the same object directly from the API. For example, a customer.created event will have the same information as retrieving the relevant customer would. In cases where the attributes of an object have changed, data will also contain a dictionary containing the changes.
    func retrieve(id: String) async throws -> Event
    
    /// List events, going back up to 30 days. Each event data is rendered according to Stripe API version at its creation time, specified in event object `api_version` attribute (not according to your current Stripe API version or `Stripe-Version` header).
    /// - Parameter filter: A dictionary that contains the filters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` events, starting after event `starting_after`. Each entry in the array is a separate event object. If no more events are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> EventList
}

public struct StripeEventRoutes: EventRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let events = APIBase + APIVersion + "events"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) async throws -> Event {
        try await apiHandler.send(method: .GET, path: "\(events)/\(id)", headers: headers)
    }
    
    public func listAll(filter: [String : Any]?) async throws -> EventList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: events, query: queryParams, headers: headers)
    }
}
