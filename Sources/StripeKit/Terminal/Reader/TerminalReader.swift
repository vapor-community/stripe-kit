//
//  TerminalReader.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation

/// The [Reader Object](https://stripe.com/docs/api/terminal/readers/object)
public struct TerminalReader: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Type of reader, one of `bbpos_wisepad3`, `stripe_m2`, `bbpos_chipper2x`, `bbpos_wisepos_e`, `verifone_P400`, or `simulated_wisepos_e`.
    public var deviceType: String?
    /// Custom label given to the reader for easier identification.
    public var label: String?
    /// The location identifier of the reader.
    @Expandable<TerminalLocation> public var location: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Serial number of the reader.
    public var serialNumber: String?
    /// The networking status of the reader.
    public var status: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The most recent action performed by the reader.
    public var action: TerminalReaderAction?
    /// The current software version of the reader.
    public var deviceSwVersion: String?
    /// The local IP address of the reader.
    public var ipAddress: String?
    /// The last time this reader reported to Stripe backend.
    public var lastSeenAt: Int?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    
    public init(id: String,
                deviceType: String? = nil,
                label: String? = nil,
                location: String? = nil,
                metadata: [String : String]? = nil,
                serialNumber: String? = nil,
                status: String? = nil,
                object: String,
                action: TerminalReaderAction? = nil,
                deviceSwVersion: String? = nil,
                ipAddress: String? = nil,
                lastSeenAt: Int? = nil,
                livemode: Bool? = nil) {
        self.id = id
        self.deviceType = deviceType
        self.label = label
        self._location = Expandable(id: location)
        self.metadata = metadata
        self.serialNumber = serialNumber
        self.status = status
        self.object = object
        self.action = action
        self.deviceSwVersion = deviceSwVersion
        self.ipAddress = ipAddress
        self.lastSeenAt = lastSeenAt
        self.livemode = livemode
    }
}

public struct TerminalReaderAction: Codable {
    /// Failure code, only set if status is failed.
    public var failureCode: String?
    /// Detailed failure message, only set if status is failed.
    public var failureMessage: String?
    /// Payload required to process a PaymentIntent. Only present if type is `process_payment_intent`.
    public var processPaymentIntent: TerminalReaderActionPaymentIntent?
    /// Payload required to process a SetupIntent. Only present if type is `process_setup_intent`.
    public var processSetupIntent: TerminalReaderActionSetupIntent?
    /// Payload required to refund a payment. Only present if type is `refund_payment`.
    public var refundPayment: TerminalReaderActionRefundPayment?
    /// Payload required to set the reader display. Only present if type is `set_reader_display`.
    public var setReaderDisplay: TerminalReaderActionSetReaderDisplay?
    /// Status of the action performed by the reader.
    public var status: TerminalReaderActionStatus?
    /// Type of action performed by the reader.
    public var type: TerminalReaderActionType?
    
    public init(failureCode: String? = nil,
                failureMessage: String? = nil,
                processPaymentIntent: TerminalReaderActionPaymentIntent? = nil,
                processSetupIntent: TerminalReaderActionSetupIntent? = nil,
                refundPayment: TerminalReaderActionRefundPayment? = nil,
                setReaderDisplay: TerminalReaderActionSetReaderDisplay? = nil,
                status: TerminalReaderActionStatus? = nil,
                type: TerminalReaderActionType? = nil) {
        self.failureCode = failureCode
        self.failureMessage = failureMessage
        self.processPaymentIntent = processPaymentIntent
        self.processSetupIntent = processSetupIntent
        self.refundPayment = refundPayment
        self.setReaderDisplay = setReaderDisplay
        self.status = status
        self.type = type
    }
}

public enum TerminalReaderActionStatus: String, Codable {
    case inProgress = "in_progress"
    case succeeded
    case failed
}

public enum TerminalReaderActionType: String, Codable {
    case processPaymentIntent = "process_payment_intent"
    case processSetupIntent = "process_setup_intent"
    case setReaderDisplay = "set_reader_display"
    case refundPayment = "refund_payment"
}

public struct TerminalReaderActionPaymentIntent: Codable {
    /// Most recent PaymentIntent processed by the reader.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    /// Per-transaction overrides of Terminal reader configurations.
    public var processConfig: TerminalReaderActionPaymentIntentProcessConfig?
    
    public init(paymentIntent: String? = nil,
                processConfig: TerminalReaderActionPaymentIntentProcessConfig? = nil) {
        self._paymentIntent = Expandable(id: paymentIntent)
        self.processConfig = processConfig
    }
}

