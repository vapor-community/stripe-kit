//
//  OrderRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import NIO
import NIOHTTP1

public protocol OrderRoutes {
    /// Creates a new order object.
    ///
    /// - Parameters:
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - coupon: A coupon code that represents a discount to be applied to this order. Must be one-time duration and in same currency as the order.
    ///   - customer: The ID of an existing customer to use for this order. If provided, the customer email and shipping address will be used to create the order. Subsequently, the customer will also be charged to pay the order. If `email` or `shipping` are also provided, they will override the values retrieved from the customer object.
    ///   - email: The email address of the customer placing the order.
    ///   - items: List of items constituting the order. An order can have up to 25 items.
    ///   - metadata: A set of key-value pairs that you can attach to an order object. Limited to 500 characters. Metadata can be useful for storing additional information about the order in a structured format.
    ///   - shipping: Shipping address for the order. Required if any of the SKUs are for products that have shippable set to true.
    /// - Returns: A `StripeOrder`.
    func create(currency: StripeCurrency,
                coupon: String?,
                customer: String?,
                email: String?,
                items: [[String: Any]]?,
                metadata: [String: String]?,
                shipping: [String: Any]?) -> EventLoopFuture<StripeOrder>
    
    /// Retrieves the details of an existing order. Supply the unique order ID from either an order creation request or the order list, and Stripe will return the corresponding order information.
    ///
    /// - Parameter id: The identifier of the order to be retrieved.
    /// - Returns: A `StripeOrder`.
    func retrieve(id: String) -> EventLoopFuture<StripeOrder>
    
    /// Updates the specific order by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - id: The identifier of the order to be updated.
    ///   - coupon: A coupon code that represents a discount to be applied to this order. Must be one-time duration and in same currency as the order.
    ///   - metadata: A set of key-value pairs that you can attach to a product object. It can be useful for storing additional information about the order in a structured format.
    ///   - selectedShippingMethod: The shipping method to select for fulfilling this order. If specified, must be one of the ids of a shipping method in the shipping_methods array. If specified, will overwrite the existing selected shipping method, updating items as necessary.
    ///   - shipping: Tracking information once the order has been fulfilled.
    ///   - status: Current order status. One of `created`, `paid`, `canceled`, `fulfilled`, or `returned`. More detail in the [Orders Guide](https://stripe.com/docs/orders/guide#understanding-order-statuses).
    /// - Returns: A `StripeOrder`.
    func update(id: String,
                coupon: String?,
                metadata: [String: String]?,
                selectedShippingMethod: String?,
                shipping: [String: Any]?,
                status: StripeOrderStatus?) -> EventLoopFuture<StripeOrder>
    
    /// Pay an order by providing a source to create a payment.
    ///
    /// - Parameters:
    ///   - id: The identifier of the order to be payed.
    ///   - customer: The ID of an existing customer that will be charged in this request.
    ///   - source: A payment source to be charged, such as a credit card. If you also pass a customer ID, the source must be the ID of a source belonging to the customer (e.g., a saved card). Otherwise, if you do not pass a customer ID, the source you provide must be a token, like the ones returned by Stripe.js.
    ///   - applicationFee: A fee in cents that will be applied to the order and transferred to the application owner's Stripe account. To use an application fee, the request must be made on behalf of another account, using the `Stripe-Account` header, an OAuth key, or the `destination` parameter. For more information, see [Collecting application fees](https://stripe.com/docs/connect/direct-charges#collecting-fees).
    ///   - email: The email address of the customer placing the order. If a `customer` is specified, that customer's email address will be used.
    ///   - metadata: A set of key-value pairs that you can attach to an order object. Limited to 500 characters. Metadata can be useful for storing additional information about the order in a structured format.
    /// - Returns: A `StripeOrder`.
    func pay(id: String,
             customer: String?,
             source: Any?,
             applicationFee: Int?,
             email: String?,
             metadata: [String: String]?) -> EventLoopFuture<StripeOrder>
    
