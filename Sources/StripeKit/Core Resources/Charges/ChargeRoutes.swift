//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import NIO
import NIOHTTP1

public protocol ChargeRoutes: StripeAPIRoute {
    /// To charge a credit card or other payment source, you create a `Charge` object. If your API key is in test mode, the supplied payment source (e.g., card) won’t actually be charged, although everything else will occur as if in live mode. (Stripe assumes that the charge would have completed successfully).

    /// - Parameters:
    ///   - amount: Amount intended to be collected by this payment. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customer: The ID of an existing customer that will be charged in this request.
    ///   - description: An arbitrary string which you can attach to a `Charge` object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the `description` of the charge(s) that they are describing.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - receiptEmail: The email address to which this charge’s receipt will be sent. The receipt will not be sent until the charge is paid, and no receipts will be sent for test mode charges. If this charge is for a Customer, the email address specified here will override the customer’s email address. If `receipt_email` is specified for a charge in live mode, a receipt will be sent regardless of your email settings.
    ///   - shipping: Shipping information for the charge. Helps prevent fraud on charges for physical goods.
    ///   - source: A payment source to be charged. This can be the ID of a card (i.e., credit or debit card), a bank account, a source, a token, or a connected account. For certain sources—namely, cards, bank accounts, and attached sources—you must also pass the ID of the associated customer.
    ///   - statementDescriptor: For card charges, use `statement_descriptor_suffix` instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - applicationFeeAmount: A fee in cents that will be applied to the charge and transferred to the application owner’s Stripe account. The request must be made with an OAuth key or the `Stripe-Account` header in order to take an application fee. For more information, see the application fees documentation.
    ///   - capture: Whether to immediately capture the charge. Defaults to `true`. When `false`, the charge issues an authorization (or pre-authorization), and will need to be captured later. Uncaptured charges expire after a set number of days (7 by default). For more information, see the authorizing charges and settling later documentation.
    ///   - onBehalfOf: The Stripe account ID for which these funds are intended. Automatically set if you use the `destination` parameter. For details, see Creating Separate Charges and Transfers.
    ///   - radarOptions: Options to configure Radar. See Radar Session for more information.
    ///   - transferData: An optional dictionary including the account to automatically transfer to as part of a destination charge. See the Connect documentation for details.
    ///   - transferGroup: A string that identifies this transaction as part of a group. For details, see Grouping transactions.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the charge object if the charge succeeded. This call will return an error if something goes wrong. A common source of error is an invalid or expired card, or a valid card with insufficient available balance.
    func create(amount: Int,
                currency: Currency,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                receiptEmail: String?,
                shipping: [String: Any]?,
                source: Any?,
                statementDescriptor: String?,
                statementDescriptorSuffix: String?,
                applicationFeeAmount: Int?,
                capture: Bool?,
                onBehalfOf: String?,
                radarOptions: [String: Any]?,
                transferData: [String: Any]?,
                transferGroup: String?,
                expand: [String]?) async throws -> Charge
    
    /// Retrieves the details of a charge that has previously been created. Supply the unique charge ID that was returned from your previous request, and Stripe will return the corresponding charge information. The same information is returned when creating or refunding the charge.
    /// - Parameters:
    ///   - charge: The id of the chrage.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a charge if a valid identifier was provided, and returns an error otherwise.
    func retrieve(charge: String, expand: [String]?) async throws -> Charge
    
    /// Updates the specified charge by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - charge: The identifier of the charge to be updated.
    ///   - customer: The ID of an existing customer that will be associated with this request. This field may only be updated if there is no existing associated customer with this charge.
    ///   - description: An arbitrary string which you can attach to a charge object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the description of the charge(s) that they are describing. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - receiptEmail: This is the email address that the receipt for this charge will be sent to. If this field is updated, then a new email receipt will be sent to the updated address. This will be unset if you POST an empty value.
    ///   - shipping: Shipping information for the charge. Helps prevent fraud on charges for physical goods.
    ///   - fraudDetails: A set of key-value pairs you can attach to a charge giving information about its riskiness. If you believe a charge is fraudulent, include a `user_report` key with a value of `fraudulent`. If you believe a charge is safe, include a `user_report` key with a value of `safe`. Stripe will use the information you send to improve our fraud detection algorithms.
    ///   - transferGroup: A string that identifies this transaction as part of a group. `transfer_group` may only be provided if it has not been set. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the charge object if the update succeeded. This call will return an error if update parameters are invalid.
    func update(charge: String,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                receiptEmail: String?,
                shipping: [String: Any]?,
                fraudDetails: [String: Any]?,
                transferGroup: String?,
                expand: [String]?) async throws -> Charge
    
