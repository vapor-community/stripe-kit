//
//  Review.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/26/19.
//

import Foundation

/// The [Review Object](https://stripe.com/docs/api/radar/reviews/object)
public struct Review: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The charge associated with this review.
    @Expandable<Charge> public var charge: String?
    /// If `true`, the review needs action.
    public var open: Bool?
    /// The PaymentIntent ID associated with this review, if one exists.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    /// The reason the review is currently open or closed. One of `rule`, `manual`, `approved`, `refunded`, `refunded_as_fraud`, or `disputed`.
    public var reason: ReviewReason?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The ZIP or postal code of the card used, if applicable.
    public var billingZip: String?
    /// The reason the review was closed, or null if it has not yet been closed. One of `approved`, `refunded`, `refunded_as_fraud`, or `disputed`.
    public var closedReason: ReviewClosedReason?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The IP address where the payment originated.
    public var ipAddress: String?
    /// Information related to the location of the payment. Note that this information is an approximation and attempts to locate the nearest population center - it should not be used to determine a specific address.
    public var ipAddressLocation: ReviewIPAddressLocation?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The reason the review was opened. One of rule or manual.
    public var openedReason: ReviewOpenedReason?
    /// Information related to the browsing session of the user who initiated the payment.
    public var session: ReviewSession?
    
    public init(id: String,
                charge: String? = nil,
                open: Bool? = nil,
                paymentIntent: String? = nil,
                reason: ReviewReason? = nil,
                object: String,
                billingZip: String? = nil,
                closedReason: ReviewClosedReason? = nil,
                created: Date,
                ipAddress: String? = nil,
                ipAddressLocation: ReviewIPAddressLocation? = nil,
                livemode: Bool? = nil,
                openedReason: ReviewOpenedReason? = nil,
                session: ReviewSession? = nil) {
        self.id = id
        self._charge = Expandable(id: charge)
        self.open = open
        self._paymentIntent = Expandable(id: paymentIntent)
        self.reason = reason
        self.object = object
        self.billingZip = billingZip
        self.closedReason = closedReason
        self.created = created
        self.ipAddress = ipAddress
        self.ipAddressLocation = ipAddressLocation
        self.livemode = livemode
        self.openedReason = openedReason
        self.session = session
    }
}

public enum ReviewReason: String, Codable {
    case rule
    case manual
    case approved
    case refunded
    case refundedAsFraud = "refunded_as_fraud"
    case disputed
}

public enum ReviewClosedReason: String, Codable {
    case approved
    case refunded
    case refundedAsFraud = "refunded_as_fraud"
    case disputed
    case redacted
}

public enum ReviewOpenedReason: String, Codable {
    case rule
    case manual
}

public struct ReviewIPAddressLocation: Codable {
    /// The city where the payment originated.
    public var city: String?
    /// Two-letter ISO code representing the country where the payment originated.
    public var country: String?
    /// The geographic latitude where the payment originated.
    public var latitude: Double?
    /// The geographic longitude where the payment originated.
    public var longitude: Double?
    /// The state/county/province/region where the payment originated.
    public var region: String?
    
    public init(city: String? = nil,
                country: String? = nil,
                latitude: Double? = nil,
                longitude: Double? = nil,
                region: String? = nil) {
        self.city = city
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.region = region
    }
}

public struct ReviewSession: Codable {
    /// The browser used in this browser session (e.g., `Safari`).
    public var browser: String?
    /// Information about the device used for the browser session (e.g., `iPhone 14 Pro Max`).
    public var device: String?
    /// The platform for the browser session (e.g., `Macintosh`).
    public var platform: String?
    /// The version for the browser session (e.g., `61.0.3163.100`).
    public var version: String?
    
    public init(browser: String? = nil,
                device: String? = nil,
                platform: String? = nil,
                version: String? = nil) {
        self.browser = browser
        self.device = device
        self.platform = platform
        self.version = version
    }
}

public struct ReviewList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Review]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Review]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
