//
//  PaymentMethodRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/1/19.
//

import NIO
import NIOHTTP1

public protocol PaymentMethodRoutes: StripeAPIRoute {
    /// Creates a PaymentMethod object. Read the Stripe.js reference to learn how to create PaymentMethods via Stripe.js.
    ///
    /// - Parameters:
    ///   - type: The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type. Required unless `payment_method` is specified (see the Shared PaymentMethods guide)
    ///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - acssDebit: If this is an `acss_debit` PaymentMethod, this hash contains details about the ACSS Debit payment method.
    ///   - affirm: If this is an `affirm` PaymentMethod, this hash contains details about the Affirm payment method.
    ///   - afterpayClearpay: If this is an AfterpayClearpay PaymentMethod, this hash contains details about the AfterpayClearpay payment method.
    ///   - alipay: If this is an Alipay PaymentMethod, this hash contains details about the Alipay payment method.
    ///   - auBecsDebit: If this is an `au_becs_debit` PaymentMethod, this hash contains details about the bank account.
    ///   - bacsDebit: If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
    ///   - bancontact: If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
    ///   - blik: If this is a `blik` PaymentMethod, this hash contains details about the BLIK payment method.
    ///   - boleto: If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method.
    ///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
    ///   - cashapp: If this is a `cashapp` PaymentMethod, this hash contains details about the Cash App Pay payment method.
    ///   - customerBalance: If this is a `customer_balance` PaymentMethod, this hash contains details about the CustomerBalance payment method.
    ///   - eps: If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method.
    ///   - fpx: If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method.
    ///   - giropay: If this is an `giropay` PaymentMethod, this hash contains details about the Giropay payment method.
    ///   - grabpay: If this is a `grabpay` PaymentMethod, this hash contains details about the GrabPay payment method.
    ///   - ideal: If this is an ideal PaymentMethod, this hash contains details about the iDEAL payment method.
    ///   - interacPresent: If this is an `interac_present` PaymentMethod, this hash contains details about the Interac Present payment method.
    ///   - klarna: If this is a klarna PaymentMethod, this hash contains details about the Klarna payment method.
    ///   - konbini: If this is a konbini PaymentMethod, this hash contains details about the Konbini payment method.
    ///   - link: If this is an Link PaymentMethod, this hash contains details about the Link payment method.
    ///   - oxxo: If this is an oxxo PaymentMethod, this hash contains details about the OXXO payment method.
    ///   - p24: If this is an `p24` PaymentMethod, this hash contains details about the P24 payment method.
    ///   - paynow: If this is a paynow PaymentMethod, this hash contains details about the PayNow payment method.
    ///   - pix: If this is a pix PaymentMethod, this hash contains details about the Pix payment method.
    ///   - promptpay: If this is a promptpay PaymentMethod, this hash contains details about the PromptPay payment method.
    ///   - radarOptions: Options to configure Radar. See Radar Session for more information.
    ///   - sepaDebit: If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    ///   - sofort: If this is a sofort PaymentMethod, this hash contains details about the SOFORT payment method.
    ///   - usBankAccount: If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method.
    ///   - wechatPay: If this is a `wechat_pay` PaymentMethod, this hash contains details about the `wechat_pay` payment method.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePaymentMethod`.
    func create(type: PaymentMethodType,
                billingDetails: [String: Any]?,
                metadata: [String: String]?,
                acssDebit: [String: Any]?,
                affirm: [String: Any]?,
                afterpayClearpay: [String: Any]?,
                alipay: [String: Any]?,
                auBecsDebit: [String: Any]?,
                bacsDebit: [String: Any]?,
                bancontact: [String: Any]?,
                blik: [String: Any]?,
                boleto: [String: Any]?,
                card: [String: Any]?,
                cashapp: [String: Any]?,
                customerBalance: [String: Any]?,
                eps: [String: Any]?,
                fpx: [String: Any]?,
                giropay: [String: Any]?,
                grabpay: [String: Any]?,
                ideal: [String: Any]?,
                interacPresent: [String: Any]?,
                klarna: [String: Any]?,
                konbini: [String: Any]?,
                link: [String: Any]?,
                oxxo: [String: Any]?,
                p24: [String: Any]?,
                paynow: [String: Any]?,
                pix: [String: Any]?,
                promptpay: [String: Any]?,
                radarOptions: [String: Any]?,
                sepaDebit: [String: Any]?,
                sofort: [String: Any]?,
                usBankAccount: [String: Any]?,
                wechatPay: [String: Any]?,
                expand: [String]?) async throws -> PaymentMethod
        
