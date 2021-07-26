//
//  EventRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/27/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol EventRoutes {
    /// Retrieves the details of an event. Supply the unique identifier of the event, which you might have received in a webhook.
    /// - Parameter id: The identifier of the event to be retrieved.
    func retrieve(id: String, context: LoggingContext) -> EventLoopFuture<StripeEvent>
    
    /// List events, going back up to 30 days. Each event data is rendered according to Stripe API version at its creation time, specified in event object `api_version` attribute (not according to your current Stripe API version or `Stripe-Version` header).
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/events/list)
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeEventList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension EventRoutes {
    func retrieve(id: String, context: LoggingContext) -> EventLoopFuture<StripeEvent> {
        return retrieve(id: id)
    }
    
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeEventList> {
        return listAll(filter: filter)
    }
}

public struct StripeEventRoutes: EventRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let events = APIBase + APIVersion + "events"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String, context: LoggingContext) -> EventLoopFuture<StripeEvent> {
        return apiHandler.send(method: .GET, path: "\(events)/\(id)", headers: headers)
    }
    
    public func listAll(filter: [String : Any]?, context: LoggingContext) -> EventLoopFuture<StripeEventList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: events, query: queryParams, headers: headers)
    }
}
