//
//  DisputeEvidence.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/7/17.
//

/// The [Dispute Evidence Object](https://stripe.com/docs/api/disputes/evidence_object).
public struct StripeDisputeEvidence: StripeModel {
    /// Any server or activity logs showing proof that the customer accessed or downloaded the purchased digital product. This information should include IP addresses, corresponding timestamps, and any detailed recorded activity.
    public var accessActivityLog: String?
    /// The billing address provided by the customer.
    public var billingAddress: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Your subscription cancellation policy, as shown to the customer.
    public var cancellationPolicy: String?
    /// An explanation of how and when the customer was shown your refund policy prior to purchase.
    public var cancellationPolicyDisclosure: String?
    /// A justification for why the customer’s subscription was not canceled.
    public var cancellationRebuttal: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Any communication with the customer that you feel is relevant to your case. Examples include emails proving that the customer received the product or service, or demonstrating their use of or satisfaction with the product or service.
    public var customerCommunication: String?
    /// The email address of the customer.
    public var customerEmailAddress: String?
    /// The name of the customer.
    public var customerName: String?
    /// The IP address that the customer used when making the purchase.
    public var customerPurchaseIp: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) A relevant document or contract showing the customer’s signature.
    public var customerSignature: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Documentation for the prior charge that can uniquely identify the charge, such as a receipt, shipping label, work order, etc. This document should be paired with a similar document from the disputed payment that proves the two payments are separate.
    public var duplicateChargeDocumentation: String?
    /// An explanation of the difference between the disputed charge versus the prior charge that appears to be a duplicate.
    public var duplicateChargeExplanation: String?
    /// The Stripe ID for the prior charge which appears to be a duplicate of the disputed charge.
    public var duplicateChargeId: String?
    /// A description of the product or service that was sold.
    public var productDescription: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Any receipt or message sent to the customer notifying them of the charge.
    public var receipt: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Your refund policy, as shown to the customer.
    public var refundPolicy: String?
    /// Documentation demonstrating that the customer was shown your refund policy prior to purchase.
    public var refundPolicyDisclosure: String?
    /// A justification for why the customer is not entitled to a refund.
    public var refundRefusalExplanation: String?
    /// The date on which the customer received or began receiving the purchased service, in a clear human-readable format.
    public var serviceDate: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Documentation showing proof that a service was provided to the customer. This could include a copy of a signed contract, work order, or other form of written agreement.
    public var serviceDocumentation: String?
    /// The address to which a physical product was shipped. You should try to include as complete address information as possible.
    public var shippingAddress: String?
    /// The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc. If multiple carriers were used for this purchase, please separate them with commas.
    public var shippingCarrier: String?
    /// The date on which a physical product began its route to the shipping address, in a clear human-readable format.
    public var shippingDate: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Documentation showing proof that a product was shipped to the customer at the same address the customer provided to you. This could include a copy of the shipment receipt, shipping label, etc. It should show the customer’s full shipping address, if possible.
    public var shippingDocumentation: String?
    /// The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
    public var shippingTrackingNumber: String?
    /// (ID of a [file upload](https://stripe.com/docs/guides/file-upload)) Any additional evidence or statements.
    public var uncategorizedFile: String?
    /// Any additional evidence or statements.
    public var uncategorizedText: String?
}