    /// Capture the payment of an existing, uncaptured, charge. This is the second half of the two-step payment flow, where first you created a charge with the capture option set to false.
    ///
    /// Uncaptured payments expire a set number of days after they are created (7 by default). If they are not captured by that point in time, they will be marked as refunded and will no longer be capturable.
    /// - Parameters:
    ///   - charge: The id of the charge.
    ///   - amount: The amount to capture, which must be less than or equal to the original amount. Any additional amount will be automatically refunded.
    ///   - receiptEmail: The email address to send this charge’s receipt to. This will override the previously-specified email address for this charge, if one was set. Receipts will not be sent in test mode.
    ///   - statementDescriptor: For card charges, use `statement_descriptor_suffix` instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - applicationFeeAmount: An application fee amount to add on to this charge, which must be less than or equal to the original amount.
    ///   - transferData: An optional dictionary including the account to automatically transfer to as part of a destination charge. See the Connect documentation for details.
    ///   - transferGroup: A string that identifies this transaction as part of a group. `transfer_group` may only be provided if it has not been set. See the Connect documentation for details.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the charge object, with an updated captured property (set to true). Capturing a charge will always succeed, unless the charge is already refunded, expired, captured, or an invalid capture amount is specified, in which case this method will return an error.
    func capture(charge: String,
                 amount: Int?,
                 receiptEmail: String?,
                 statementDescriptor: String?,
                 statementDescriptorSuffix: String?,
                 applicationFeeAmount: Int?,
                 transferData: [String: Any]?,
                 transferGroup: String?,
                 expand: [String]?) async throws -> Charge
    
    /// Returns a list of charges you’ve previously created. The charges are returned in sorted order, with the most recent charges appearing first.
    ///
    /// - Parameter filter: A [dictionary](https://stripe.com/docs/api/charges/list) that will be used for the query parameters.
    /// - Returns: A dictionary with a data property that contains an array of up to limit charges, starting after charge `starting_after`. Each entry in the array is a separate charge object. If no more charges are available, the resulting array will be empty. If you provide a non-existent customer ID, this call returns an error.
    func listAll(filter: [String: Any]?) async throws -> ChargeList
    
    
    /// Search for charges you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for charges.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    /// - Returns: A dictionary with a data property that contains an array of up to limit charges. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?) async throws -> ChargeSearchResult
    
    /// Search for charges you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for charges.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: A dictionary with a data property that contains an array of up to limit charges. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?, expand:[String]?) async throws -> ChargeSearchResult
}

public struct StripeChargeRoutes: ChargeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let charges = APIBase + APIVersion + "charges/"
    private let charge = APIBase + APIVersion + "charges"
    private let search = APIBase + APIVersion + "charges/search"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: Currency,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String : String]? = nil,
                       receiptEmail: String? = nil,
                       shipping: [String : Any]? = nil,
                       source: Any? = nil,
                       statementDescriptor: String? = nil,
                       statementDescriptorSuffix: String? = nil,
                       applicationFeeAmount: Int? = nil,
                       capture: Bool? = nil,
                       onBehalfOf: String? = nil,
                       radarOptions: [String : Any]? = nil,
                       transferData: [String : Any]? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil) async throws -> Charge {
        var body: [String: Any] = ["amount": amount, "currency": currency.rawValue]
                
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1}
        }
       
        if let receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping {
           shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let capture {
            body["capture"] = capture
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let radarOptions {
            radarOptions.forEach { body["radar_options[\($0)]"] = $1 }
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: charge, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(charge: String, expand: [String]? = nil) async throws -> Charge {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: charges + charge, query: queryParams, headers: headers)
    }
    
    public func update(charge: String,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String : String]? = nil,
                       receiptEmail: String? = nil,
                       shipping: [String : Any]? = nil,
                       fraudDetails: [String : Any]? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil) async throws -> Charge {
        var body: [String: Any] = [:]
        
        if let customer {
            body["customer"] = customer
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let fraudDetails {
            fraudDetails.forEach { body["fraud_details[\($0)]"] = $1 }
        }
        
        if let transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: charges + charge, body: .string(body.queryParameters), headers: headers)
    }
    
    public func capture(charge: String,
                        amount: Int? = nil,
                        receiptEmail: String? = nil,
                        statementDescriptor: String? = nil,
                        statementDescriptorSuffix: String? = nil,
                        applicationFeeAmount: Int? = nil,
                        transferData: [String : Any]? = nil,
                        transferGroup: String? = nil,
                        expand: [String]? = nil) async throws -> Charge {
        var body: [String: Any] = [:]
        
        if let amount {
            body["amount"] = amount
        }
        
        if let receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: charges + charge + "/capture", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) async throws -> ChargeList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: charge, query: queryParams, headers: headers)
    }
    
    public func search(query: String,
                       limit: Int? = nil,
                       page: String? = nil) async throws -> ChargeSearchResult {
        return try await self.search(query: query, limit:limit, page:page, expand:nil)
    }
    
    public func search(query: String,
                        limit: Int? = nil,
                        page: String? = nil,
                        expand:[String]? = nil) async throws -> ChargeSearchResult {
        var queryParams: [String: Any] = ["query": query]
        
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        if let limit {
            queryParams["limit"] = limit
        }
        
        if let page {
            queryParams["page"] = page
        }
        
        return try await apiHandler.send(method: .GET, path: search, query: queryParams.queryParameters, body: .string(body.queryParameters), headers: headers)
    }
}
