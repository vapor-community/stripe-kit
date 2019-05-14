//
//  StripeStatus.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum StripeStatus: String, Codable {
    case success
    case succeeded
    case failed
    case pending
    case canceled
    case chargeable
    case available
}

// https://stripe.com/docs/api/invoices/object#invoice_object-status

public enum StripeConnectAccountCapabilitiesStatus: String, Codable {
    case active
    case inactive
    case pending
}
