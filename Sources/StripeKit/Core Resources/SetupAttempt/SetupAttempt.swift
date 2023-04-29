//
//  SetupAttempt.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import Foundation

public struct SetupAttempt: Codable {
    
    
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The value of application on the SetupIntent at the time of this confirmation.
    public var application: String?
    /// If present, the SetupIntent’s payment method will be attached to the in-context Stripe Account.
    /// It can only be used for this Stripe Account’s own money movement flows like InboundTransfer and OutboundTransfers. It cannot be set to true when setting up a PaymentMethod for a Customer, and defaults to false when attaching a PaymentMethod to a Customer.
    public var attachToSelf: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The value of customer on the SetupIntent at the time of this confirmation.
    @Expandable<Customer> public var customer: String?
    /// Indicates the directions of money movement for which this payment method is intended to be used.
    /// Include inbound if you intend to use the payment method as the origin to pull funds from. Include outbound if you intend to use the payment method as the destination to send funds to. You can include both if you intend to use the payment method for both purposes.
    public var flowDirections: [String]?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The value of `on_behalf_of` on the SetupIntent at the time of this confirmation.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// ID of the payment method used with this SetupAttempt.
    @Expandable<StripePaymentMethod> public var paymentMethod: String?
    /// Details about the payment method at the time of SetupIntent confirmation.
    public var paymentMethodDetails: SetupAttemptPaymentMethodDetails?
    /// The error encountered during this attempt to confirm the SetupIntent, if any.
    public var setupError: _StripeError?
    /// ID of the SetupIntent that this attempt belongs to.
    @Expandable<SetupIntent> public var setupIntent: String?
    /// Status of this SetupAttempt, one of `requires_confirmation`, `requires_action`, `processing`, `succeeded`, `failed`, or `abandoned`.
    public var status: SetupAttemptStatus?
    /// The value of usage on the SetupIntent at the time of this confirmation, one of `off_session` or `on_session`.
    public var usage: SetupAttemptUsage?
    
    public init(id: String,
                object: String,
                application: String? = nil,
                attachToSelf: Bool? = nil,
                created: Date? = nil,
                customer: String? = nil,
                flowDirections: [String]? = nil,
                livemode: Bool? = nil,
                onBehalfOf: String? = nil,
                paymentMethod: String? = nil,
                paymentMethodDetails: SetupAttemptPaymentMethodDetails? = nil,
                setupError: _StripeError? = nil,
                setupIntent: String? = nil,
                status: SetupAttemptStatus? = nil,
                usage: SetupAttemptUsage? = nil) {
        self.id = id
        self.object = object
        self.application = application
        self.attachToSelf = attachToSelf
        self.created = created
        self._customer = Expandable(id: customer)
        self.flowDirections = flowDirections
        self.livemode = livemode
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self._paymentMethod = Expandable(id: paymentMethod)
        self.paymentMethodDetails = paymentMethodDetails
        self.setupError = setupError
        self._setupIntent = Expandable(id: setupIntent)
        self.status = status
        self.usage = usage
    }
}

public enum SetupAttemptStatus: String, Codable {
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case succeeded
    case failed
    case abandoned
}

public enum SetupAttemptUsage: String, Codable {
    case offSession = "off_session"
    case onSession = "on_session"
}

public struct SetupAttemptList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [SetupAttempt]?
}
