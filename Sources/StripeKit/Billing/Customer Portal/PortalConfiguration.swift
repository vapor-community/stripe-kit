//
//  PortalConfiguration.swift
//  
//
//  Created by Andrew Edwards on 2/25/21.
//

import Foundation

public struct PortalConfiguration: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the configuration is active and can be used to create portal sessions.
    public var active: Bool?
    /// ID of the Connect Application that created the configuration.
    public var application: String?
    /// The business information shown to customers in the portal.
    public var businessProfile: PortalConfigurationBusinessProfile?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The default URL to redirect customers to when they click on the portal’s link to return to your website. This can be overriden when creating the session.
    public var defaultReturnUrl: String?
    /// Information about the features available in the portal.
    public var features: PortalConfigurationFeatures?
    /// Whether the configuration is the default. If true, this configuration can be managed in the Dashboard and portal sessions will use this configuration unless it is overriden when creating the session.
    public var isDefault: Bool?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The hosted login page for this configuration. Learn more about the portal login page in our integration docs.
    public var loginPage: PortalConfigurationLoginPage?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Time at which the object was last updated. Measured in seconds since the Unix epoch.
    public var updated: Date?
    
    public init(id: String,
                object: String,
                active: Bool? = nil,
                application: String? = nil,
                businessProfile: PortalConfigurationBusinessProfile? = nil,
                created: Date,
                defaultReturnUrl: String? = nil,
                features: PortalConfigurationFeatures? = nil,
                isDefault: Bool? = nil,
                livemode: Bool? = nil,
                loginPage: PortalConfigurationLoginPage? = nil,
                metadata: [String : String]? = nil,
                updated: Date? = nil) {
        self.id = id
        self.object = object
        self.active = active
        self.application = application
        self.businessProfile = businessProfile
        self.created = created
        self.defaultReturnUrl = defaultReturnUrl
        self.features = features
        self.isDefault = isDefault
        self.livemode = livemode
        self.loginPage = loginPage
        self.metadata = metadata
        self.updated = updated
    }
}

public struct PortalConfigurationBusinessProfile: Codable {
    /// The messaging shown to customers in the portal.
    public var headline: String?
    /// A link to the business’s publicly available privacy policy.
    public var privacyPolicyUrl: String?
    /// A link to the business’s publicly available terms of service.
    public var termsOfServiceUrl: String?
    
    public init(headline: String? = nil,
                privacyPolicyUrl: String? = nil,
                termsOfServiceUrl: String? = nil) {
        self.headline = headline
        self.privacyPolicyUrl = privacyPolicyUrl
        self.termsOfServiceUrl = termsOfServiceUrl
    }
}

public struct PortalConfigurationFeatures: Codable {
    /// Information about updating customer details in the portal.
    public var customerUpdate: PortalConfigurationFeaturesCustomerUpdate?
    /// Information about showing invoice history in the portal.
    public var invoiceHistory: PortalConfigurationFeaturesInvoiceHistory?
    /// Information about updating payment methods in the portal. Only card payment methods are supported.
    public var paymentMethodUpdate: PortalConfigurationFeaturesPaymentMethodUpdate?
    /// Information about canceling subscriptions in the portal.
    public var subscriptionCancel: PortalConfigurationFeaturesSubscriptionCancel?
    /// Information about pausing subscriptions in the portal.
    public var subscriptionPause: PortalConfigurationFeaturesSubscriptionPause?
    /// Information about updating subscriptions in the portal.
    public var subscriptionUpdate: PortalConfigurationFeaturesSubscriptionUpdate?
    
    public init(customerUpdate: PortalConfigurationFeaturesCustomerUpdate? = nil,
                invoiceHistory: PortalConfigurationFeaturesInvoiceHistory? = nil,
                paymentMethodUpdate: PortalConfigurationFeaturesPaymentMethodUpdate? = nil,
                subscriptionCancel: PortalConfigurationFeaturesSubscriptionCancel? = nil,
                subscriptionPause: PortalConfigurationFeaturesSubscriptionPause? = nil,
                subscriptionUpdate: PortalConfigurationFeaturesSubscriptionUpdate? = nil) {
        self.customerUpdate = customerUpdate
        self.invoiceHistory = invoiceHistory
        self.paymentMethodUpdate = paymentMethodUpdate
        self.subscriptionCancel = subscriptionCancel
        self.subscriptionPause = subscriptionPause
        self.subscriptionUpdate = subscriptionUpdate
    }
}

public struct PortalConfigurationFeaturesCustomerUpdate: Codable {
    /// The types of customer updates that are supported. When empty, customers are not updateable.
    public var allowedUpdates: [PortalConfigurationFeaturesCustomerUpdateAllowedUpdate]?
    
    public init(allowedUpdates: [PortalConfigurationFeaturesCustomerUpdateAllowedUpdate]? = nil) {
        self.allowedUpdates = allowedUpdates
    }
}

public enum PortalConfigurationFeaturesCustomerUpdateAllowedUpdate: String, Codable {
    /// Allow updating email addresses.
    case email
    /// Allow updating billing addresses.
    case address
    /// Allow updating shipping addresses.
    case shipping
    /// Allow updating phone numbers.
    case phone
    /// Allow updating tax IDs.
    case taxId = "tax_id"
}

