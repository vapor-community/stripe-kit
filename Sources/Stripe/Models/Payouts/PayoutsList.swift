//
//  PayoutsList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/21/18.
//

/**
 Payouts List
 https://stripe.com/docs/api/curl#list_payouts
 */

public struct StripePayoutsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripePayout]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
