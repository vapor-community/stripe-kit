//
//  TerminalHardwareShippingMethod.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation

public struct TerminalHardwareShippingMethod: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The country in which this Shipping Method is available.
    public var country: String?
    /// The estimated delivery period containing the estimated minimum and maximum delivery dates. These dates are not guaranteed.
    public var estimatedDeliveryWindow: TerminalHardwareShippingMethodEstimatedDeliveryWindow?
    /// The name of the Terminal Hardware Shipping Method.
    public var name: TerminalHardwareShippingMethodName?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The Shipping Method’s status.
    public var status: TerminalHardwareShippingMethodStatus?
    /// A UNIX timestamp, after which time this Shipping Method has a status of `unavailable` and it can’t be used for order creation. If absent, we have no plans to make this Shipping Method unavailable.
    public var unavailableAfter: Date?
    
    public init(id: String,
                country: String? = nil,
                estimatedDeliveryWindow: TerminalHardwareShippingMethodEstimatedDeliveryWindow? = nil,
                name: TerminalHardwareShippingMethodName? = nil,
                object: String,
                status: TerminalHardwareShippingMethodStatus? = nil,
                unavailableAfter: Date? = nil) {
        self.id = id
        self.country = country
        self.estimatedDeliveryWindow = estimatedDeliveryWindow
        self.name = name
        self.object = object
        self.status = status
        self.unavailableAfter = unavailableAfter
    }
}

public struct TerminalHardwareShippingMethodEstimatedDeliveryWindow: Codable {
    /// Maximum estimated delivery date in ISO 8601 format.
    public var maximumDate: String?
    /// Minimum estimated delivery date in ISO 8601 format.
    public var minimumDate: String?
    
    public init(maximumDate: String? = nil,
                minimumDate: String? = nil) {
        self.maximumDate = maximumDate
        self.minimumDate = minimumDate
    }
}

public enum TerminalHardwareShippingMethodName: String, Codable {
    /// Standard
    case standard
    /// Express
    case express
    /// Priority
    case priority
}

public enum TerminalHardwareShippingMethodStatus: String, Codable {
    /// Available for new orders.
    case available
    /// Can no longer be used for order creation.
    case unavailable
}

public struct TerminalHardwareShippingMethodList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TerminalHardwareShippingMethod]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TerminalHardwareShippingMethod]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
