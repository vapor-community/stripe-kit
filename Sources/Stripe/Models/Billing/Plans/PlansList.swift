//
//  PlansList.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

/**
 Plans List
 https://stripe.com/docs/api/curl#list_plans
 */

public struct PlansList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripePlan]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
