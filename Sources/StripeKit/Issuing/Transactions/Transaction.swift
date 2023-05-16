//
//  Transaction.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import Foundation

public struct Transaction: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The amount of this transaction in your currency. This is the amount that your balance will be updated by.
    public var amount: Int?
    /// The Authorization object that led to this transaction.
    @Expandable<Authorization> public var authorization: String?
    /// The card used to make this transaction.
    @Expandable<IssuingCard> public var card: String?
    /// The cardholder to whom this transaction belongs.
    @Expandable<Cardholder> public var cardholder: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The nature of the transaction.
    public var type: TransactionType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Detailed breakdown of amount components. These amounts are denominated in currency and in the smallest currency unit.
    public var amountDetails: TransactionAmountDetails?
    /// ID of the balance transaction associated with this transaction.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If you’ve disputed the transaction, the ID of the dispute.
    @Expandable<IssuingDispute> public var dispute: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The amount that the merchant will receive, denominated in `merchant_currency`. It will be different from `amount` if the merchant is taking payment in a different currency.
    public var merchantAmount: Int?
    /// The currency with which the merchant is taking payment.
    public var merchantCurrency: Currency?
    /// More information about the user involved in the transaction.
    public var merchantData: AuthorizationMerchantData?
    /// Additional purchase information that is optionally provided by the merchant. This field is not included by default. To include it in the response, expand the `purchase_details` field.
    public var purchaseDetails: TransactionPurchaseDetails?
    /// The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`.
    public var wallet: TransactionWallet?
    
    public init(id: String,
                amount: Int? = nil,
                authorization: String? = nil,
                card: String? = nil,
                cardholder: String? = nil,
                currency: Currency? = nil,
                metadata: [String : String]? = nil,
                type: TransactionType? = nil,
                object: String,
                amountDetails: TransactionAmountDetails? = nil,
                balanceTransaction: String? = nil,
                created: Date,
                dispute: String? = nil,
                livemode: Bool? = nil,
                merchantAmount: Int? = nil,
                merchantCurrency: Currency? = nil,
                merchantData: AuthorizationMerchantData? = nil,
                purchaseDetails: TransactionPurchaseDetails? = nil,
                wallet: TransactionWallet? = nil) {
        self.id = id
        self.amount = amount
        self._authorization = Expandable(id: authorization)
        self._card = Expandable(id: card)
        self._cardholder = Expandable(id: cardholder)
        self.currency = currency
        self.metadata = metadata
        self.type = type
        self.object = object
        self.amountDetails = amountDetails
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.created = created
        self._dispute = Expandable(id: dispute)
        self.livemode = livemode
        self.merchantAmount = merchantAmount
        self.merchantCurrency = merchantCurrency
        self.merchantData = merchantData
        self.purchaseDetails = purchaseDetails
        self.wallet = wallet
    }
}

public struct TransactionAmountDetails: Codable {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?
    
    public init(atmFee: Int? = nil) {
        self.atmFee = atmFee
    }
}

public struct TransactionList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Transaction]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Transaction]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public enum TransactionType: String, Codable {
    /// Funds were captured by the acquirer. `amount` will be negative as funds are moving out of your balance. Not all captures will be linked to an authorization, as acquirers can force capture in some cases.
    case capture
    /// An acquirer initiated a refund. This transaction might not be linked to an original capture, for example credits are original transactions. `amount` will be positive for refunds and negative for refund reversals.
    case refund
}

public struct TransactionPurchaseDetails: Codable {
    /// Information about the flight that was purchased with this transaction.
    public var flight: TransactionPurchaseDetailsFlight?
    /// Information about fuel that was purchased with this transaction.
    public var fuel: TransactionPurchaseDetailsFuel?
    /// Information about lodging that was purchased with this transaction.
    public var lodging: TransactionPurchaseDetailsLodging?
    /// The line items in the purchase.
    public var receipt: [TransactionPurchaseDetailsReceipt]?
    /// A merchant-specific order number.
    public var reference: String?
    
