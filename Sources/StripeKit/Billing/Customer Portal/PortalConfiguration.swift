//
//  PortalConfiguration.swift
//  
//
//  Created by Andrew Edwards on 2/25/21.
//

import Foundation

public struct StripePortalConfiguration: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the configuration is active and can be used to create portal sessions.
    public var active: Bool?
    /// ID of the Connect Application that created the configuration.
    public var application: String?
    /// The business information shown to customers in the portal.
    public var businessProfile: StripePortalConfigurationBusinessProfile?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The default URL to redirect customers to when they click on the portal’s link to return to your website. This can be overriden when creating the session.
    public var defaultReturnUrl: String?
    /// Information about the features available in the portal.
    public var features: StripePortalConfigurationFeatures?
    /// Whether the configuration is the default. If true, this configuration can be managed in the Dashboard and portal sessions will use this configuration unless it is overriden when creating the session.
    public var isDefault: Bool?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Time at which the object was last updated. Measured in seconds since the Unix epoch.
    public var updated: Date?
}

public struct StripePortalConfigurationBusinessProfile: StripeModel {
    /// The messaging shown to customers in the portal.
    public var headline: String?
    /// A link to the business’s publicly available privacy policy.
    public var privacyPolicyUrl: String?
    /// A link to the business’s publicly available terms of service.
    public var termsOfServiceUrl: String?
}

public struct StripePortalConfigurationFeatures: StripeModel {
    /// Information about updating customer details in the portal.
    public var customerUpdate: StripePortalConfigurationFeaturesCustomerUpdate?
    /// Information about showing invoice history in the portal.
    public var invoiceHistory: StripePortalConfigurationFeaturesInvoiceHistory?
    /// Information about updating payment methods in the portal. Only card payment methods are supported.
    public var paymentMethodUpdate: StripePortalConfigurationFeaturesPaymentMethodUpdate?
    /// Information about canceling subscriptions in the portal.
    public var subscriptionCancel: StripePortalConfigurationFeaturesSubscriptionCancel?
    /// Information about pausing subscriptions in the portal.
    public var subscriptionPause: StripePortalConfigurationFeaturesSubscriptionPause?
    /// Information about updating subscriptions in the portal.
    public var subscriptionUpdate: StripePortalConfigurationFeaturesSubscriptionUpdate?
}

public struct StripePortalConfigurationFeaturesCustomerUpdate: StripeModel {
    /// The types of customer updates that are supported. When empty, customers are not updateable.
    public var allowedUpdates: [StripePortalConfigurationFeaturesCustomerUpdateAllowedUpdate]?
}

public enum StripePortalConfigurationFeaturesCustomerUpdateAllowedUpdate: String, StripeModel {
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

public struct StripePortalConfigurationFeaturesInvoiceHistory: StripeModel {
    /// Whether the feature is enabled.
    public var enabled: Bool?
}

public struct StripePortalConfigurationFeaturesPaymentMethodUpdate: StripeModel {
    /// Whether the feature is enabled.
    public var enabled: Bool?
}

public struct StripePortalConfigurationFeaturesSubscriptionCancel: StripeModel {
    /// Whether the feature is enabled.
    public var enabled: Bool?
    /// Whether to cancel subscriptions immediately or at the end of the billing period.
    public var mode: StripePortalConfigurationFeaturesSubscriptionCancelMode?
    /// Whether to create prorations when canceling subscriptions. Possible values are `none` and `create_prorations`.
    public var prorationBehavior: String?
}

public enum StripePortalConfigurationFeaturesSubscriptionCancelMode: String, StripeModel {
    /// Cancel subscriptions immediately
    case immediately
    /// After canceling, customers can still renew subscriptions until the billing period ends.
    case atPeriodEnd = "at_period_end"
}

public struct StripePortalConfigurationFeaturesSubscriptionPause: StripeModel {
    /// Whether the feature is enabled.
    public var enabled: Bool?
}

public struct StripePortalConfigurationFeaturesSubscriptionUpdate: StripeModel {
    /// The types of subscription updates that are supported for items listed in the products attribute. When empty, subscriptions are not updateable.
    public var defaultAllowedUpdates: [StripePortalConfigurationFeaturesSubscriptionUpdateDefaultAllowedUpdate]?
    /// Whether the feature is enabled.
    public var enabled: Bool?
    /// The list of products that support subscription updates.
    /// This field is not included by default. To include it in the response, expand the products field.
    public var products: [StripePortalConfigurationFeaturesSubscriptionUpdateProduct]?
    /// Determines how to handle prorations resulting from subscription updates. Valid values are `none`, `create_prorations`, and `always_invoice`.
    public var prorationBehavior: String?
}

public enum StripePortalConfigurationFeaturesSubscriptionUpdateDefaultAllowedUpdate: String, StripeModel {
    /// Allow switching to a different price.
    case price
    /// Allow updating subscription quantities.
    case quantity
    /// Allow applying promotion codes to subscriptions.
    case promotionCode = "promotion_code"
}

public struct StripePortalConfigurationFeaturesSubscriptionUpdateProduct: StripeModel {
    /// The list of price IDs which, when subscribed to, a subscription can be updated.
    public var prices: [String]?
    /// The product ID.
    public var product: String?
}

public struct StripePortalConfigurationList: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `StripePortalConfiguration`s
    public var data: [StripePortalConfiguration]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
}
