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
