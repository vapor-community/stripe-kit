//
//  TransferList.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

import Foundation

/**
 Transfers list
 https://stripe.com/docs/api/curl#list_transfers
 */

public struct TransferList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeTransfer]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
