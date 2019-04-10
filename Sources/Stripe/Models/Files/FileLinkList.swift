//
//  FileLinkList.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

public struct FileLinkList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeFileLink]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
