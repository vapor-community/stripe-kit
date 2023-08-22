//
//  PaymentMethod.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

import Foundation

/// The [PaymentMethod Object](https://stripe.com/docs/api/payment_methods/object) .
public struct PaymentMethod: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    public var billingDetails: BillingDetails?
    /// The ID of the Customer to which this PaymentMethod is saved. This will not be set when the PaymentMethod has not been saved to a Customer.
    @Expandable<Customer> public var customer: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
    public var type: PaymentMethodType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// If this is an `acss_debit` PaymentMethod, this hash contains details about the ACSS Debit payment method.
    public var acssDebit: PaymentMethodAcssDebit?
    /// If this is an AfterpayClearpay PaymentMethod, this hash contains details about the AfterpayClearpay payment method.
    public var afterpayClearpay: PaymentMethodAfterpayClearpay?
    /// If this is an Alipay PaymentMethod, this hash contains details about the Alipay payment method.
    public var alipay: PaymentMethodAlipay?
    /// If this is an `au_becs_debit` PaymentMethod, this hash contains details about the bank account.
    public var auBecsDebit: PaymentMethodAuBecsDebit?
    /// If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
    public var bacsDebit: PaymentMethodBacsDebit?
    /// If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
    public var bancontact: PaymentMethodBancontact?
    /// If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method.
    public var boleto: PaymentMethodBoleto?
    /// If this is a `card` PaymentMethod, this hash contains details about the card.
    public var card: PaymentMethodCard?
    /// If this is an `card_present` PaymentMethod, this hash contains details about the Card Present payment method.
    public var cardPresent: PaymentMethodCardPresent?
    /// If this is a `cashapp` PaymentMethod, this hash contains details about the Cash App Pay payment method.
    public var cashapp: PaymentMethodCashapp?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If this is a `customer_balance` PaymentMethod, this hash contains details about the CustomerBalance payment method.
    public var customerBalance: PaymentMethodCustomerBalance?
    /// If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method.
    public var eps: PaymentMethodEps?
    /// If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method.
    public var fpx: PaymentMethodFpx?
    /// If this is an `giropay` PaymentMethod, this hash contains details about the Giropay payment method.
    public var giropay: PaymentMethodGiropay?
    /// If this is a `grabpay` PaymentMethod, this hash contains details about the GrabPay payment method.
    public var grabpay: PaymentMethodGrabpay?
    /// If this is an `ideal` PaymentMethod, this hash contains details about the iDEAL payment method.
    public var ideal: PaymentMethodIdeal?
    /// If this is an `interac_present` PaymentMethod, this hash contains details about the Interac Present payment method.
    public var interacPresent: PaymentMethodInteractPresent?
    /// If this is a `klarna` PaymentMethod, this hash contains details about the Klarna payment method.
    public var klarna: PaymentMethodKlarna?
    /// If this is a `konbini` PaymentMethod, this hash contains details about the Konbini payment method.
    public var konbini: PaymentMethodKonbini?
    /// If this is a `link` PaymentMethod, this hash contains details about the Link payment method.
    public var link: PaymentMethodLink?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// If this is an `oxxo` PaymentMethod, this hash contains details about the OXXO payment method.
    public var oxxo: PaymentMethodOXXO?
    /// If this is a `p24` PaymentMethod, this hash contains details about the P24 payment method.
    public var p24: PaymentMethodP24?
    /// If this is a`paynow` PaymentMethod, this hash contains details about the PayNow payment method.
    public var paynow: PaymentMethodPaynow?
    /// If this is a `pix` PaymentMethod, this hash contains details about the Pix payment method.
    public var pix: PaymentMethodPix?
    /// If this is a `promptpay` PaymentMethod, this hash contains details about the PromptPay payment method.
    public var promptpay: PaymentMethodPromptPay?
    /// Options to configure Radar. See Radar Session for more information.
    public var radarOptions: PaymentMethodRadarOptions?
    /// If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    public var sepaDebit: PaymentMethodSepaDebit?
    /// If this is a sofort PaymentMethod, this hash contains details about the SOFORT payment method.
    public var sofort: PaymentMethodSofort?
    /// If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method.
    public var usBankAccount: PaymentMethodUSBankAccount?
    /// If this is an `wechat_pay` PaymentMethod, this hash contains details about the `wechat_pay` payment method.
    public var wechatPay: PaymentMethodWechatPay?
    
    public init(id: String,
                billingDetails: BillingDetails? = nil,
                customer: String? = nil,
                metadata: [String : String]? = nil,
                type: PaymentMethodType? = nil,
                object: String,
                acssDebit: PaymentMethodAcssDebit? = nil,
                afterpayClearpay: PaymentMethodAfterpayClearpay? = nil,
                alipay: PaymentMethodAlipay? = nil,
                auBecsDebit: PaymentMethodAuBecsDebit? = nil,
                bacsDebit: PaymentMethodBacsDebit? = nil,
                bancontact: PaymentMethodBancontact? = nil,
                boleto: PaymentMethodBoleto? = nil,
                card: PaymentMethodCard? = nil,
                cardPresent: PaymentMethodCardPresent? = nil,
                cashapp: PaymentMethodCashapp? = nil,
                created: Date,
                customerBalance: PaymentMethodCustomerBalance? = nil,
                eps: PaymentMethodEps? = nil,
                fpx: PaymentMethodFpx? = nil,
                giropay: PaymentMethodGiropay? = nil,
                grabpay: PaymentMethodGrabpay? = nil,
                ideal: PaymentMethodIdeal? = nil,
                interacPresent: PaymentMethodInteractPresent? = nil,
                klarna: PaymentMethodKlarna? = nil,
                konbini: PaymentMethodKonbini? = nil,
                link: PaymentMethodLink? = nil,
                livemode: Bool? = nil,
                oxxo: PaymentMethodOXXO? = nil,
                p24: PaymentMethodP24? = nil,
                paynow: PaymentMethodPaynow? = nil,
                pix: PaymentMethodPix? = nil,
                promptpay: PaymentMethodPromptPay? = nil,
                radarOptions: PaymentMethodRadarOptions? = nil,
                sepaDebit: PaymentMethodSepaDebit? = nil,
                sofort: PaymentMethodSofort? = nil,
                usBankAccount: PaymentMethodUSBankAccount? = nil,
                wechatPay: PaymentMethodWechatPay? = nil) {
        self.id = id
        self.billingDetails = billingDetails
        self._customer = Expandable(id: customer)
        self.metadata = metadata
        self.type = type
        self.object = object
        self.acssDebit = acssDebit
        self.afterpayClearpay = afterpayClearpay
        self.alipay = alipay
        self.auBecsDebit = auBecsDebit
        self.bacsDebit = bacsDebit
        self.bancontact = bancontact
        self.boleto = boleto
        self.card = card
        self.cardPresent = cardPresent
        self.cashapp = cashapp
        self.created = created
        self.customerBalance = customerBalance
        self.eps = eps
        self.fpx = fpx
        self.giropay = giropay
        self.grabpay = grabpay
        self.ideal = ideal
        self.interacPresent = interacPresent
        self.klarna = klarna
        self.konbini = konbini
        self.link = link
        self.livemode = livemode
        self.oxxo = oxxo
        self.p24 = p24
        self.paynow = paynow
        self.pix = pix
        self.promptpay = promptpay
        self.radarOptions = radarOptions
        self.sepaDebit = sepaDebit
        self.sofort = sofort
        self.usBankAccount = usBankAccount
        self.wechatPay = wechatPay
    }
}

public enum PaymentMethodType: String, Codable {
    case acssDebit = "acss_debit"
    case affirm
    case afterpayClearpay = "afterpay_clearpay"
    case alipay
    case auBecsDebit = "au_becs_debit"
    case bacsDebit = "bacs_debit"
    case bancontact
    case blik
    case boleto
    case card
    case cardPresent = "card_present"
    case cashapp
    case customerBalance = "customer_balance"
    case eps
    case fpx
    case giropay
    case grabpay
    case ideal
    case interactPresent = "interact_present"
    case klarna
    case konbini
    case link
    case oxxo
    case p24
    case paynow
    case pix
    case promptpay
    case sepaDebit = "sepa_debit"
    case sofort
    case usBankAccount = "us_bank_account"
    case wechatPay = "wechat_pay"
}

public struct PaymentMethodRadarOptions: Codable {
    /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
    public var session: String?
    
    public init(session: String? = nil) {
        self.session = session
    }
}

public struct PaymentMethodList: Codable {
    public var object: String
    public var data: [PaymentMethod]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [PaymentMethod]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
