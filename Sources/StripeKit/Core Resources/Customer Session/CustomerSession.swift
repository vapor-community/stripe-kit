//
//  CustomerSession.swift
//  stripe-kit
//
//  Created by Anatol Mayen on 11.11.24.
//

import Foundation

/// The [Customer Session Object](https://docs.stripe.com/api/customer_sessions/object)
public struct CustomerSession: Codable {

    /// The client secret of this Customer Session. Used on the client to set up secure access to the given customer.
    /// The client secret can be used to provide access to customer from your frontend. It should not be stored, logged, or exposed to anyone other than the relevant customer.
    /// Make sure that you have TLS enabled on any page that includes the client secret.
    public var clientSecret: String
    
    /// This hash defines which component is enabled and the features it supports.
    public var components: Components
    
    /// The Customer the Customer Session was created for.
    @Expandable<Customer> public var customer: String?
    
    /// The timestamp at which this Customer Session will expire.
    public var expiresAt: Date?
    
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    
    
    init(clientSecret: String, components: Components, customer: String? = nil, expiresAt: Date? = nil, object: String, created: Date, livemode: Bool) {
        self.clientSecret = clientSecret
        self.components = components
        self._customer = Expandable(id: customer)
        self.expiresAt = expiresAt
        self.object = object
        self.created = created
        self.livemode = livemode
    }
}
