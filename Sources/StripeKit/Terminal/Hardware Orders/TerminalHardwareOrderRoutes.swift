//
//  TerminalHardwareOrderRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation
import NIO
import NIOHTTP1

public protocol TerminalHardwareOrderRoutes: StripeAPIRoute {
    /// Get a preview of a ``TerminalHardwareOrder`` without creating it.
    /// - Parameters:
    ///   - hardwareOrderItems: An array of line items to order.
    ///   - paymentType: The method of payment for this order.
    ///   - shipping: Shipping address for the order.
    ///   - shippingMethod: The Shipping Method for the order
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object (that has not been created) if the preview succeeds.
    func preview(hardwareOrderItems: [[String: Any]],
                 paymentType: TerminalHardwareOrderPaymentType,
                 shipping: [String: Any],
                 shippingMethod: String,
                 metadata: [String: String]?) async throws -> TerminalHardwareOrder
    
    /// Creates a new ``TerminalHardwareOrder`` object.
    /// - Parameters:
    ///   - hardwareOrderItems: An array of line items to order.
    ///   - paymentType: The method of payment for this order.
    ///   - shipping: Shipping address for the order.
    ///   - shippingMethod: The Shipping Method for the order
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object if creation succeeds.
    func create(hardwareOrderItems: [[String: Any]],
                paymentType: TerminalHardwareOrderPaymentType,
                shipping: [String: Any],
                shippingMethod: String,
                metadata: [String: String]?) async throws -> TerminalHardwareOrder
    
    /// Retrieves a ``TerminalHardwareOrder`` object.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object if a valid identifier was provided.
    func retrieve(order: String) async throws -> TerminalHardwareOrder
    
    /// List all ``TerminalHardwareOrder`` objects.
    /// - Parameter filter: A dictionary used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of terminal hardware orders. Each entry in the array is a separate order object.
    func listAll(filter: [String: Any]?) async throws -> TerminalHardwareOrderList
    
    /// Confirms a draft ``TerminalHardwareOrder``. This places the order so it is no longer a draft.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object if confirmation succeeds.
    func confirmDraftOrder(order: String) async throws -> TerminalHardwareOrder
    
    /// Sets the status of a terminal hardware order from `pending` to `canceled`.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns the ``TerminalHardwareOrder`` object.
    func cancelOrder(order: String) async throws -> TerminalHardwareOrder
    
    /// Updates a test mode TerminalHardwareOrder object’s status as `ready_to_ship`.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object.
    func testMarkReadyToShip(order: String) async throws -> TerminalHardwareOrder
    
    /// Updates a test mode ``TerminalHardwareOrder`` object’s status as `shipped`.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object.
    func testMarkShipped(order: String) async throws -> TerminalHardwareOrder
    
    /// Updates a test mode ``TerminalHardwareOrder`` object’s status as `delivered`.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object.
    func testMarkDelivered(order: String) async throws -> TerminalHardwareOrder
    
    /// Updates a test mode ``TerminalHardwareOrder`` object’s status as `undeliverable`.
    /// - Parameter order: The id of the hardware order.
    /// - Returns: Returns a ``TerminalHardwareOrder`` object.
    func testMarkUndeliverable(order: String) async throws -> TerminalHardwareOrder
}

public struct StripeTerminalHardwareOrderRoutes: TerminalHardwareOrderRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let terminalhardwareorders = APIBase + APIVersion + "terminal/hardware_orders"
    private let testhelpers = APIBase + APIVersion + "test_helpers/terminal/hardware_orders"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func preview(hardwareOrderItems: [[String: Any]],
                        paymentType: TerminalHardwareOrderPaymentType,
                        shipping: [String: Any],
                        shippingMethod: String,
                        metadata: [String: String]? = nil) async throws -> TerminalHardwareOrder {
        var body: [String: Any] = ["hardware_order_items": hardwareOrderItems,
                                   "payment_type": paymentType.rawValue,
                                   "shipping_method": shippingMethod]
        
        shipping.forEach { body["shipping[\($0)]"] = $1 }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .GET, path: "\(terminalhardwareorders)/preview", query: body.queryParameters, headers: headers)
    }
    
    public func create(hardwareOrderItems: [[String: Any]],
                       paymentType: TerminalHardwareOrderPaymentType,
                       shipping: [String: Any],
                       shippingMethod: String,
                       metadata: [String: String]? = nil) async throws -> TerminalHardwareOrder {
        var body: [String: Any] = ["hardware_order_items": hardwareOrderItems,
                                   "payment_type": paymentType.rawValue,
                                   "shipping_method": shippingMethod]
        
        shipping.forEach { body["shipping[\($0)]"] = $1 }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: "\(terminalhardwareorders)/preview", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .GET, path: "\(terminalhardwareorders)/\(order)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TerminalHardwareOrderList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: terminalhardwareorders, query: queryParams, headers: headers)
    }
    
    public func confirmDraftOrder(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .POST, path: "\(terminalhardwareorders)/\(order)/confirm", headers: headers)
    }
    
    public func cancelOrder(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .POST, path: "\(terminalhardwareorders)/\(order)/cancel", headers: headers)
    }
    
    public func testMarkReadyToShip(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(order)/mark_ready_to_ship", headers: headers)
    }
    
    public func testMarkShipped(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(order)/ship", headers: headers)
    }
    
    public func testMarkDelivered(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(order)/deliver", headers: headers)
    }
    
    public func testMarkUndeliverable(order: String) async throws -> TerminalHardwareOrder {
        try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(order)/mark_undeliverable", headers: headers)
    }
}
