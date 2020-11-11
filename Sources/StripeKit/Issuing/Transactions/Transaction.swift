//
//  Transaction.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import Foundation

public struct StripeTransaction: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The amount of this transaction in your currency. This is the amount that your balance will be updated by.
    public var amount: Int?
    /// Detailed breakdown of amount components. These amounts are denominated in currency and in the smallest currency unit.
    public var amountDetails: StripeTransactionAmountDetails?
    /// The Authorization object that led to this transaction.
    @Expandable<StripeAuthorization> public var authorization: String?
    /// ID of the balance transaction associated with this transaction.
    @Expandable<StripeBalanceTransaction> public var balanceTransaction: String?
    /// The card used to make this transaction.
    @Expandable<StripeIssuingCard> public var card: String?
    /// The cardholder to whom this transaction belongs.
    @Expandable<StripeCardholder> public var cardholder: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The amount that the merchant will receive, denominated in `merchant_currency`. It will be different from `amount` if the merchant is taking payment in a different currency.
    public var merchantAmount: Int?
    /// The currency with which the merchant is taking payment.
    public var merchantCurrency: StripeCurrency?
    /// More information about the user involved in the transaction.
    public var merchantData: StripeAuthorizationMerchantData?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The nature of the transaction.
    public var type: StripeTransactionType?
    /// Additional purchase information that is optionally provided by the merchant. This field is not included by default. To include it in the response, expand the `purchase_details` field.
    public var purchaseDetails: StripeTransactionPurchaseDetails?
}

public struct StripeTransactionAmountDetails: StripeModel {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?
}

public struct StripeTransactionList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeTransaction]?
}

public enum StripeTransactionType: String, StripeModel {
    /// Funds were captured by the acquirer. amount will be negative as funds are moving out of your balance. Not all captures will be linked to an authorization, as acquirers can force capture in some cases.
    case capture
    /// An acquirer initiated a refund. This transaction might not be linked to an original capture, for example credits are original transactions. amount will be positive for refunds and negative for refund reversals.
    case refund
}

public struct StripeTransactionPurchaseDetails: StripeModel {
    /// Information about the flight that was purchased with this transaction.
    public var flight: StripeTransactionPurchaseDetailsFlight?
    /// Information about fuel that was purchased with this transaction.
    public var fuel: StripeTransactionPurchaseDetailsFuel?
    /// Information about lodging that was purchased with this transaction.
    public var lodging: StripeTransactionPurchaseDetailsLodging?
    /// The line items in the purchase.
    public var receipt: [StripeTransactionPurchaseDetailsReceipt]?
    /// A merchant-specific order number.
    public var reference: String?
}

public struct StripeTransactionPurchaseDetailsFlight: StripeModel {
    /// The time that the flight departed.
    public var departureAt: Int?
    /// The name of the passenger.
    public var passengerName: String?
    /// Whether the ticket is refundable.
    public var refundable: Bool?
    /// The legs of the trip.
    public var segments: [StripeTransactionPurchaseDetailsFlightSegment]?
    /// The travel agency that issued the ticket.
    public var travelAgency: String?
}

public struct StripeTransactionPurchaseDetailsFlightSegment: StripeModel {
    /// The three-letter IATA airport code of the flight’s destination.
    public var arrivalAirportCode: String?
    /// The airline carrier code.
    public var carrier: String?
    /// The three-letter IATA airport code that the flight departed from.
    public var departureAirportCode: String?
    /// The flight number.
    public var flightNumber: String?
    /// The flight’s service class.
    public var serviceCLass: String?
    /// Whether a stopover is allowed on this flight.
    public var stopoverAllowed: Bool?
}

public struct StripeTransactionPurchaseDetailsFuel: StripeModel {
    /// The type of fuel that was purchased. One of `diesel`, `unleaded_plus`, `unleaded_regular`, `unleaded_super`, or `other`.
    public var type: StripeTransactionPurchaseDetailsFuelType?
    /// The units for `volume_decimal`. One of `us_gallon` or `liter`.
    public var unit: StripeTransactionPurchaseDetailsFuelUnit?
    /// The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
    public var unitCostDecimal: Decimal?
    /// The volume of the fuel that was pumped, represented as a decimal string with at most 12 decimal places.
    public var volumeDecimal: Decimal?
}

public enum StripeTransactionPurchaseDetailsFuelType: String, StripeModel {
    case diesel
    case unleadedPlus = "unleaded_plus"
    case unleadedRegular = "unleaded_regular"
    case unleadedSuper = "unleaded_super"
    case other
}

public enum StripeTransactionPurchaseDetailsFuelUnit: String, StripeModel {
    case usGallon = "us_gallon"
    case liter
}

public struct StripeTransactionPurchaseDetailsLodging: StripeModel {
    /// The time of checking into the lodging.
    public var checkInAt: Int?
    /// The number of nights stayed at the lodging.
    public var nights: Int?
}

public struct StripeTransactionPurchaseDetailsReceipt: StripeModel {
    /// The description of the item. The maximum length of this field is 26 characters.
    public var description: String?
    /// The quantity of the item.
    public var quantity: Decimal?
    /// The total for this line item in cents.
    public var total: Int?
    /// The unit cost of the item in cents.
    public var unitCost: Int?
}
