//
//  PortalSession.swift
//  
//
//  Created by Andrew Edwards on 11/28/20.
//

import Foundation

public struct StripePortalSession: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The configuration used by this session, describing the features available.
    @Expandable<StripePortalConfiguration> public var configuration: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The ID of the customer for this session.
    public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The account for which the session was created on behalf of. When specified, only subscriptions and invoices with this `on_behalf_of` account appear in the portal. For more information, see the docs. Use the Accounts API to modify the `on_behalf_of` account’s branding settings, which the portal displays.
    public var onBehalfOf: String?
    /// The URL to which Stripe should send customers when they click on the link to return to your website.
    public var returnUrl: String?
    /// The short-lived URL of the session giving customers access to the customer portal.
    public var url: String?
}
