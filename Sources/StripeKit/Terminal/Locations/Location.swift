//
//  Location.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation

/// The [Location Object](https://stripe.com/docs/api/terminal/locations/object).
public struct StripeLocation: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The full address of the location.
    public var address: Address?
    /// The display name of the location.
    public var displayName: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
}

public struct StripeLocationList: Codable {
    public var object: String
    public var data: [StripeLocation]?
    public var hasMore: Bool?
    public var url: String?
}
