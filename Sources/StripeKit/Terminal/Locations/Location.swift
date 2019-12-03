//
//  Location.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation

/// The [Location Object](https://stripe.com/docs/api/terminal/locations/object).
public struct StripeLocation: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The full address of the location.
    public var address: StripeAddress?
    /// The display name of the location.
    public var displayName: String?
}

public struct StripeLocationList: StripeModel {
    public var object: String
    public var data: [StripeLocation]?
    public var hasMore: Bool?
    public var url: String?
}
