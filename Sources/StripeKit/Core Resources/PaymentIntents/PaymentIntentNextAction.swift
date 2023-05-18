//
//  PaymentIntentNextAction.swift
//  
//
//  Created by Andrew Edwards on 3/9/23.
//

import Foundation

public struct PaymentIntentNextActionAlipayHandleRedirect: Codable {
    /// The native data to be used with Alipay SDK you must redirect your customer to in order to authenticate the payment in an Android App.
    public var nativeData: String?
    /// The native URL you must redirect your customer to in order to authenticate the payment in an iOS App.
    public var nativeUrl: String?
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
    
    public init(nativeData: String? = nil,
                nativeUrl: String? = nil,
                returnUrl: String? = nil,
                url: String? = nil) {
        self.nativeData = nativeData
        self.nativeUrl = nativeUrl
        self.returnUrl = returnUrl
        self.url = url
    }
}

public struct PaymentIntentNextActionBoletoDisplayDetails: Codable {
    /// The timestamp after which the boleto expires.
    public var expiresAt: Date?
    /// The URL to the hosted boleto voucher page, which allows customers to view the boleto voucher.
    public var hostedVoucherUrl: String?
    /// The boleto number.
    public var number: String?
    /// The URL to the downloadable boleto voucher PDF.
    public var pdf: String?
    
    public init(expiresAt: Date? = nil,
                hostedVoucherUrl: String? = nil,
                number: String? = nil,
                pdf: String? = nil) {
        self.expiresAt = expiresAt
        self.hostedVoucherUrl = hostedVoucherUrl
        self.number = number
        self.pdf = pdf
    }
}

public struct PaymentIntentNextActionCardAwaitNotification: Codable {
    /// The time that payment will be attempted. If customer approval is required, they need to provide approval before this time.
    public var chargeAttemptAt: Date?
    /// For payments greater than INR 15000, the customer must provide explicit approval of the payment with their bank. For payments of lower amount, no customer action is required.
    public var customerApprovalRequired: Bool?
    
    public init(chargeAttemptAt: Date? = nil, customerApprovalRequired: Bool? = nil) {
        self.chargeAttemptAt = chargeAttemptAt
        self.customerApprovalRequired = customerApprovalRequired
    }
}

public struct PaymentIntentNextActionKonbiniDisplayDetails: Codable {
    /// The timestamp at which the pending Konbini payment expires.
    public var expiresAt: Date?
    /// The URL for the Konbini payment instructions page, which allows customers to view and print a Konbini voucher.
    public var hostedVoucherUrl: String?
    /// Payment instruction details grouped by convenience store chain.
    public var stores: PaymentIntentNextActionKonbiniDisplayDetailsStores?
    
    public init(expiresAt: Date? = nil,
                hostedVoucherUrl: String? = nil,
                stores: PaymentIntentNextActionKonbiniDisplayDetailsStores? = nil) {
        self.expiresAt = expiresAt
        self.hostedVoucherUrl = hostedVoucherUrl
        self.stores = stores
    }
}

public struct PaymentIntentNextActionKonbiniDisplayDetailsStores: Codable {
    /// FamilyMart instruction details.
    public var familymart: PaymentIntentNextActionKonbiniDisplayDetailsStoresFamilyMart?
    /// Lawson instruction details.
    public var lawson: PaymentIntentNextActionKonbiniDisplayDetailsStoresLawson?
    /// Ministop instruction details.
    public var ministop: PaymentIntentNextActionKonbiniDisplayDetailsStoresMinistop?
    /// Seicomart instruction details.
    public var seicomart: PaymentIntentNextActionKonbiniDisplayDetailsStoresSeicomart?

    public init(familymart: PaymentIntentNextActionKonbiniDisplayDetailsStoresFamilyMart? = nil,
                lawson: PaymentIntentNextActionKonbiniDisplayDetailsStoresLawson? = nil,
                ministop: PaymentIntentNextActionKonbiniDisplayDetailsStoresMinistop? = nil,
                seicomart: PaymentIntentNextActionKonbiniDisplayDetailsStoresSeicomart? = nil) {
        self.familymart = familymart
        self.lawson = lawson
        self.ministop = ministop
        self.seicomart = seicomart
    }
}

