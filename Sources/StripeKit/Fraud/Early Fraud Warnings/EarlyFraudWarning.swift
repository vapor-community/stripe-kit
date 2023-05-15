//
//  EarlyFraudWarning.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import Foundation

/// The [Early Fraud Warning Object](https://stripe.com/docs/api/radar/early_fraud_warnings/object)
public struct EarlyFraudWarning: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// An EFW is actionable if it has not received a dispute and has not been fully refunded. You may wish to proactively refund a charge that receives an EFW, in order to avoid receiving a dispute later.
    public var actionable: Bool?
    /// ID of the charge this early fraud warning is for, optionally expanded.
    @Expandable<Charge> public var charge: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The type of fraud labelled by the issuer. One of `card_never_received`, `fraudulent_card_application`, `made_with_counterfeit_card`, `made_with_lost_card`, `made_with_stolen_card`, `misc`, `unauthorized_use_of_card`.
    public var fraudType: EarlyFraudWarningFraudType?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// ID of the Payment Intent this early fraud warning is for, optionally expanded.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    
    public init(id: String,
                object: String,
                actionable: Bool? = nil,
                charge: String? = nil,
                created: Date,
                fraudType: EarlyFraudWarningFraudType? = nil,
                livemode: Bool? = nil,
                paymentIntent: String? = nil) {
        self.id = id
        self.object = object
        self.actionable = actionable
        self._charge = Expandable(id: charge)
        self.created = created
        self.fraudType = fraudType
        self.livemode = livemode
        self._paymentIntent = Expandable(id: paymentIntent)
    }
}

public enum EarlyFraudWarningFraudType: String, Codable {
    case cardNeverReceived = "card_never_received"
    case fraudulentCardApplication = "fraudulent_card_application"
    case madeWithCounterfeitCard = "made_with_counterfeit_card"
    case madeWithLostCard = "made_with_lost_card"
    case madeWithStolenCard = "made_with_stolen_card"
    case misc
    case unauthorizedUseOfCard = "unauthorized_use_of_card"
}

public struct EarlyFraudWarningList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [EarlyFraudWarning]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [EarlyFraudWarning]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
