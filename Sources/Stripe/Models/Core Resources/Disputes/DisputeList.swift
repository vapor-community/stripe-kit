//
//  DisputeList.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

/**
 Disputes List
 https://stripe.com/docs/api#list_disputes
 */

public struct DisputesList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeDispute]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
