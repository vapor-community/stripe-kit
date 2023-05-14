//
//  AccountSession.swift
//  
//
//  Created by Andrew Edwards on 5/14/23.
//

import Foundation

public struct AccountSession: Codable {
    /// The ID of the account the AccountSession was created for
    public var account: String
    /// The client secret of this AccountSession. Used on the client to set up secure access to the given account.
    /// The client secret can be used to provide access to account from your frontend. It should not be stored, logged, or exposed to anyone other than the connected account. Make sure that you have TLS enabled on any page that includes the client secret.
    /// Refer to our docs to setup Connect embedded components and learn about how `client_secret` should be handled.
    public var clientSecret: String?
    /// The timestamp at which this AccountSession will expire.
    public var expiresAt: Date?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    
    public init(account: String,
                clientSecret: String? = nil,
                expiresAt: Date? = nil,
                object: String, livemode: Bool) {
        self.account = account
        self.clientSecret = clientSecret
        self.expiresAt = expiresAt
        self.object = object
        self.livemode = livemode
    }
}