public struct PaymentIntentNextActionKonbiniDisplayDetailsStoresFamilyMart: Codable {
    /// The confirmation number.
    public var confirmationNumber: String?
    /// The payment code
    public var paymentCode: String?
    
    public init(confirmationNumber: String? = nil, paymentCode: String? = nil) {
        self.confirmationNumber = confirmationNumber
        self.paymentCode = paymentCode
    }
}

public struct PaymentIntentNextActionKonbiniDisplayDetailsStoresLawson: Codable {
    /// The confirmation number.
    public var confirmationNumber: String?
    /// The payment code
    public var paymentCode: String?
    
    public init(confirmationNumber: String? = nil, paymentCode: String? = nil) {
        self.confirmationNumber = confirmationNumber
        self.paymentCode = paymentCode
    }
}

public struct PaymentIntentNextActionKonbiniDisplayDetailsStoresMinistop: Codable {
    /// The confirmation number.
    public var confirmationNumber: String?
    /// The payment code
    public var paymentCode: String?
    
    public init(confirmationNumber: String? = nil, paymentCode: String? = nil) {
        self.confirmationNumber = confirmationNumber
        self.paymentCode = paymentCode
    }
}

public struct PaymentIntentNextActionKonbiniDisplayDetailsStoresSeicomart: Codable {
    /// The confirmation number.
    public var confirmationNumber: String?
    /// The payment code
    public var paymentCode: String?
    
    public init(confirmationNumber: String? = nil, paymentCode: String? = nil) {
        self.confirmationNumber = confirmationNumber
        self.paymentCode = paymentCode
    }
}

public struct PaymentIntentNextActionOXXODisplayDetails: Codable {
    /// The timestamp after which the OXXO voucher expires.
    public var expiresAfter: Date?
    /// The URL for the hosted OXXO voucher page, which allows customers to view and print an OXXO voucher.
    public var hostedVoucherUrl: String?
    /// OXXO reference number.
    public var number: String?
    
    public init(expiresAfter: Date? = nil,
                hostedVoucherUrl: String? = nil,
                number: String? = nil) {
        self.expiresAfter = expiresAfter
        self.hostedVoucherUrl = hostedVoucherUrl
        self.number = number
    }
}

public struct PaymentIntentNextActionPaynowDisplayQRCode: Codable {
    /// The raw data string used to generate QR code, it should be used together with QR code library.
    public var data: String?
    /// The URL to the hosted PayNow instructions page, which allows customers to view the PayNow QR code.
    public var hostedInstructionsUrl: String?
    /// The `image_url_png` string used to render QR code
    public var imageUrlPng: String?
    /// The `image_url_svg` string used to render QR code
    public var imageUrlSvg: String?
    
    public init(data: String? = nil,
                hostedInstructionsUrl: String? = nil,
                imageUrlPng: String? = nil,
                imageUrlSvg: String? = nil) {
        self.data = data
        self.hostedInstructionsUrl = hostedInstructionsUrl
        self.imageUrlPng = imageUrlPng
        self.imageUrlSvg = imageUrlSvg
    }
}

public struct PaymentIntentNextActionPromptPayDisplayQRCode: Codable {
    /// The raw data string used to generate QR code, it should be used together with QR code library.
    public var data: String?
    /// The URL to the hosted PromptPay instructions page, which allows customers to view the PromptPay QR code.
    public var hostedInstructionsUrl: String?
    /// The PNG path used to render the QR code, can be used as the source in an HTML img tag
    public var imageUrlPng: String?
    /// The SVG path used to render the QR code, can be used as the source in an HTML img tag
    public var imageUrlSvg: String?
    
