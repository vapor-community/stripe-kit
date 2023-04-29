//
//  SetupIntent.swift
//  
//
//  Created by Andrew Edwards on 11/28/19.
//

import Foundation

/// The [SetupIntent Object](https://stripe.com/docs/api/setup_intents/object) .
public struct SetupIntent: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The client secret of this SetupIntent. Used for client-side retrieval using a publishable key. The client secret can be used to complete payment setup from your frontend. It should not be stored, logged, embedded in URLs, or exposed to anyone other than the customer. Make sure that you have TLS enabled on any page that includes the client secret.
    public var clientSecret: String?
    /// ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods attached to other Customers cannot be used with this SetupIntent.
    @Expandable<Customer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// The error encountered in the previous SetupIntent confirmation.
    public var lastSetupError: StripeError?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If present, this property tells you what actions you need to take in order for your customer to continue payment setup.
    public var nextAction: SetupIntentNextAction?
    /// ID of the payment method used with this SetupIntent.
    @Expandable<StripePaymentMethod> public var paymentMethod: String?
    /// The list of payment method types (e.g. card) that this SetupIntent is allowed to set up.
    public var paymentMethodTypes: [String]?
    /// Status of this SetupIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `canceled`, or `succeeded`.
    public var status: SetupIntentStatus?
    /// Indicates how the payment method is intended to be used in the future.
    /// Use `on_session` if you intend to only reuse the payment method when the customer is in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. If not provided, this value defaults to `off_session`.
    public var usage: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the Connect application that created the SetupIntent.
    public var application: String?
    /// If present, the SetupIntent’s payment method will be attached to the in-context Stripe Account.
    /// It can only be used for this Stripe Account’s own money movement flows like InboundTransfer and OutboundTransfers. It cannot be set to true when setting up a PaymentMethod for a Customer, and defaults to false when attaching a PaymentMethod to a Customer.
    public var attachToSelf: Bool?
    /// Settings for automatic payment methods compatible with this Setup Intent
    public var automaticPaymentMethods: SetupIntentAutomaticPaymentMethods?
    /// Reason for cancellation of this SetupIntent, one of `abandoned`, `requested_by_customer`, or `duplicate`.
    public var cancellationReason: SetupIntentCancellationReason?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Indicates the directions of money movement for which this payment method is intended to be used.
    /// Include inbound if you intend to use the payment method as the origin to pull funds from. Include outbound if you intend to use the payment method as the destination to send funds to. You can include both if you intend to use the payment method for both purposes.
    public var flowDirections: [String]?
    /// The most recent SetupAttempt for this SetupIntent.
    @Expandable<SetupAttempt> public var latestAttempt: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// ID of the multi use Mandate generated by the SetupIntent.
    @Expandable<Mandate> public var mandate: String?
    /// The account (if any) for which the setup is intended.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// Payment-method-specific configuration for this SetupIntent.
    public var paymentMethodOptions: SetupIntentPaymentMethodOptions?
    /// ID of the `single_use` Mandate generated by the SetupIntent.
    @Expandable<Mandate> public var singleUseMandate: String?
    
    public init(id: String,
                clientSecret: String? = nil,
                customer: String? = nil,
                description: String? = nil,
                lastSetupError: StripeError? = nil,
                metadata: [String : String]? = nil,
                nextAction: SetupIntentNextAction? = nil,
                paymentMethod: String? = nil,
                paymentMethodTypes: [String]? = nil,
                status: SetupIntentStatus? = nil,
                usage: String? = nil,
                object: String,
                application: String? = nil,
                attachToSelf: Bool? = nil,
                automaticPaymentMethods: SetupIntentAutomaticPaymentMethods? = nil,
                cancellationReason: SetupIntentCancellationReason? = nil,
                created: Date,
                flowDirections: [String]? = nil,
                latestAttempt: String? = nil,
                livemode: Bool? = nil,
                mandate: String? = nil,
                onBehalfOf: String? = nil,
                paymentMethodOptions: SetupIntentPaymentMethodOptions,
                singleUseMandate: String? = nil) {
        self.id = id
        self.clientSecret = clientSecret
        self._customer = Expandable(id: customer)
        self.description = description
        self.lastSetupError = lastSetupError
        self.metadata = metadata
        self.nextAction = nextAction
        self._paymentMethod = Expandable(id: paymentMethod)
        self.paymentMethodTypes = paymentMethodTypes
        self.status = status
        self.usage = usage
        self.object = object
        self.application = application
        self.attachToSelf = attachToSelf
        self.automaticPaymentMethods = automaticPaymentMethods
        self.cancellationReason = cancellationReason
        self.created = created
        self.flowDirections = flowDirections
        self._latestAttempt = Expandable(id: latestAttempt)
        self.livemode = livemode
        self._mandate = Expandable(id: mandate)
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self.paymentMethodOptions = paymentMethodOptions
        self._singleUseMandate = Expandable(id: singleUseMandate)
    }
}