public struct PortalConfigurationFeaturesInvoiceHistory: Codable {
    /// Whether the feature is enabled.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct PortalConfigurationFeaturesPaymentMethodUpdate: Codable {
    /// Whether the feature is enabled.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct PortalConfigurationFeaturesSubscriptionCancel: Codable {
    /// Whether the cancellation reasons will be collected in the portal and which options are exposed to the customer
    public var cancellationReason: PortalConfigurationFeaturesSubscriptionCancelationReason?
    /// Whether the feature is enabled.
    public var enabled: Bool?
    /// Whether to cancel subscriptions immediately or at the end of the billing period.
    public var mode: PortalConfigurationFeaturesSubscriptionCancelMode?
    /// Whether to create prorations when canceling subscriptions. Possible values are `none` and `create_prorations`.
    public var prorationBehavior: String?
    
    public init(cancellationReason: PortalConfigurationFeaturesSubscriptionCancelationReason? = nil,
                enabled: Bool? = nil,
                mode: PortalConfigurationFeaturesSubscriptionCancelMode? = nil,
                prorationBehavior: String? = nil) {
        self.cancellationReason = cancellationReason
        self.enabled = enabled
        self.mode = mode
        self.prorationBehavior = prorationBehavior
    }
}

public struct PortalConfigurationFeaturesSubscriptionCancelationReason: Codable {
    /// Whether the feature is enabled.
    public var enabled: Bool?
    /// Which cancellation reasons will be given as options to the customer.
    public var options: [PortalConfigurationFeaturesSubscriptionCancelationReasonOption]?
    
    public init(enabled: Bool? = nil,
                options: [PortalConfigurationFeaturesSubscriptionCancelationReasonOption]? = nil) {
        self.enabled = enabled
        self.options = options
    }
}

public enum PortalConfigurationFeaturesSubscriptionCancelationReasonOption: String, Codable {
    /// It’s too expensive
    case tooExpensive = "too_expensive"
    /// Some features are missing
    case missingFeatures = "missing_features"
    /// I’m switching to a different service
    case switchedService = "switched_service"
    /// I don’t use the service enough
    case unused
    /// Customer service was less than expected
    case customerService = "customer_service"
    /// Ease of use was less than expected
    case tooComplex = "too_complex"
    /// Quality was less than expected
    case lowQuality = "low_quality"
    /// Other reason
    case other
}

public enum PortalConfigurationFeaturesSubscriptionCancelMode: String, Codable {
    /// Cancel subscriptions immediately
    case immediately
    /// After canceling, customers can still renew subscriptions until the billing period ends.
    case atPeriodEnd = "at_period_end"
}

public struct PortalConfigurationFeaturesSubscriptionPause: Codable {
    /// Whether the feature is enabled.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct PortalConfigurationFeaturesSubscriptionUpdate: Codable {
    /// The types of subscription updates that are supported for items listed in the products attribute. When empty, subscriptions are not updateable.
    public var defaultAllowedUpdates: [PortalConfigurationFeaturesSubscriptionUpdateDefaultAllowedUpdate]?
    /// Whether the feature is enabled.
    public var enabled: Bool?
    /// The list of products that support subscription updates.
    /// This field is not included by default. To include it in the response, expand the products field.
    public var products: [PortalConfigurationFeaturesSubscriptionUpdateProduct]?
    /// Determines how to handle prorations resulting from subscription updates. Valid values are `none`, `create_prorations`, and `always_invoice`.
    public var prorationBehavior: String?
    
    public init(defaultAllowedUpdates: [PortalConfigurationFeaturesSubscriptionUpdateDefaultAllowedUpdate]? = nil,
                enabled: Bool? = nil,
                products: [PortalConfigurationFeaturesSubscriptionUpdateProduct]? = nil,
                prorationBehavior: String? = nil) {
        self.defaultAllowedUpdates = defaultAllowedUpdates
        self.enabled = enabled
        self.products = products
        self.prorationBehavior = prorationBehavior
    }
}

public enum PortalConfigurationFeaturesSubscriptionUpdateDefaultAllowedUpdate: String, Codable {
    /// Allow switching to a different price.
    case price
    /// Allow updating subscription quantities.
    case quantity
    /// Allow applying promotion codes to subscriptions.
    case promotionCode = "promotion_code"
}

public struct PortalConfigurationFeaturesSubscriptionUpdateProduct: Codable {
    /// The list of price IDs which, when subscribed to, a subscription can be updated.
    public var prices: [String]?
    /// The product ID.
    public var product: String?
    
    public init(prices: [String]? = nil, product: String? = nil) {
        self.prices = prices
        self.product = product
    }
}

public struct PortalConfigurationLoginPage: Codable {
    /// If true, a shareable url will be generated that will take your customers to a hosted login page for the customer portal. If false, the previously generated url, if any, will be deactivated.
    public var enabled: Bool?
    /// A shareable URL to the hosted portal login page. Your customers will be able to log in with their email and receive a link to their customer portal.
    public var url: String?
    
    public init(enabled: Bool? = nil, url: String? = nil) {
        self.enabled = enabled
        self.url = url
    }
}

public struct PortalConfigurationList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `StripePortalConfiguration`s
    public var data: [PortalConfiguration]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    
    public init(object: String,
                data: [PortalConfiguration]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
