//
//  ProductRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import NIO
import NIOHTTP1

public protocol ProductRoutes {
    /// Creates a new product object. To create a product for use with subscriptions, see [Subscriptions Products](https://stripe.com/docs/api/products/create#create_service_product).
    ///
    /// - Parameters:
    ///   - id: An identifier will be randomly generated by Stripe. You can optionally override this ID, but the ID must be unique across all products in your Stripe account. Applicable to both `service` and `good` types.
    ///   - name: The product’s name, meant to be displayable to the customer. Applicable to both `service` and `good` types.
    ///   - active: Whether the product is currently available for purchase. Defaults to `true`.
    ///   - attributes: A list of up to 5 alphanumeric attributes. Applicable to both `service` and `good` types.
    ///   - caption: A short one-line description of the product, meant to be displayable to the customer. May only be set if type=good`.
    ///   - deactivateOn: An array of Connect application names or identifiers that should not be able to order the SKUs for this product. May only be set if `type=good`.
    ///   - description: The product’s description, meant to be displayable to the customer. May only be set if `type=good`.
    ///   - images: A list of up to 8 URLs of images for this product, meant to be displayable to the customer. May only be set if `type=good`.
    ///   - metadata: A set of key-value pairs that you can attach to a product object. It can be useful for storing additional information about the product in a structured format. Applicable to both `service` and `good` types.
    ///   - packageDimensions: The dimensions of this product for shipping purposes. A SKU associated with this product can override this value by having its own `package_dimensions`. May only be set if `type=good`.
    ///   - shippable: Whether this product is shipped (i.e., physical goods). Defaults to `true`. May only be set if `type=good`.
    ///   - taxCode: A tax code ID.
    ///   - type: The type of the product. The product is either of type `service`, which is eligible for use with Subscriptions and Plans or `good`, which is eligible for use with Orders and SKUs.
    ///   - url: A URL of a publicly-accessible webpage for this product. May only be set if `type=good`.
    /// - Returns: A `StripeProduct`.
    func create(id: String?,
                name: String,
                active: Bool?,
                attributes: [String]?,
                caption: String?,
                deactivateOn: [String]?,
                description: String?,
                images: [String]?,
                metadata: [String: String]?,
                packageDimensions: [String: Any]?,
                shippable: Bool?,
                taxCode: String?,
                type: StripeProductType?,
                url: String?) -> EventLoopFuture<StripeProduct>
    
    /// Retrieves the details of an existing product. Supply the unique product ID from either a product creation request or the product list, and Stripe will return the corresponding product information.
    ///
    /// - Parameter id: The identifier of the product to be retrieved.
    /// - Returns: A `StripeProduct`.
    func retrieve(id: String) -> EventLoopFuture<StripeProduct>
    
    /// Updates the specific product by setting the values of the parameters passed. Any parameters not provided will be left unchanged. /n Note that a product’s `attributes` are not editable. Instead, you would need to deactivate the existing product and create a new one with the new attribute values.
    ///
    /// - Parameters:
    ///   - product: The identifier of the product to be updated.
    ///   - active: Whether the product is available for purchase.
    ///   - attributes: A list of up to 5 alphanumeric attributes that each SKU can provide values for (e.g., `["color", "size"]`). If a value for attributes is specified, the list specified will replace the existing `attributes` list on this product. Any attributes not present after the update will be deleted from the SKUs for this product.
    ///   - caption: A short one-line description of the product, meant to be displayable to the customer.
    ///   - deactivateOn: An array of Connect application names or identifiers that should not be able to order the SKUs for this product. This will be unset if you POST an empty value.
    ///   - description: The product’s description, meant to be displayable to the customer.
    ///   - images: A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
    ///   - metadata: A set of key-value pairs that you can attach to a product object. It can be useful for storing additional information about the product in a structured format.
    ///   - name: The product’s name, meant to be displayable to the customer. Applicable to both `service` and `good` types.
    ///   - packageDimensions: The dimensions of this product for shipping purposes. A SKU associated with this product can override this value by having its own `package_dimensions`.
    ///   - shippable: Whether this product is shipped (i.e., physical goods). Defaults to `true`.
    ///   - statementDescriptor: An arbitrary string to be displayed on your customer’s credit card statement. This may be up to 22 characters. The statement description may not include <>”’ characters, and will appear on your customer’s statement in capital letters. Non-ASCII characters are automatically stripped. While most banks display this information consistently, some may display it incorrectly or not at all. It must contain at least one letter. May only be set if `type=service`.
    ///   - taxCode: A tax code ID.
    ///   - unitLabel: A label that represents units of this product, such as seat(s), in Stripe and on customers’ receipts and invoices. Only available on products of `type=service`. This will be unset if you POST an empty value.
    ///   - url: A URL of a publicly-accessible webpage for this product. This will be unset if you POST an empty value.
    /// - Returns: A `StripeProduct`.
    func update(product: String,
                active: Bool?,
                attributes: [String]?,
                caption: String?,
                deactivateOn: [String]?,
                description: String?,
                images: [String]?,
                metadata: [String: String]?,
                name: String?,
                packageDimensions: [String: Any]?,
                shippable: Bool?,
                statementDescriptor: String?,
                taxCode: String?,
                unitLabel: String?,
                url: String?) -> EventLoopFuture<StripeProduct>
    
