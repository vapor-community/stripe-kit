//
//  BalanceHistoryList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 BalanceHistory list
 https://stripe.com/docs/api#balance_history
 */

public struct BalanceHistoryList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeBalanceTransactionItem]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
