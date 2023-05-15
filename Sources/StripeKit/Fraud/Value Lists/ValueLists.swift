//
//  ValueLists.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import Foundation

/// The [Value List](https://stripe.com/docs/api/radar/value_lists/object)
public struct ValueList: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The name of the value list for use in rules.
    public var alias: String?
    /// The type of items in the value list. One of `card_fingerprint`, `card_bin`, `email`, `ip_address`, `country`, `string`,  `case_sensitive_string` or `customer_id`.
    public var itemType: ValueListItemType?
    /// List of items contained within this value list.
    public var listItems: ValueListItemList?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The name of the value list.
    public var name: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The name or email address of the user who added this item to the value list.
    public var createdBy: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    
    public init(id: String,
                alias: String? = nil,
                itemType: ValueListItemType? = nil,
                listItems: ValueListItemList? = nil,
                metadata: [String : String]? = nil,
                name: String? = nil,
                object: String,
                created: Date,
                createdBy: String? = nil,
                livemode: Bool? = nil) {
        self.id = id
        self.alias = alias
        self.itemType = itemType
        self.listItems = listItems
        self.metadata = metadata
        self.name = name
        self.object = object
        self.created = created
        self.createdBy = createdBy
        self.livemode = livemode
    }
}

public enum ValueListItemType: String, Codable {
    case cardFingerprint = "card_fingerprint"
    case cardBin = "card_bin"
    case email
    case ipAddress = "ip_address"
    case country
    case string
    case caseSensitiveString = "case_sensitive_string"
    case customerId = "customer_id"
}

public struct ValueListList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ValueList]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [ValueList]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
