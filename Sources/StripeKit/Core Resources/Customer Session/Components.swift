//
//  Component.swift
//  stripe-kit
//
//  Created by Anatol Mayen on 11.11.24.
//

/// This hash defines which component is enabled and the features it supports.
public struct Components: Codable {
    
    public enum ComponentsType {
        case buyButton
        case payementElement
        case pricingTable
    }
    
    /// Configuration for buy button.
    public var buyButton: ComponentEnabled
    
    /// Configuration for the Payment Element.
    public var paymentElement: PaymentComponentEnabled
    
    /// Configuration for the pricing table.
    public var pricingTable: ComponentEnabled
    
    init(enable type: ComponentsType) {

        self.buyButton = ComponentEnabled(type == .buyButton)
        self.paymentElement = PaymentComponentEnabled(type == .payementElement)
        self.pricingTable = ComponentEnabled(type == .pricingTable)
    }
}

public struct ComponentEnabled: Codable {
    
    public var enabled: Bool
    
    init(_ enabled: Bool) {
        self.enabled = enabled
    }
}

/// Configuration for the Payment Element.
public struct PaymentComponentEnabled: Codable {
    
    /// Whether the Payment Element is enabled.
    public var enabled: Bool
    
    /// This hash defines whether the Payment Element supports certain features.
    public var features: PaymentFeatures?
    
    init(_ enabled: Bool, features: PaymentFeatures? = nil) {
        self.enabled = enabled
        self.features = features
    }
}

/// This hash defines whether the Payment Element supports certain features.
public struct PaymentFeatures: Codable {
    
    /// A list of allow_redisplay values that controls which saved payment methods the Payment Element displays by filtering to only show payment methods with an allow_redisplay value that is present in this list.
    /// If not specified, defaults to [“always”]. In order to display all saved payment methods, specify [“always”, “limited”, “unspecified”].
    /// Possible values are: `always`, `limited` and `unspecified`
    public var paymentMethodAllowRedisplayFilters: [String]
    
    /// Controls whether or not the Payment Element shows saved payment methods. This parameter defaults to disabled.
    /// Possible values are: `disabled` and `enabled`
    public var paymentMethodRedisplay: String
    
    /// Determines the max number of saved payment methods for the Payment Element to display. This parameter defaults to `3`.
    public var paymentMethodRedisplayLimit: Int?
    
    /// Controls whether the Payment Element displays the option to remove a saved payment method. This parameter defaults to `disabled`.
    /// Allowing buyers to remove their saved payment methods impacts subscriptions that depend on that payment method. Removing the payment method detaches the `customer` [object](https://docs.stripe.com/api/payment_methods/object#payment_method_object-customer) from that [PaymentMethod](https://docs.stripe.com/api/payment_methods).
    /// Possible values: `enabled` and `disabled`
    public var paymentMethodRemove: String
    
    /// Controls whether the Payment Element displays a checkbox offering to save a new payment method. This parameter defaults to `disabled`.
    /// If a customer checks the box, the `allow_redisplay` value on the PaymentMethod is set to `always` at confirmation time. For PaymentIntents, the `setup_future_usage` value is also set to the value defined in `payment_method_save_usage`.
    /// Possible values: `enabled` and `disabled`
    public var paymentMethodSave: String
    
    /// When using PaymentIntents and the customer checks the save checkbox, this field determines the `setup_future_usage` value used to confirm the PaymentIntent.
    /// When using SetupIntents, directly configure the usage value on SetupIntent creation.
    /// Possible values: `off_session` and `on_session`
    public var paymentMethodSaveUsage: String?
}
