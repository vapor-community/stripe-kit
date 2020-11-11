//
//  SetupAttempt.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import Foundation

public struct StripeSetupAttempt: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The value of application on the SetupIntent at the time of this confirmation.
    public var application: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The value of customer on the SetupIntent at the time of this confirmation.
    @Expandable<StripeCustomer> public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The value of `on_behalf_of` on the SetupIntent at the time of this confirmation.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// ID of the payment method used with this SetupAttempt.
    @Expandable<StripePaymentMethod> public var paymentMethod: String?
    /// The error encountered during this attempt to confirm the SetupIntent, if any.
    public var setupError: _StripeError?
    /// ID of the SetupIntent that this attempt belongs to.
    @Expandable<StripeSetupIntent> public var setupIntent: String?
    /// Status of this SetupAttempt, one of `requires_confirmation`, `requires_action`, `processing`, `succeeded`, `failed`, or `abandoned`.
    public var status: StripeSetupAttemptStatus?
    /// The value of usage on the SetupIntent at the time of this confirmation, one of off_session or on_session.
    public var usage: String?
}

public enum StripeSetupAttemptStatus: String, StripeModel {
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case succeeded
    case failed
    case abandoned
}

public struct StripeSetupAttemptList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSetupAttempt]?
}