public struct TerminalReaderActionPaymentIntentProcessConfig: Codable {
    /// Override showing a tipping selection screen on this transaction.
    public var skipTipping: Bool?
    /// Tipping configuration for this transaction.
    public var tipping: TerminalReaderActionPaymentIntentProcessConfigTipping?
    
    public init(skipTipping: Bool? = nil, tipping: TerminalReaderActionPaymentIntentProcessConfigTipping? = nil) {
        self.skipTipping = skipTipping
        self.tipping = tipping
    }
}

public struct TerminalReaderActionPaymentIntentProcessConfigTipping: Codable {
    /// Amount used to calculate tip suggestions on tipping selection screen for this transaction. Must be a positive integer in the smallest currency unit (e.g., 100 cents to represent $1.00 or 100 to represent ¥100, a zero-decimal currency).
    public var amount: Int?
    
    public init(amount: Int? = nil) {
        self.amount = amount
    }
}

public struct TerminalReaderActionSetupIntent: Codable {
    /// ID of a card PaymentMethod generated from the `card_present` PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
    public var generatedCard: String?
    /// Most recent SetupIntent processed by the reader.
    @Expandable<SetupIntent> public var setupIntent: String?
    
    public init(generatedCard: String? = nil, setupIntent: String? = nil) {
        self.generatedCard = generatedCard
        self._setupIntent = Expandable(id: setupIntent)
    }
}

public struct TerminalReaderActionRefundPayment: Codable {
    /// The amount being refunded.
    public var amount: Int?
    /// Charge that is being refunded.
    @Expandable<Charge> public var charge: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Payment intent that is being refunded.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    /// The reason for the refund.
    public var reason: String?
    /// Unique identifier for the refund object.
    @Expandable<Refund> public var refund: String?
    /// Boolean indicating whether the application fee should be refunded when refunding this charge. If a full charge refund is given, the full application fee will be refunded. Otherwise, the application fee will be refunded in an amount proportional to the amount of the charge refunded. An application fee can be refunded only by the application that created the charge.
    public var refundApplicationFee: Bool?
    /// Boolean indicating whether the transfer should be reversed when refunding this charge. The transfer will be reversed proportionally to the amount being refunded (either the entire or partial amount). A transfer can be reversed only by the application that created the charge.
    public var reverseTransfer: Bool?
    
    public init(amount: Int? = nil,
                charge: String? = nil,
                metadata: [String: String]? = nil,
                paymentIntent: String? = nil,
                reason: String? = nil,
                refund: String? = nil,
                refundApplicationFee: Bool? = nil,
                reverseTransfer: Bool? = nil) {
        self.amount = amount
        self._charge = Expandable(id: charge)
        self.metadata = metadata
        self._paymentIntent = Expandable(id: paymentIntent)
        self.reason = reason
        self._refund = Expandable(id: refund)
        self.refundApplicationFee = refundApplicationFee
        self.reverseTransfer = reverseTransfer
    }
}

public struct TerminalReaderActionSetReaderDisplay: Codable {
    /// Cart object to be displayed by the reader.
    public var cart: TerminalReaderActionSetReaderDisplayCart?
    /// Type of information to be displayed by the reader.
    public var type: String?
    
    public init(cart: TerminalReaderActionSetReaderDisplayCart? = nil, type: String? = nil) {
        self.cart = cart
        self.type = type
    }
}

public struct TerminalReaderActionSetReaderDisplayCart: Codable {
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// List of line items in the cart.
    public var lineItems: [TerminalReaderActionSetReaderDisplayCartLineItem]?
    /// Tax amount for the entire cart. A positive integer in the smallest currency unit.
    public var tax: Int?
    /// Total amount for the entire cart, including tax. A positive integer in the smallest currency unit.
    public var total: Int?
    
    public init(currency: Currency? = nil,
                lineItems: [TerminalReaderActionSetReaderDisplayCartLineItem]? = nil,
                tax: Int? = nil,
                total: Int? = nil) {
        self.currency = currency
        self.lineItems = lineItems
        self.tax = tax
        self.total = total
    }
}

public struct TerminalReaderActionSetReaderDisplayCartLineItem: Codable {
    /// The amount of the line item. A positive integer in the smallest currency unit.
    public var amount: Int?
    /// Description of the line item.
    public var description: String?
    /// The quantity of the line item.
    public var quantity: Int?
    
    public init(amount: Int? = nil,
                description: String? = nil,
                quantity: Int? = nil) {
        self.amount = amount
        self.description = description
        self.quantity = quantity
    }
}

public struct TerminalReaderList: Codable {
    public var object: String
    public var data: [TerminalReader]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [TerminalReader]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
