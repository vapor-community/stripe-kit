//
//  Secret.swift
//  
//
//  Created by Andrew Edwards on 5/18/23.
//

import Foundation

public struct Secret: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If true, indicates that this secret has been deleted
    public var deleted: Bool?
    /// The Unix timestamp for the expiry time of the secret, after which the secret deletes.
    public var expiresAt: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// A name for the secret that’s unique within the scope.
    public var name: String?
    /// The plaintext secret value to be stored. This field is not included by default. To include it in the response, expand the payload field.
    public var payload: String?
    /// Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
    public var scope: SecretScope?
    
    public init(id: String,
                object: String,
                created: Date,
                deleted: Bool? = nil,
                expiresAt: Date? = nil,
                livemode: Bool,
                name: String? = nil,
                payload: String? = nil,
                scope: SecretScope? = nil) {
        self.id = id
        self.object = object
        self.created = created
        self.deleted = deleted
        self.expiresAt = expiresAt
        self.livemode = livemode
        self.name = name
        self.payload = payload
        self.scope = scope
    }
}

public struct SecretScope: Codable {
    /// The secret scope type.
    public var type: SecretScopeType?
    /// The user ID, if type is set to “user”
    public var user: String?
    
    public init(type: SecretScopeType? = nil, user: String? = nil) {
        self.type = type
        self.user = user
    }
}

public enum SecretScopeType: String, Codable {
    /// A secret scoped to a specific user. Use this for oauth tokens or other per-user secrets. If this is set, `scope.user` must also be set.
    case user
    /// A  secret scoped to an account. Use this for API keys or other secrets that should be accessible by all UI Extension contexts.
    case account
}

public struct SecretList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Secret]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Secret]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
