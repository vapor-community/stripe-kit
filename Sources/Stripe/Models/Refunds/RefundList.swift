//
//  RefundList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Refunds list
 https://stripe.com/docs/api/curl#charge_object-refunds
 */

public struct RefundsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeRefund]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