    /// Retrieves a PaymentMethod object.
    ///
    /// - Parameters:
    ///   - paymentMethod: The ID of the PaymentMethod.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a PaymentMethod object.
    func retrieve(paymentMethod: String, expand: [String]?) async throws -> PaymentMethod
    
    /// Updates a PaymentMethod object. A PaymentMethod must be attached a customer to be updated.
    ///
    /// - Parameters:
    ///   - paymentMethod: The ID of the PaymentMethod to be updated.
    ///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details.
    ///   - link: If this is a `link` PaymentMethod, this hash contains details about the Link payment method.
    ///   - usBankAccount: If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a PaymentMethod object.
    func update(paymentMethod: String,
                billingDetails: [String: Any]?,
                metadata: [String: String]?,
                card: [String: Any]?,
                link: [String: Any]?,
                usBankAccount: [String: Any]?,
                expand: [String]?) async throws -> PaymentMethod
    
    /// Returns a list of PaymentMethods for a given Customer
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose PaymentMethods will be retrieved.
    ///   - type: A required filter on the list, based on the object type field.
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/payment_methods/list)
    /// - Returns: A dictionary with a data property that contains an array of up to limit PaymentMethods of type type, starting after PaymentMethods `starting_after`. Each entry in the array is a separate PaymentMethod object. If no more PaymentMethods are available, the resulting array will be empty. This request should never return an error.
    func listAll(customer: String,
                 type: PaymentMethodType?,
                 filter: [String: Any]?) async throws -> PaymentMethodList
    
    /// Attaches a PaymentMethod object to a Customer.
    ///
    /// To attach a new PaymentMethod to a customer for future payments, we recommend you use a SetupIntent or a PaymentIntent with `setup_future_usage`. These approaches will perform any necessary steps to set up the PaymentMethod for future payments. Using the `/v1/payment_methods/:id/attach` endpoint without first using a SetupIntent or PaymentIntent with `setup_future_usage` does not optimize the PaymentMethod for future use, which makes later declines and payment friction more likely. See Optimizing cards for future payments for more information about setting up future payments.
    ///
    /// To use this PaymentMethod as the default for invoice or subscription payments, set `invoice_settings.default_payment_method`, on the Customer to the PaymentMethod’s ID.
    /// - Parameters:
    ///   - paymentMethod: The PaymentMethod to attach to the customer.
    ///   - customer: The ID of the customer to which to attach the PaymentMethod.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a PaymentMethod object.
    func attach(paymentMethod: String, customer: String, expand: [String]?) async throws -> PaymentMethod
    
    /// Detaches a PaymentMethod object from a Customer. After a PaymentMethod is detached, it can no longer be used for a payment or re-attached to a Customer.
    ///
    /// - Parameters:
    ///   - paymentMethod: The PaymentMethod to detach from the customer.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a PaymentMethod object.
    func detach(paymentMethod: String, expand: [String]?) async throws -> PaymentMethod
}

