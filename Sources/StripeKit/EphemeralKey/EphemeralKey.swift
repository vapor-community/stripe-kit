//
//  EphemeralKey.swift
//  Stripe
//
//  Created by Andrew Edwards on 10/17/17.
//

import Foundation

public struct StripeEphemeralKey: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object's type. Objects of the same type share the same value.
    public var object: String
    public var associatedObjects: [[String : String]]?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Whether this object is deleted or not.
    public var deleted: Bool?
    /// Time at which the key will expire. Measured in seconds since the Unix epoch.
    public var expires: Date?
    ///Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The key's secret. You can use this value to make authorized requests to the Stripe API.
    public var secret: String?
}
