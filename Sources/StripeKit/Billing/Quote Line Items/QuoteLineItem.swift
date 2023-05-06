//
//  QuoteLineItem.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/25/21.
//

import Foundation

public struct StripeQuoteLineItem: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Total before any discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes.
    public var amountTotal: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.
    public var description: String?
    /// This field is not included by default. To include it in the response, expand the `discounts` field.
    public var discounts: [StripeQuoteLineItemDiscount]?
    /// The price used to generate the line item.
    public var price: Price?
    /// The quantity of products being purchased.
    public var quantity: Int?
    /// The taxes applied to the line item.
    ///
    /// This field is not included by default. To include it in the response, expand the `taxes` field.
    public var taxes: [StripeQuoteLineItemTax]?
}

public struct StripeQuoteLineItemDiscount: Codable {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: Discount?
}

public struct StripeQuoteLineItemTax: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: StripeTaxRate?
}

public struct StripeQuoteLineItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeQuoteLineItem]?
}