public struct StripePaymentMethodRoutes: PaymentMethodRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let paymentmethods = APIBase + APIVersion + "payment_methods"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: PaymentMethodType,
                       billingDetails: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       acssDebit: [String: Any]? = nil,
                       affirm: [String: Any]? = nil,
                       afterpayClearpay: [String: Any]? = nil,
                       alipay: [String: Any]? = nil,
                       auBecsDebit: [String: Any]? = nil,
                       bacsDebit: [String: Any]? = nil,
                       bancontact: [String: Any]? = nil,
                       blik: [String: Any]? = nil,
                       boleto: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       cashapp: [String: Any]? = nil,
                       customerBalance: [String: Any]? = nil,
                       eps: [String: Any]? = nil,
                       fpx: [String: Any]? = nil,
                       giropay: [String: Any]? = nil,
                       grabpay: [String: Any]? = nil,
                       ideal: [String: Any]? = nil,
                       interacPresent: [String: Any]? = nil,
                       klarna: [String: Any]? = nil,
                       konbini: [String: Any]? = nil,
                       link: [String: Any]? = nil,
                       oxxo: [String: Any]? = nil,
                       p24: [String: Any]? = nil,
                       paynow: [String: Any]? = nil,
                       pix: [String: Any]? = nil,
                       promptpay: [String: Any]? = nil,
                       radarOptions: [String: Any]? = nil,
                       sepaDebit: [String: Any]? = nil,
                       sofort: [String: Any]? = nil,
                       usBankAccount: [String: Any]? = nil,
                       wechatPay: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> PaymentMethod {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let billingDetails {
            billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let acssDebit {
            acssDebit.forEach { body["acss_debit[\($0)]"] = $1 }
        }
        
        if let affirm {
            affirm.forEach { body["affirm[\($0)]"] = $1 }
        }
        
        if let afterpayClearpay {
            afterpayClearpay.forEach { body["afterpay_clearpay[\($0)]"] = $1 }
        }
        
        if let alipay {
            alipay.forEach { body["alipay[\($0)]"] = $1 }
        }
        
        if let auBecsDebit {
            auBecsDebit.forEach { body["au_becs_debit[\($0)]"] = $1 }
        }
        
        if let bacsDebit {
            bacsDebit.forEach { body["bacs_debit[\($0)]"] = $1 }
        }
        
        if let bancontact {
            bancontact.forEach { body["bancontact[\($0)]"] = $1 }
        }
        
        if let blik {
            blik.forEach { body["blik[\($0)]"] = $1 }
        }
        
        if let boleto {
            boleto.forEach { body["boleto[\($0)]"] = $1 }
        }
        
        if let card {
            card.forEach { body["card[\($0)]"] = $1 }
        }
        
        if let cashapp {
            cashapp.forEach { body["cashapp[\($0)]"] = $1 }
        }
        
        if let customerBalance {
            customerBalance.forEach { body["customer_balance[\($0)]"] = $1 }
        }
        
        if let eps {
            eps.forEach { body["eps[\($0)]"] = $1 }
        }
        
        if let fpx {
            fpx.forEach { body["fpx[\($0)]"] = $1 }
        }
        
        if let giropay {
            giropay.forEach { body["giropay[\($0)]"] = $1 }
        }
        
        if let grabpay {
            grabpay.forEach { body["grabpay[\($0)]"] = $1 }
        }
        
        if let ideal {
            ideal.forEach { body["ideal[\($0)]"] = $1 }
        }
        
        if let interacPresent {
            interacPresent.forEach { body["interac_present[\($0)]"] = $1 }
        }
        
        if let klarna {
            klarna.forEach { body["klarna[\($0)]"] = $1 }
        }
        
        if let konbini {
            konbini.forEach { body["konbini[\($0)]"] = $1 }
        }
        
        if let link {
            link.forEach { body["link[\($0)]"] = $1 }
        }
        
        if let oxxo {
            oxxo.forEach { body["oxxo[\($0)]"] = $1 }
        }
        
        if let p24 {
            p24.forEach { body["p24[\($0)]"] = $1 }
        }
        
        if let paynow {
            paynow.forEach { body["paynow[\($0)]"] = $1 }
        }
        
        if let pix {
            pix.forEach { body["pix[\($0)]"] = $1 }
        }
        
        if let promptpay {
            promptpay.forEach { body["promptpay[\($0)]"] = $1 }
        }
        
        if let radarOptions {
            radarOptions.forEach { body["radar_options[\($0)]"] = $1 }
        }
        
        if let sepaDebit {
            sepaDebit.forEach { body["sepa_debit[\($0)]"] = $1 }
        }
        
        if let sofort {
            sofort.forEach { body["sofort[\($0)]"] = $1 }
        }
        
        if let usBankAccount {
            usBankAccount.forEach { body["us_bank_account[\($0)]"] = $1 }
        }
        
        if let wechatPay {
            wechatPay.forEach { body["wechat_pay[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: paymentmethods, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(paymentMethod: String, expand: [String]? = nil) async throws -> PaymentMethod {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(paymentmethods)/\(paymentMethod)", query: queryParams, headers: headers)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       card: [String: Any]? = nil,
                       link: [String: Any]? = nil,
                       usBankAccount: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> PaymentMethod {
        
        var body: [String: Any] = [:]
        
        if let billingDetails {
            billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let card {
            card.forEach { body["card[\($0)]"] = $1 }
        }
        
        if let link {
            link.forEach { body["link[\($0)]"] = $1 }
        }
        
        if let usBankAccount {
            usBankAccount.forEach { body["us_bank_account[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(customer: String,
                        type: PaymentMethodType? = nil,
                        filter: [String: Any]? = nil) async throws -> PaymentMethodList {
        var queryParams = "customer=\(customer)"
        
        if let type {
            queryParams += "&type=\(type.rawValue)"
        }
        
        if let filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: paymentmethods, query: queryParams, headers: headers)
    }
    
    public func attach(paymentMethod: String, customer: String, expand: [String]? = nil) async throws -> PaymentMethod {
        var body: [String: Any] = ["customer": customer]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)/attach", body: .string(body.queryParameters), headers: headers)
    }
    
    public func detach(paymentMethod: String, expand: [String]? = nil) async throws -> PaymentMethod {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)/detach", body: .string(body.queryParameters), headers: headers)
    }
}