    /// Returns a list of your orders. The orders are returned sorted by creation date, with the most recently created orders appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/orders/list)
    /// - Returns: A `StripeOrderList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeOrderList>
    
    /// Return all or part of an order. The order must have a status of paid or fulfilled before it can be returned. Once all items have been returned, the order will become canceled or returned depending on which status the order started in.
    ///
    /// - Parameters:
    ///   - id: The identifier of the order to be returned.
    ///   - items: List of items to return.
    /// - Returns: A `StripeOrder`.
    func `return`(id: String, items: [[String: Any]]?) -> EventLoopFuture<StripeOrder>
    
    var headers: HTTPHeaders { get set }
}

extension OrderRoutes {
    public func create(currency: StripeCurrency,
                       coupon: String? = nil,
                       customer: String? = nil,
                       email: String? = nil,
                       items: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       shipping: [String: Any]? = nil) -> EventLoopFuture<StripeOrder> {
        return create(currency: currency,
                          coupon: coupon,
                          customer: customer,
                          email: email,
                          items: items,
                          metadata: metadata,
                          shipping: shipping)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeOrder> {
        return retrieve(id: id)
    }
    
    public func update(id: String,
                       coupon: String? = nil,
                       metadata: [String: String]? = nil,
                       selectedShippingMethod: String? = nil,
                       shipping: [String: Any]? = nil,
                       status: StripeOrderStatus? = nil) -> EventLoopFuture<StripeOrder> {
        return update(id: id,
                          coupon: coupon,
                          metadata: metadata,
                          selectedShippingMethod: selectedShippingMethod,
                          shipping: shipping,
                          status: status)
    }
    
    public func pay(id: String,
                    customer: String? = nil,
                    source: Any? = nil,
                    applicationFee: Int? = nil,
                    email: String? = nil,
                    metadata: [String: String]? = nil) -> EventLoopFuture<StripeOrder> {
        return pay(id: id,
                       customer: customer,
                       source: source,
                       applicationFee: applicationFee,
                       email: email,
                       metadata: metadata)
    }
    
    public func listAll(filter: [String : Any]? = nil) -> EventLoopFuture<StripeOrderList> {
        return listAll(filter: filter)
    }
    
    public func `return`(id: String, items: [[String: Any]]? = nil) -> EventLoopFuture<StripeOrder> {
        return `return`(id: id, items: items)
    }
}

public struct StripeOrderRoutes: OrderRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(currency: StripeCurrency,
                       coupon: String?,
                       customer: String?,
                       email: String?,
                       items: [[String: Any]]?,
                       metadata: [String: String]?,
                       shipping: [String: Any]?) -> EventLoopFuture<StripeOrder> {
        var body: [String: Any] = [:]
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let items = items {
            body["items"] = items
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.order.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeOrder> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.orders(id).endpoint, headers: headers)
    }
    
    public func update(id: String,
                       coupon: String?,
                       metadata: [String: String]?,
                       selectedShippingMethod: String?,
                       shipping: [String: Any]?,
                       status: StripeOrderStatus?) -> EventLoopFuture<StripeOrder> {
        var body: [String: Any] = [:]
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let selectedShippingMethod = selectedShippingMethod {
            body["selected_shipping_method"] = selectedShippingMethod
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let status = status {
            body["status"] = status.rawValue
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.orders(id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func pay(id: String,
                    customer: String?,
                    source: Any?,
                    applicationFee: Int?,
                    connectAccount: String?,
                    email: String?,
                    metadata: [String: String]?) -> EventLoopFuture<StripeOrder> {
        var body: [String: Any] = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let applicationfee = applicationFee {
            body["application_fee"] = applicationfee
        }

        if let email = email {
            body["email"] = email
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.ordersPay(id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeOrderList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.order.endpoint, query: queryParams, headers: headers)
    }

    public func `return`(id: String, items: [[String: Any]]?) -> EventLoopFuture<StripeOrder> {
        var body: [String: Any] = [:]
        
        if let items = items {
            body["items"] = items
        }

        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.ordersReturn(id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
}
