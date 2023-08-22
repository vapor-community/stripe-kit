//
//  TerminalHardwareProduct.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation

public struct TerminalHardwareProduct: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The status of the terminal hardware product.
    public var status: TerminalHardwareProductStatus?
    /// The type of product.
    public var type: String?
    /// If all the SKUs for this product have an `unavailable_after` then this is the max `unavailable_after` in UNIX timestamp. Otherwise, null.
    public var unavailableAfter: Date?
    
    public init(id: String,
                object: String,
                status: TerminalHardwareProductStatus? = nil,
                type: String? = nil,
                unavailableAfter: Date? = nil) {
        self.id = id
        self.object = object
        self.status = status
        self.type = type
        self.unavailableAfter = unavailableAfter
    }
}

public enum TerminalHardwareProductStatus: String, Codable {
    /// Available for new orders.
    case available
    /// Can no longer be used for order creation.
    case unavailable
}

public struct TerminalHardwareProductList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TerminalHardwareProduct]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TerminalHardwareProduct]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
