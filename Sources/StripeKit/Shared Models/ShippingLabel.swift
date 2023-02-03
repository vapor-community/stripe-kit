//
//  ShippingLabel.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public struct StripeShippingLabel: Codable {
    /// Shipping address.
    public var address: Address?
    /// The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
    public var carrier: String?
    /// Recipient name.
    public var name: String?
    /// Recipient phone (including extension).
    public var phone: String?
    /// The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
    public var trackingNumber: String?
}
