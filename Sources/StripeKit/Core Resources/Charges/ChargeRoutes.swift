//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import NIO
import NIOHTTP1

public protocol ChargeRoutes {
    /// To charge a credit card or other payment source, you create a Charge object. If your API key is in test mode, the supplied payment source (e.g., card) won’t actually be charged, although everything else will occur as if in live mode. (Stripe assumes that the charge would have completed successfully).
    ///
    /// - Parameters:
    ///   - amount: A positive integer representing how much to charge, in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal) (e.g., `100` cents to charge $1.00, or `100` to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 USD or [equivalent in charge currency](https://stripe.com/docs/currencies#minimum-and-maximum-charge-amounts).
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the charge and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the `Stripe-Account` header in order to take an application fee. For more information, see the application fees [documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees).
    ///   - capture: Whether to immediately capture the charge. Defaults to `true`. When `false`, the charge issues an authorization (or pre-authorization), and will need to be [captured](https://stripe.com/docs/api/charges/create#capture_charge) later. Uncaptured charges expire in seven days. For more information, see the [authorizing charges and settling later](https://stripe.com/docs/charges#auth-and-capture) documentation.
    ///   - customer: The ID of an existing customer that will be charged in this request.
    ///   - description: An arbitrary string which you can attach to a `Charge` object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the `description` of the charge(s) that they are describing. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - onBehalfOf: The Stripe account ID for which these funds are intended. Automatically set if you use the `destination` parameter. For details, see [Creating Separate Charges and Transfers](https://stripe.com/docs/connect/charges-transfers#on-behalf-of).
    ///   - receiptEmail: The email address to which this charge’s [receipt](https://stripe.com/docs/dashboard/receipts) will be sent. The receipt will not be sent until the charge is paid, and no receipts will be sent for test mode charges. If this charge is for a [Customer](https://stripe.com/docs/api/customers/object), the email address specified here will override the customer’s email address. If `receipt_email` is specified for a charge in live mode, a receipt will be sent regardless of your [email settings](https://dashboard.stripe.com/account/emails).
    ///   - shipping: Shipping information for the charge. Helps prevent fraud on charges for physical goods.
    ///   - source: A payment source to be charged. This can be the ID of a card (i.e., credit or debit card), a bank account, a source, a token, or a connected account. For certain sources—namely, cards, bank accounts, and attached sources—you must also pass the ID of the associated customer.
    ///   - statementDescriptor: For card charges, use `statement_descriptor_suffix` instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - transferData: An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    ///   - transferGroup: A string that identifies this transaction as part of a group. For details, see [Grouping transactions](https://stripe.com/docs/connect/charges-transfers#grouping-transactions).
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCharge`.
    func create(amount: Int,
                currency: Currency,
                applicationFeeAmount: Int?,
                capture: Bool?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                onBehalfOf: String?,
                receiptEmail: String?,
                shipping: [String: Any]?,
                source: Any?,
                statementDescriptor: String?,
                statementDescriptorSuffix: String?,
                transferData: [String: Any]?,
                transferGroup: String?,
                expand: [String]?) -> EventLoopFuture<StripeCharge>
    
    /// Retrieves the details of a charge that has previously been created. Supply the unique charge ID that was returned from your previous request, and Stripe will return the corresponding charge information. The same information is returned when creating or refunding the charge.
    ///
    /// - Parameter charge: The identifier of the charge to be retrieved.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeCharge`.
    func retrieve(charge: String, expand: [String]?) -> EventLoopFuture<StripeCharge>
    
    /// Updates the specified charge by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - charge: The identifier of the charge to be updated.
    ///   - customer: The ID of an existing customer that will be associated with this request. This field may only be updated if there is no existing associated customer with this charge.
    ///   - description: An arbitrary string which you can attach to a charge object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the description of the charge(s) that they are describing. This will be unset if you POST an empty value.
    ///   - fraudDetails: A set of key-value pairs you can attach to a charge giving information about its riskiness. If you believe a charge is fraudulent, include a `user_report` key with a value of `fraudulent`. If you believe a charge is safe, include a `user_report` key with a value of `safe`. Stripe will use the information you send to improve our fraud detection algorithms.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - receiptEmail: This is the email address that the receipt for this charge will be sent to. If this field is updated, then a new email receipt will be sent to the updated address. This will be unset if you POST an empty value.
    ///   - shipping: Shipping information for the charge. Helps prevent fraud on charges for physical goods.
    ///   - transferGroup: A string that identifies this transaction as part of a group. `transfer_group` may only be provided if it has not been set. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCharge`.
    func update(charge: String,
                customer: String?,
                description: String?,
                fraudDetails: [String: Any]?,
                metadata: [String: String]?,
                receiptEmail: String?,
                shipping: [String: Any]?,
                transferGroup: String?,
                expand: [String]?) -> EventLoopFuture<StripeCharge>
    
