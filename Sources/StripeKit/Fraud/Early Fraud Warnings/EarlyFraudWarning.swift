//
//  EarlyFraudWarning.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import Foundation

/// The [Early Fraud Warning Object](https://stripe.com/docs/api/radar/early_fraud_warnings/object).
public struct StripeEarlyFraudWarning: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// An EFW is actionable if it has not received a dispute and has not been fully refunded. You may wish to proactively refund a charge that receives an EFW, in order to avoid receiving a dispute later.
    public var actionable: Bool?
    /// ID of the charge this early fraud warning is for, optionally expanded.
    public var charge: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The type of fraud labelled by the issuer. One of `card_never_received`, `fraudulent_card_application`, `made_with_counterfeit_card`, `made_with_lost_card`, `made_with_stolen_card`, `misc`, `unauthorized_use_of_card`.
    public var fraudType: StripeEarlyFraudWarningFraudType?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
}

public enum StripeEarlyFraudWarningFraudType: String, StripeModel {
    case cardNeverReceived = "card_never_received"
    case fraudulentCardApplication = "fraudulent_card_application"
    case madeWithCounterfeitCard = "made_with_counterfeit_card"
    case madeWithLostCard = "made_with_lost_card"
    case madeWithStolenCard = "made_with_stolen_card"
    case misc
    case unauthorizedUseOfCard = "unauthorized_use_of_card"
}

public struct StripeEarlyFraudWarningList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeEarlyFraudWarning]?
}