    public init(flight: TransactionPurchaseDetailsFlight? = nil,
                fuel: TransactionPurchaseDetailsFuel? = nil,
                lodging: TransactionPurchaseDetailsLodging? = nil,
                receipt: [TransactionPurchaseDetailsReceipt]? = nil,
                reference: String? = nil) {
        self.flight = flight
        self.fuel = fuel
        self.lodging = lodging
        self.receipt = receipt
        self.reference = reference
    }
}

public struct TransactionPurchaseDetailsFlight: Codable {
    /// The time that the flight departed.
    public var departureAt: Int?
    /// The name of the passenger.
    public var passengerName: String?
    /// Whether the ticket is refundable.
    public var refundable: Bool?
    /// The legs of the trip.
    public var segments: [TransactionPurchaseDetailsFlightSegment]?
    /// The travel agency that issued the ticket.
    public var travelAgency: String?
    
    public init(departureAt: Int? = nil,
                passengerName: String? = nil,
                refundable: Bool? = nil,
                segments: [TransactionPurchaseDetailsFlightSegment]? = nil,
                travelAgency: String? = nil) {
        self.departureAt = departureAt
        self.passengerName = passengerName
        self.refundable = refundable
        self.segments = segments
        self.travelAgency = travelAgency
    }
}

public struct TransactionPurchaseDetailsFlightSegment: Codable {
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
    
    public init(arrivalAirportCode: String? = nil,
                carrier: String? = nil,
                departureAirportCode: String? = nil,
                flightNumber: String? = nil,
                serviceCLass: String? = nil,
                stopoverAllowed: Bool? = nil) {
        self.arrivalAirportCode = arrivalAirportCode
        self.carrier = carrier
        self.departureAirportCode = departureAirportCode
        self.flightNumber = flightNumber
        self.serviceCLass = serviceCLass
        self.stopoverAllowed = stopoverAllowed
    }
}

public struct TransactionPurchaseDetailsFuel: Codable {
    /// The type of fuel that was purchased. One of `diesel`, `unleaded_plus`, `unleaded_regular`, `unleaded_super`, or `other`.
    public var type: TransactionPurchaseDetailsFuelType?
    /// The units for `volume_decimal`. One of `us_gallon` or `liter`.
    public var unit: TransactionPurchaseDetailsFuelUnit?
    /// The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
    public var unitCostDecimal: String?
    /// The volume of the fuel that was pumped, represented as a decimal string with at most 12 decimal places.
    public var volumeDecimal: String?
    
    public init(type: TransactionPurchaseDetailsFuelType? = nil,
                unit: TransactionPurchaseDetailsFuelUnit? = nil,
                unitCostDecimal: String? = nil,
                volumeDecimal: String? = nil) {
        self.type = type
        self.unit = unit
        self.unitCostDecimal = unitCostDecimal
        self.volumeDecimal = volumeDecimal
    }
}

public enum TransactionPurchaseDetailsFuelType: String, Codable {
    case diesel
    case unleadedPlus = "unleaded_plus"
    case unleadedRegular = "unleaded_regular"
    case unleadedSuper = "unleaded_super"
    case other
}

public enum TransactionPurchaseDetailsFuelUnit: String, Codable {
    case usGallon = "us_gallon"
    case liter
}

public struct TransactionPurchaseDetailsLodging: Codable {
    /// The time of checking into the lodging.
    public var checkInAt: Int?
    /// The number of nights stayed at the lodging.
    public var nights: Int?
    
    public init(checkInAt: Int? = nil, nights: Int? = nil) {
        self.checkInAt = checkInAt
        self.nights = nights
    }
}

public struct TransactionPurchaseDetailsReceipt: Codable {
    /// The description of the item. The maximum length of this field is 26 characters.
    public var description: String?
    /// The quantity of the item.
    public var quantity: Decimal?
    /// The total for this line item in cents.
    public var total: Int?
    /// The unit cost of the item in cents.
    public var unitCost: Int?
    
    public init(description: String? = nil,
                quantity: Decimal? = nil,
                total: Int? = nil,
                unitCost: Int? = nil) {
        self.description = description
        self.quantity = quantity
        self.total = total
        self.unitCost = unitCost
    }
}

public enum TransactionWallet: String, Codable {
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case samsungPay = "samsung_pay"
}
