//
//  TerminalHardwareSKU.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation

public struct TerminalHardwareSKU: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The price of this SKU.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The country in which this SKU is available.
    public var country: String?
    /// The maximum quantity of this TerminalHardwareSKU that can be ordered. This will change over time due to inventory and other constraints.
    public var orderable: Int?
    /// ID of the product for this SKU.
    @Expandable<TerminalHardwareProduct> public var product: String?
    /// The SKU’s status.
    public var status: TerminalHardwareSKUStatus?
    /// A UNIX timestamp, after which time this SKU has a status of unavailable and it can’t be used for order creation. If absent, we have no plans to make this SKU unavailable.
    public var unavailableAfter: Date?
    
    public init(id: String,
                amount: Int? = nil,
                currency: Currency? = nil,
                object: String,
                country: String? = nil,
                orderable: Int? = nil,
                product: String? = nil,
                status: TerminalHardwareSKUStatus? = nil,
                unavailableAfter: Date? = nil) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.object = object
        self.country = country
        self.orderable = orderable
        self._product = Expandable(id: product)
        self.status = status
        self.unavailableAfter = unavailableAfter
    }
}

public enum TerminalHardwareSKUStatus: String, Codable {
    /// Available for new orders.
    case available
    /// Can no longer be used for order creation.
    case unavailable
}

public struct TerminalHardwareSKUList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TerminalHardwareSKU]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TerminalHardwareSKU]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
