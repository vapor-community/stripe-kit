//
//  MandatePaymentMethods.swift
//  
//
//  Created by Andrew Edwards on 3/7/23.
//

import Foundation

// MARK: - ACSSDebit
public struct MandatePaymentMethodDetailsACSSDebit: Codable {
    /// List of Stripe products where this mandate can be selected automatically.
    public var defaultFor: MandatePaymentMethodDetailsACSSDebitDefaultFor?
    /// Description of the interval. Only required if the `‘payment_schedule’` parameter is `‘interval’` or`‘combined’`.
    public var intervalDescription: String?
    /// Payment schedule for the mandate.
    public var paymentSchedule: MandatePaymentMethodDetailsACSSDebitPaymentSchedule?
    /// Transaction type of the mandate.
    public var transactionType: MandatePaymentMethodDetailsACSSDebitTransactionType?
    
    public init(defaultFor: MandatePaymentMethodDetailsACSSDebitDefaultFor? = nil,
                intervalDescription: String? = nil,
                paymentSchedule: MandatePaymentMethodDetailsACSSDebitPaymentSchedule? = nil,
                transactionType: MandatePaymentMethodDetailsACSSDebitTransactionType? = nil) {
        self.defaultFor = defaultFor
        self.intervalDescription = intervalDescription
        self.paymentSchedule = paymentSchedule
        self.transactionType = transactionType
    }
}

public enum MandatePaymentMethodDetailsACSSDebitDefaultFor: String, Codable {
    /// Enables payments for Stripe Invoices. ‘subscription’ must also be provided.
    case invoice
    /// Enables payments for Stripe Subscriptions. ‘invoice’ must also be provided.
    case subscription
}

public enum MandatePaymentMethodDetailsACSSDebitPaymentSchedule: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum MandatePaymentMethodDetailsACSSDebitTransactionType: String, Codable {
    /// Transactions are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

// MARK: - AUBecsDebit
public struct MandatePaymentMethodDetailsAuBecsDebit: Codable {
    /// The URL of the mandate. This URL generally contains sensitive information about the customer and should be shared with them exclusively.
    public var url: String?
    
    public init(url: String? = nil) {
        self.url = url
    }
}

// MARK: - BacsDebit
public struct MandatePaymentMethodDetailsBacsDebit: Codable {
    /// The status of the mandate on the Bacs network. Can be one of  `pending`, `revoked`,`refused`, or `accepted`.
    public var networkStatus: MandatePaymentMethodDetailsBacsDebitnetworkStatus?
    /// The unique reference identifying the mandate on the Bacs network.
    public var reference: String?
    /// The URL that will contain the mandate that the customer has signed.
    public var url: String?

    public init(networkStatus: MandatePaymentMethodDetailsBacsDebitnetworkStatus? = nil,
                reference: String? = nil,
                url: String? = nil) {
        self.networkStatus = networkStatus
        self.reference = reference
        self.url = url
    }
}

public enum MandatePaymentMethodDetailsBacsDebitnetworkStatus: String, Codable {
    case pending
    case revoked
    case refused
    case accepted
}

// MARK: - Blik
public struct MandatePaymentMethodDetailsBlik: Codable {
    /// Date at which the mandate expires.
    public var expiresAfter: Date?
    /// Details for off-session mandates.
    public var offSession: MandatePaymentMethodDetailsBlikOffSession?
    /// Type of the mandate.
    public var type: MandatePaymentMethodDetailsBlikType?
    
    public init(expiresAfter: Date? = nil,
                offSession: MandatePaymentMethodDetailsBlikOffSession? = nil,
                type: MandatePaymentMethodDetailsBlikType? = nil) {
        self.expiresAfter = expiresAfter
        self.offSession = offSession
        self.type = type
    }
}

public struct MandatePaymentMethodDetailsBlikOffSession: Codable {
    /// Amount of each recurring payment.
    public var amount: Int?
    /// Currency of each recurring payment.
    public var currency: Currency?
    /// Frequency interval of each recurring payment.
    public var interval: MandatePaymentMethodDetailsBlikOffSessionInterval?
    
    public init(amount: Int? = nil,
                currency: Currency? = nil,
                interval: MandatePaymentMethodDetailsBlikOffSessionInterval? = nil) {
        self.amount = amount
        self.currency = currency
        self.interval = interval
    }
}

public enum MandatePaymentMethodDetailsBlikOffSessionInterval: String, Codable {
    /// Payments recur every day.
    case day
    /// Payments recur every week.
    case week
    /// Payments recur every month.
    case month
    /// Payments recur every year.
    case year
}

public enum MandatePaymentMethodDetailsBlikType: String, Codable {
    /// Mandate for on-session payments.
    case onSession = "on_session"
    /// Mandate for off-session payments.
    case offSession = "off_session"
}

// MARK: - Card
public struct MandatePaymentMethodDetailsCard: Codable {
    public init() { }
}

// MARK: - Link
public struct MandatePaymentMethodDetailsLink: Codable {
    public init() { }
}

// MARK: - SepaDebit
public struct MandatePaymentMethodDetailsSepaDebit: Codable {
    /// The unique reference of the mandate.
    public var reference: String?
    /// The URL of the mandate. This URL generally contains sensitive information about the customer and should be shared with them exclusively.
    public var url: String?
    
    public init(reference: String? = nil, url: String? = nil) {
        self.reference = reference
        self.url = url
    }
}

// MARK: - US Bank Account
public struct MandatePaymentMethodDetailsUsBankAccount: Codable {
    public init() { }
}
