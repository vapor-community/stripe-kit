//
//  EphemeralKey.swift
//  
//
//  Created by Andrew Edwards on 7/31/23.
//

import Foundation

public struct EphemeralKey: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object's type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Time at which the key will expire. Measured in seconds since the Unix epoch.
    public var expires: Date
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    /// The key's secret. You can use this value to make authorized requests to the Stripe API.
    public var secret: String?
    
    public init(id: String,
                object: String,
                created: Date,
                expires: Date,
                livemode: Bool,
                secret: String? = nil) {
        self.id = id
        self.object = object
        self.created = created
        self.expires = expires
        self.livemode = livemode
        self.secret = secret
    }
}
