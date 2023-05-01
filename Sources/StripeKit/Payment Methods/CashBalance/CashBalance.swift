//
//  CashBalance.swift
//  
//
//  Created by Andrew Edwards on 5/1/23.
//

import Foundation

/// A customer's `Cash balance` represents real funds. Customers can add funds to their cash balance by sending a bank transfer. These funds can be used for payment and can eventually be paid out to your bank account.
public struct CashBalance: Codable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A hash of all cash balances available to this customer. You cannot delete a customer with any cash balances, even if the balance is 0. Amounts are represented in the smallest currency unit.
    public var available: [String: Int]?
    /// The ID of the customer whose cash balance this object represents.
    public var customer: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// A hash of settings for this cash balance.
    public var settings: CashBalanceSettings?
    
    public init(object: String,
                available: [String: Int]? = nil,
                customer: String? = nil,
                livemode: Bool? = nil,
                settings: CashBalanceSettings? = nil) {
        self.object = object
        self.available = available
        self.customer = customer
        self.livemode = livemode
        self.settings = settings
    }
}

public struct CashBalanceSettings: Codable {
    /// The configuration for how funds that land in the customer cash balance are reconciled.
    public var reconciliationMode: String?
    /// A flag to indicate if reconciliation mode returned is the user’s default or is specific to this customer cash balance.
    public var usingMerchantDefault: Bool?
    
    public init(reconciliationMode: String? = nil, usingMerchantDefault: Bool? = nil) {
        self.reconciliationMode = reconciliationMode
        self.usingMerchantDefault = usingMerchantDefault
    }
}