    /// Returns a list of your products. The products are returned sorted by creation date, with the most recently created products appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/products/list)
    /// - Returns: A `StripeProductsList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeProductsList>
    
    /// Delete a product. Deleting a product with `type=good` is only possible if it has no SKUs associated with it. Deleting a product with `type=service` is only possible if it has no plans associated with it.
    ///
    /// - Parameter id: The ID of the product to delete.
    /// - Returns: A `StripeDeletedObject`.
    func delete(id: String) -> EventLoopFuture<DeletedObject>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ProductRoutes {
    public func create(id: String? = nil,
                       name: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       caption: String? = nil,
                       deactivateOn: [String]? = nil,
                       description: String? = nil,
                       images: [String]? = nil,
                       metadata: [String: String]? = nil,
                       packageDimensions: [String: Any]? = nil,
                       shippable: Bool? = nil,
                       taxCode: String? = nil,
                       type: StripeProductType? = nil,
                       url: String? = nil) -> EventLoopFuture<StripeProduct> {
        return create(id: id,
                      name: name,
                      active: active,
                      attributes: attributes,
                      caption: caption,
                      deactivateOn: deactivateOn,
                      description: description,
                      images: images,
                      metadata: metadata,
                      packageDimensions: packageDimensions,
                      shippable: shippable,
                      taxCode: taxCode,
                      type: type,
                      url: url)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeProduct> {
        return retrieve(id: id)
    }
    
    public func update(product: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       caption: String? = nil,
                       deactivateOn: [String]? = nil,
                       description: String? = nil,
                       images: [String]? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       packageDimensions: [String: Any]? = nil,
                       shippable: Bool? = nil,
                       statementDescriptor: String? = nil,
                       taxCode: String? = nil,
                       unitLabel: String? = nil,
                       url: String? = nil) -> EventLoopFuture<StripeProduct> {
        return update(product: product,
                          active: active,
                          attributes: attributes,
                          caption: caption,
                          deactivateOn: deactivateOn,
                          description: description,
                          images: images,
                          metadata: metadata,
                          name: name,
                          packageDimensions: packageDimensions,
                          shippable: shippable,
                          statementDescriptor: statementDescriptor,
                          taxCode: taxCode,
                          unitLabel: unitLabel,
                          url: url)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeProductsList> {
        return listAll(filter: filter)
    }
    
    public func delete(id: String) -> EventLoopFuture<DeletedObject> {
        return delete(id: id)
    }
}

public struct StripeProductRoutes: ProductRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let products = APIBase + APIVersion + "products"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(id: String?,
                       name: String,
                       active: Bool?,
                       attributes: [String]?,
                       caption: String?,
                       deactivateOn: [String]?,
                       description: String?,
                       images: [String]?,
                       metadata: [String: String]?,
                       packageDimensions: [String: Any]?,
                       shippable: Bool?,
                       taxCode: String?,
                       type: StripeProductType?,
                       url: String?) -> EventLoopFuture<StripeProduct> {
        var body: [String: Any] = [:]
        
        body["name"] = name

        if let id = id {
            body["id"] = id
        }

        if let active = active {
            body["active"] = active
        }
        
        if let attributes = attributes {
            body["attributes"] = attributes
        }
        
        if let caption = caption {
            body["caption"] = caption
        }
        
        if let deactivateOn = deactivateOn {
            body["deactivate_on"] = deactivateOn
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let images = images {
            body["images"] = images
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let packageDimensions = packageDimensions {
            packageDimensions.forEach { body["package_dimensions[\($0)]"] = $1 }
        }
        
        if let shippable = shippable {
            body["shippable"] = shippable
        }
        
        if let taxCode = taxCode {
            body["tax_code"] = taxCode
        }
        
        if let type = type {
            body["type"] = type.rawValue
        }
        
        if let url = url {
            body["url"] = url
        }
        
        return apiHandler.send(method: .POST, path: products, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeProduct> {
        return apiHandler.send(method: .GET, path: "\(products)/\(id)", headers: headers)
    }
    
    public func update(product: String,
                       active: Bool?,
                       attributes: [String]?,
                       caption: String?,
                       deactivateOn: [String]?,
                       description: String?,
                       images: [String]?,
                       metadata: [String : String]?,
                       name: String?,
                       packageDimensions: [String: Any]?,
                       shippable: Bool?,
                       statementDescriptor: String?,
                       taxCode: String?,
                       unitLabel: String?,
                       url: String?) -> EventLoopFuture<StripeProduct> {
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let attributes = attributes {
            body["attributes"] = attributes
            
        }
        
        if let caption = caption {
            body["caption"] = caption
        }
        
        if let deactivateOn = deactivateOn {
            body["deactivate_on"] = deactivateOn
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let images = images {
            body["images"] = images
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let name = name {
            body["name"] = name
        }
        
        if let packageDimensions = packageDimensions {
            packageDimensions.forEach { body["package_dimensions[\($0)]"] = $1 }
        }
        
        if let shippable = shippable {
            body["shippable"] = shippable
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let taxCode = taxCode {
            body["tax_code"] = taxCode
        }
        
        if let unitLabel = unitLabel {
            body["unit_label"] = unitLabel
        }
        
        if let url = url {
            body["url"] = url
        }

        return apiHandler.send(method: .POST, path: "\(products)/\(product)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeProductsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: products, query: queryParams, headers: headers)
    }
    
    public func delete(id: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(products)/\(id)", headers: headers)
    }
}