    /// Capture the payment of an existing, uncaptured, charge. This is the second half of the two-step payment flow, where first you [created a charge](https://stripe.com/docs/api/charges/capture#create_charge) with the capture option set to false. \n Uncaptured payments expire exactly seven days after they are created. If they are not captured by that point in time, they will be marked as refunded and will no longer be capturable.
    ///
    /// - Parameters:
    ///   - charge: The identifier of the charge to be captured.
    ///   - amount: The amount to capture, which must be less than or equal to the original amount. Any additional amount will be automatically refunded.
    ///   - applicationFeeAmount: An application fee amount to add on to this charge, which must be less than or equal to the original amount. Can only be used with Stripe Connect.
    ///   - receiptEmail: The email address to send this charge’s receipt to. This will override the previously-specified email address for this charge, if one was set. Receipts will not be sent in test mode.
    ///   - statementDescriptor: For card charges, use `statement_descriptor_suffix` instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - transferData: An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    ///   - transferGroup: A string that identifies this transaction as part of a group. `transfer_group` may only be provided if it has not been set. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCharge`.
    func capture(charge: String,
                 amount: Int?,
                 applicationFeeAmount: Int?,
                 receiptEmail: String?,
                 statementDescriptor: String?,
                 statementDescriptorSuffix: String?,
                 transferData: [String: Any]?,
                 transferGroup: String?,
                 expand: [String]?) -> EventLoopFuture<StripeCharge>
    
    /// Returns a list of charges you’ve previously created. The charges are returned in sorted order, with the most recent charges appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/charges/list).
    /// - Returns: A `StripeChargesList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeChargesList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ChargeRoutes {
    public func create(amount: Int,
                       currency: Currency,
                       applicationFeeAmount: Int? = nil,
                       capture: Bool? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       onBehalfOf: String? = nil,
                       receiptEmail: String? = nil,
                       shipping: [String: Any]? = nil,
                       source: Any? = nil,
                       statementDescriptor: String? = nil,
                       statementDescriptorSuffix: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeCharge> {
        return create(amount: amount,
                      currency: currency,
                      applicationFeeAmount: applicationFeeAmount,
                      capture: capture,
                      customer: customer,
                      description: description,
                      metadata: metadata,
                      onBehalfOf: onBehalfOf,
                      receiptEmail: receiptEmail,
                      shipping: shipping,
                      source: source,
                      statementDescriptor: statementDescriptor,
                      statementDescriptorSuffix: statementDescriptorSuffix,
                      transferData: transferData,
                      transferGroup: transferGroup,
                      expand: expand)
    }
    
    public func retrieve(charge: String, expand: [String]? = nil) -> EventLoopFuture<StripeCharge> {
        return retrieve(charge: charge, expand: expand)
    }
    
    public func update(charge chargeId: String,
                       customer: String? = nil,
                       description: String? = nil,
                       fraudDetails: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       receiptEmail: String? = nil,
                       shipping: [String: Any]? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeCharge> {
        return update(charge: chargeId,
                      customer: customer,
                      description: description,
                      fraudDetails: fraudDetails,
                      metadata: metadata,
                      receiptEmail: receiptEmail,
                      shipping: shipping,
                      transferGroup: transferGroup,
                      expand: expand)
    }
    
    public func capture(charge: String,
                        amount: Int? = nil,
                        applicationFeeAmount: Int? = nil,
                        receiptEmail: String? = nil,
                        statementDescriptor: String? = nil,
                        statementDescriptorSuffix: String? = nil,
                        transferData: [String: Any]? = nil,
                        transferGroup: String? = nil,
                        expand: [String]? = nil) -> EventLoopFuture<StripeCharge> {
        return capture(charge: charge,
                       amount: amount,
                       applicationFeeAmount: applicationFeeAmount,
                       receiptEmail: receiptEmail,
                       statementDescriptor: statementDescriptor,
                       statementDescriptorSuffix: statementDescriptorSuffix,
                       transferData: transferData,
                       transferGroup: transferGroup,
                       expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeChargesList> {
        return listAll(filter: filter)
    }
}

public struct StripeChargeRoutes: ChargeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let charges = APIBase + APIVersion + "charges/"
    private let charge = APIBase + APIVersion + "charges"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: Currency,
                       applicationFeeAmount: Int?,
                       capture: Bool?,
                       customer: String?,
                       description: String?,
                       metadata: [String: String]?,
                       onBehalfOf: String?,
                       receiptEmail: String?,
                       shipping: [String: Any]?,
                       source: Any?,
                       statementDescriptor: String?,
                       statementDescriptorSuffix: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?,
                       expand: [String]?) -> EventLoopFuture<StripeCharge> {
        var body: [String: Any] = ["amount": amount, "currency": currency.rawValue]
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let capture = capture {
            body["capture"] = capture
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1}
        }
       
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping = shipping {
           shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix = statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: charge, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(charge: String, expand: [String]?) -> EventLoopFuture<StripeCharge> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: charges + charge, query: queryParams, headers: headers)
    }
    
    public func update(charge: String,
                       customer: String?,
                       description: String?,
                       fraudDetails: [String: Any]?,
                       metadata: [String: String]?,
                       receiptEmail: String?,
                       shipping: [String: Any]?,
                       transferGroup: String?,
                       expand: [String]?) -> EventLoopFuture<StripeCharge> {
        var body: [String: Any] = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let fraud = fraudDetails {
            fraud.forEach { body["fraud_details[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: charges + charge, body: .string(body.queryParameters), headers: headers)
    }
    
    public func capture(charge: String,
                        amount: Int?,
                        applicationFeeAmount: Int?,
                        receiptEmail: String?,
                        statementDescriptor: String?,
                        statementDescriptorSuffix: String?,
                        transferData: [String: Any]?,
                        transferGroup: String?,
                        expand: [String]?) -> EventLoopFuture<StripeCharge> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix = statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: charges + charge + "/capture", body: .string(body.queryParameters), headers: headers)
    }

    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeChargesList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: charge, query: queryParams, headers: headers)
    }
}