    public init(data: String? = nil,
                hostedInstructionsUrl: String? = nil,
                imageUrlPng: String? = nil,
                imageUrlSvg: String? = nil) {
        self.data = data
        self.hostedInstructionsUrl = hostedInstructionsUrl
        self.imageUrlPng = imageUrlPng
        self.imageUrlSvg = imageUrlSvg
    }
}

public struct PaymentIntentNextActionRedirectToUrl: Codable {
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
    
    public init(returnUrl: String? = nil, url: String? = nil) {
        self.returnUrl = returnUrl
        self.url = url
    }
}

public enum PaymentIntentNextActionType: String, Codable {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
    case alipayHandleRedirect = "alipay_handle_redirect"
    case oxxoDisplayDetails = "oxxo_display_details"
    case verifyWithMicrodeposits = "verify_with_microdeposits"
}

public struct PaymentIntentNextActionVerifyWithMicrodeposits: Codable {
    /// The timestamp when the microdeposits are expected to land.
    public var arrivalDate: Date?
    /// The URL for the hosted verification page, which allows customers to verify their bank account.
    public var hostedVerificationUrl: String?
    /// The type of the microdeposit sent to the customer. Used to distinguish between different verification methods.
    public var microdepositType: PaymentIntentNextActionVerifyWithMicrodepositsType?
    
    public init(arrivalDate: Date? = nil,
                hostedVerificationUrl: String? = nil,
                microdepositType: PaymentIntentNextActionVerifyWithMicrodepositsType? = nil) {
        self.arrivalDate = arrivalDate
        self.hostedVerificationUrl = hostedVerificationUrl
        self.microdepositType = microdepositType
    }
}

public enum PaymentIntentNextActionVerifyWithMicrodepositsType: String, Codable {
    case descriptorCode = "descriptor_code"
    case amounts
}

public struct PaymentIntentNextActionWechatPayQRCode: Codable {
    /// The data being used to generate QR code
    public var data: String?
    /// The URL to the hosted WeChat Pay instructions page, which allows customers to view the WeChat Pay QR code.
    public var hostedInstructionsUrl: String?
    /// The base64 image data for a pre-generated QR code
    public var imageDataUrl: String?
    /// The `image_url_png` string used to render QR code
    public var imageUrlPng: String?
    /// The `image_url_svg` string used to render QR code
    public var imageUrlSvg: String?
    
    public init(data: String? = nil,
                hostedInstructionsUrl: String? = nil,
                imageDataUrl: String? = nil,
                imageUrlPng: String? = nil,
                imageUrlSvg: String? = nil) {
        self.data = data
        self.hostedInstructionsUrl = hostedInstructionsUrl
        self.imageDataUrl = imageDataUrl
        self.imageUrlPng = imageUrlPng
        self.imageUrlSvg = imageUrlSvg
    }
}

public struct PaymentIntentNextActionWechatPayAndroidApp: Codable {
    /// `app_id` is the APP ID registered on WeChat open platform
    public var appId: String?
    /// `nonce_str` is a random string
    public var nonceStr: String?
    /// Package is static value
    public var package: String?
    /// A unique merchant ID assigned by Wechat Pay
    public var partnerId: String?
    /// A unique trading ID assigned by Wechat Pay
    public var prepayId: String?
    /// A signature
    public var sign: String?
    /// Specifies the current time in epoch format
    public var timestamp: String?
    
    public init(appId: String? = nil,
                nonceStr: String? = nil,
                package: String? = nil,
                partnerId: String? = nil,
                prepayId: String? = nil,
                sign: String? = nil,
                timestamp: String? = nil) {
        self.appId = appId
        self.nonceStr = nonceStr
        self.package = package
        self.partnerId = partnerId
        self.prepayId = prepayId
        self.sign = sign
        self.timestamp = timestamp
    }
}

public struct PaymentIntentNextActionWechatPayIOSApp: Codable {
    /// An universal link that redirect to Wechat Pay APP
    public var nativeUrl: String?
    
    public init(nativeUrl: String? = nil) {
        self.nativeUrl = nativeUrl
    }
}
