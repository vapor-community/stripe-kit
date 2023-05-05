//
//  Product.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

/// The [Product Object](https://stripe.com/docs/api/products/object) .
public struct Product: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Whether the product is currently available for purchase.
    public var active: Bool?
    /// The ID of the Price object that is the default price for this product.
    @Expandable<StripePrice> public var defaultPrice: String?
    /// The product’s description, meant to be displayable to the customer. Only applicable to products of `type=good`.
    public var description: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The product’s name, meant to be displayable to the customer.
    public var name: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// A list of up to 8 URLs of images for this product, meant to be displayable to the customer. Only applicable to products of `type=good`.
    public var images: [String]?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The dimensions of this product for shipping purposes.
    public var packageDimensions: ProductPackageDimensions?
    /// Whether this product is shipped (i.e., physical goods).
    public var shippable: Bool?
    /// Extra information about a product which will appear on your customer’s credit card statement. In the case that multiple products are billed at once, the first statement descriptor will be used.
    public var statementDescriptor: String?
    /// A tax code ID.
    @Expandable<StripeTaxCode> public var taxCode: String?
    /// A label that represents units of this product. When set, this will be included in customers’ receipts, invoices, Checkout, and the customer portal.
    public var unitLabel: String?
    /// Time at which the object was last updated. Measured in seconds since the Unix epoch.
    public var updated: Date?
    /// A URL of a publicly-accessible webpage for this product.
    public var url: String?
    
    public init(id: String,
                active: Bool? = nil,
                defaultPrice: String? = nil,
                description: String? = nil,
                metadata: [String : String]? = nil,
                name: String? = nil,
                object: String,
                created: Date,
                images: [String]? = nil,
                livemode: Bool? = nil,
                packageDimensions: ProductPackageDimensions? = nil,
                shippable: Bool? = nil,
                statementDescriptor: String? = nil,
                taxCode: String? = nil,
                unitLabel: String? = nil,
                updated: Date? = nil,
                url: String? = nil) {
        self.id = id
        self.active = active
        self._defaultPrice = Expandable(id: defaultPrice)
        self.description = description
        self.metadata = metadata
        self.name = name
        self.object = object
        self.created = created
        self.images = images
        self.livemode = livemode
        self.packageDimensions = packageDimensions
        self.shippable = shippable
        self.statementDescriptor = statementDescriptor
        self._taxCode = Expandable(id: taxCode)
        self.unitLabel = unitLabel
        self.updated = updated
        self.url = url
    }
}

public struct ProductPackageDimensions: Codable {
    /// Height, in inches.
    public var height: Decimal?
    /// Length, in inches.
    public var length: Decimal?
    /// Weight, in inches.
    public var weight: Decimal?
    /// Width, in inches.
    public var width: Decimal?
    
    public init(height: Decimal? = nil,
                length: Decimal? = nil,
                weight: Decimal? = nil,
                width: Decimal? = nil) {
        self.height = height
        self.length = length
        self.weight = weight
        self.width = width
    }
}

public struct ProductSearchResult: Codable {
    /// A string describing the object type returned.
    public var object: String
    /// A list of products, paginated by any request parameters.
    public var data: [Product]?
    /// Whether or not there are more elements available after this set.
    public var hasMore: Bool?
    /// The URL for accessing this list.
    public var url: String?
    /// The URL for accessing the next page in search results.
    public var nextPage: String?
    /// The total count of entries in the search result, not just the current page.
    public var totalCount: Int?
    
    public init(object: String,
                data: [Product]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil,
                nextPage: String? = nil,
                totalCount: Int? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
        self.nextPage = nextPage
        self.totalCount = totalCount
    }
}

public struct ProductsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Product]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Product]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
