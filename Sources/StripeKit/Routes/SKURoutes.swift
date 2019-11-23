//
//  SKURoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import NIO
import NIOHTTP1

public protocol SKURoutes {
    /// Creates a new SKU associated with a product.
    ///
    /// - Parameters:
    ///   - id: The identifier for the SKU. Must be unique. If not provided, an identifier will be randomly generated.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - inventory: Description of the SKU’s inventory.
    ///   - price: The cost of the item as a nonnegative integer in the smallest currency unit (that is, 100 cents to charge $1.00, or 100 to charge ¥100, Japanese Yen being a zero-decimal currency).
    ///   - product: The ID of the product this SKU is associated with. Must be a product with type `good`.
    ///   - active: Whether the SKU is available for purchase. Default to `true`.
    ///   - attributes: A dictionary of attributes and values for the attributes defined by the product. If, for example, a product’s attributes are `["size", "gender"]`, a valid SKU has the following dictionary of attributes: `{"size": "Medium", "gender": "Unisex"}`.
    ///   - image: The URL of an image for this SKU, meant to be displayable to the customer.
    ///   - metadata: A set of key-value pairs that you can attach to a SKU object. It can be useful for storing additional information about the SKU in a structured format.
    ///   - packageDimensions: The dimensions of this SKU for shipping purposes.
    /// - Returns: A `StripeSKU`.
    func create(id: String?,
                currency: StripeCurrency,
                inventory: [String: Any],
                price: Int,
                product: String,
                active: Bool?,
                attributes: [String]?,
                image: String?,
                metadata: [String: String]?,
                packageDimensions: [String: Any]?) -> EventLoopFuture<StripeSKU>
    
    /// Retrieves the details of an existing SKU. Supply the unique SKU identifier from either a SKU creation request or from the product, and Stripe will return the corresponding SKU information.
    ///
    /// - Parameter id: The identifier of the SKU to be retrieved.
    /// - Returns: A `StripeSKU`.
    func retrieve(id: String) -> EventLoopFuture<StripeSKU>
    
    /// Updates the specific SKU by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    /// Note that a SKU’s `attributes` are not editable. Instead, you would need to deactivate the existing SKU and create a new one with the new attribute values.
    ///
    /// - Parameters:
    ///   - id: The identifier of the SKU to be updated.
    ///   - active: Whether this SKU is available for purchase.
    ///   - attributes: A dictionary of attributes and values for the attributes defined by the product. When specified, `attributes` will partially update the existing attributes dictionary on the product, with the postcondition that a value must be present for each attribute key on the product.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - image: The URL of an image for this SKU, meant to be displayable to the customer.
    ///   - inventory: Description of the SKU’s inventory.
    ///   - metadata: A set of key-value pairs that you can attach to a SKU object. It can be useful for storing additional information about the SKU in a structured format.
    ///   - packageDimensions: The dimensions of this SKU for shipping purposes.
    ///   - price: The cost of the item as a positive integer in the smallest currency unit (that is, 100 cents to charge $1.00, or 100 to charge ¥100, Japanese Yen being a zero-decimal currency).
    ///   - product: The ID of the product that this SKU should belong to. The product must exist, have the same set of attribute names as the SKU’s current product, and be of type good.
    /// - Returns: A `StripeSKU`.
    func update(id: String,
                active: Bool?,
                attributes: [String]?,
                currency: StripeCurrency?,
                image: String?,
                inventory: [String: Any]?,
                metadata: [String: String]?,
                packageDimensions: [String: Any]?,
                price: Int?,
                product: String?) -> EventLoopFuture<StripeSKU>
    
    /// Returns a list of your SKUs. The SKUs are returned sorted by creation date, with the most recently created SKUs appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/skus/list)
    /// - Returns: A `StripeSKUList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeSKUList>
    
    /// Delete a SKU. Deleting a SKU is only possible until it has been used in an order.
    ///
    /// - Parameter id: The identifier of the SKU to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    func delete(id: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SKURoutes {
    public func create(id: String? = nil,
                       currency: StripeCurrency,
                       inventory: [String: Any],
                       price: Int,
                       product: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       image: String? = nil,
                       metadata: [String: String]? = nil,
                       packageDimensions: [String: Any]? = nil) -> EventLoopFuture<StripeSKU> {
        return create(id: id,
                          currency: currency,
                          inventory: inventory,
                          price: price,
                          product: product,
                          active: active,
                          attributes: attributes,
                          image: image,
                          metadata: metadata,
                          packageDimensions: packageDimensions)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeSKU> {
        return retrieve(id: id)
    }
    
    public func update(id: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       currency: StripeCurrency? = nil,
                       image: String? = nil,
                       inventory: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       packageDimensions: [String: Any]? = nil,
                       price: Int? = nil,
                       product: String? = nil) -> EventLoopFuture<StripeSKU> {
        return update(id: id,
                          active: active,
                          attributes: attributes,
                          currency: currency,
                          image: image,
                          inventory: inventory,
                          metadata: metadata,
                          packageDimensions: packageDimensions,
                          price: price,
                          product: product)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeSKUList> {
        return listAll(filter: filter)
    }
    
    public func delete(id: String) -> EventLoopFuture<StripeDeletedObject> {
        return delete(id: id)
    }
}

public struct StripeSKURoutes: SKURoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(id: String?,
                       currency: StripeCurrency,
                       inventory: [String: Any],
                       price: Int,
                       product: String,
                       active: Bool?,
                       attributes: [String]?,
                       image: String?,
                       metadata: [String: String]?,
                       packageDimensions: [String: Any]?) -> EventLoopFuture<StripeSKU> {
        var body: [String: Any] = ["currency": currency.rawValue,
                                   "price": price,
                                   "product": product]
        
        inventory.forEach { body["inventory[\($0)]"] = $1 }
        
        if let active = active {
            body["active"] = active
        }
        
        if let attributes = attributes {
            body["attributes"] = attributes
        }

        if let image = image {
            body["image"] = image
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let packageDimensions = packageDimensions {
            packageDimensions.forEach { body["package_dimensions[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.sku.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeSKU> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.skus(id).endpoint, headers: headers)
    }
    
    public func update(id: String,
                       active: Bool?,
                       attributes: [String]?,
                       currency: StripeCurrency?,
                       image: String?,
                       inventory: [String: Any]?,
                       metadata: [String: String]?,
                       packageDimensions: [String: Any]?,
                       price: Int?,
                       product: String?) -> EventLoopFuture<StripeSKU> {
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let attributes = attributes {
            body["attributes"] = attributes
        }
        
        if let currency = currency {
            body["currency"] = currency.rawValue
        }
        
        if let inventory = inventory {
            inventory.forEach { body["inventory[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let packageDimensions = packageDimensions {
            packageDimensions.forEach { body["package_dimensions[\($0)]"] = $1 }
        }
        
        if let price = price {
            body["price"] = price
        }
        
        if let product = product {
            body["product"] = product
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.skus(id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeSKUList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.sku.endpoint, query: queryParams, headers: headers)
    }
    
    public func delete(id: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.skus(id).endpoint, headers: headers)
    }
}