public enum SetupIntentCancellationReason: String, Codable {
    case abandoned
    case requestedByCustomer = "requested_by_customer"
    case duplicate
}

public struct SetupIntentNextAction: Codable {
    /// The field that contains Cash App Pay QR code info
    public var cashappHandleRedirectOrDisplayQrCode: SetupIntentNextActionCashappHandleRedirectOrDisplayQrCode?
    /// Contains instructions for authenticating by redirecting your customer to another page or application.
    public var redirectToUrl: SetupIntentNextActionRedirectToUrl?
    /// Type of the next action to perform, one of `redirect_to_url`, `use_stripe_sdk`, `alipay_handle_redirect`, `oxxo_display_details`, or `verify_with_microdeposits`.
    public var type: SetupIntentNextActionType?
    /// Contains details describing microdeposits verification flow.
    public var verifyWithMicrodeposits: SetupIntentNextActionVerifyMicroDeposits?
    
    public init(cashappHandleRedirectOrDisplayQrCode: SetupIntentNextActionCashappHandleRedirectOrDisplayQrCode? = nil,
                redirectToUrl: SetupIntentNextActionRedirectToUrl? = nil,
                type: SetupIntentNextActionType? = nil,
                verifyWithMicrodeposits: SetupIntentNextActionVerifyMicroDeposits? = nil) {
        self.cashappHandleRedirectOrDisplayQrCode = cashappHandleRedirectOrDisplayQrCode
        self.redirectToUrl = redirectToUrl
        self.type = type
        self.verifyWithMicrodeposits = verifyWithMicrodeposits
    }
}

public struct SetupIntentNextActionCashappHandleRedirectOrDisplayQrCode: Codable {
    /// The URL to the hosted Cash App Pay instructions page, which allows customers to view the QR code, and supports QR code refreshing on expiration.
    public var hostedInstructionsUrl: String?
    /// The url for mobile redirect based auth
    public var mobileAuthUrl: String?
    /// The field that contains CashApp QR code info
    public var qrCode: SetupIntentNextActionCashappQrCode?
    
    public init(hostedInstructionsUrl: String? = nil,
                mobileAuthUrl: String? = nil,
                qrCode: SetupIntentNextActionCashappQrCode? = nil) {
        self.hostedInstructionsUrl = hostedInstructionsUrl
        self.mobileAuthUrl = mobileAuthUrl
        self.qrCode = qrCode
    }
}

public struct SetupIntentNextActionCashappQrCode: Codable {
    /// The date (unix timestamp) when the QR code expires.
    public var expiresAt: Date?
    /// The `image_url_png` string used to render QR code
    public var imageUrlPng: String?
    /// The `image_url_svg` string used to render QR code
    public var imageUrlSvg: String?
    
    public init(expiresAt: Date? = nil,
                imageUrlPng: String? = nil,
                imageUrlSvg: String? = nil) {
        self.expiresAt = expiresAt
        self.imageUrlPng = imageUrlPng
        self.imageUrlSvg = imageUrlSvg
    }
}

public struct SetupIntentNextActionRedirectToUrl: Codable {
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
    
    public init(returnUrl: String? = nil, url: String? = nil) {
        self.returnUrl = returnUrl
        self.url = url
    }
}

public enum SetupIntentNextActionType: String, Codable {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
    case alipayHandleRedirect = "alipay_handle_redirect"
    case oxxoDisplayDetails = "oxxo_display_details"
    case verifyWithMicrodeposits = "verify_with_microdeposits"
}

public struct SetupIntentNextActionVerifyMicroDeposits: Codable {
    /// The timestamp when the microdeposits are expected to land.
    public var arrivalDate: Date?
    /// The URL for the hosted verification page, which allows customers to verify their bank account.
    public var hostedVerificationUrl: String?
    /// The type of the microdeposit sent to the customer. Used to distinguish between different verification methods.
    public var microdepositType: SetupIntentNextActionVerifyMicroDepositType?
    
    public init(arrivalDate: Date? = nil,
                hostedVerificationUrl: String? = nil,
                microdepositType: SetupIntentNextActionVerifyMicroDepositType? = nil) {
        self.arrivalDate = arrivalDate
        self.hostedVerificationUrl = hostedVerificationUrl
        self.microdepositType = microdepositType
    }
}

public enum SetupIntentNextActionVerifyMicroDepositType: String, Codable {
    case descriptorCode = "descriptor_code"
    case amounts
}

public struct SetupIntentAutomaticPaymentMethods: Codable {
    /// Automatically calculates compatible payment methods
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public enum SetupIntentStatus: String, Codable {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case canceled
    case succeeded
}

public struct SetupIntentsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [SetupIntent]?
}
