//
//  DiscountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol DiscountRoutes {
    /// Removes the currently applied discount on a customer.
    ///
    /// - Parameter customer: The id of the customer this discount belongs to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(customer: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject>
    
    /// Removes the currently applied discount on a subscription.
    ///
    /// - Parameter subscription: The id of the subscription this discount was applied to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(subscription: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct StripeDiscountRoutes: DiscountRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customers = APIBase + APIVersion + "customers"
    private let subscriptions = APIBase + APIVersion + "subscriptions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func delete(customer: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(customers)/\(customer)/discount", headers: headers, context: context)
    }
    
    public func delete(subscription: String, context: LoggingContext) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(subscriptions)/\(subscription)/discount", headers: headers, context: context)
    }
}
