//
//  ProductsList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

/**
 Products List
 https://stripe.com/docs/api/curl#list_products
 */

public struct ProductsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeProduct]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
