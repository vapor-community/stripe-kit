//
//  Disputes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import Foundation

/// The [Dispte Object](https://stripe.com/docs/api/issuing/disputes/object)
public struct StripeIssuingDispute: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Disputed amount. Usually the amount of the `disputed_transaction`, but can differ (usually because of currency fluctuation or because only part of the order is disputed).
    public var amount: Int?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The currency the disputed_transaction was made in.
    public var currency: StripeCurrency?
    /// The transaction being disputed.
    public var disputedTransaction: String?
    /// Evidence related to the dispute. This hash will contain exactly one non-null value, containing an evidence object that matches its `reason`
    public var evidence: StripeIssuingDisputeEvidence?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    public var metadata: [String: String]?
    /// Reason for this dispute. One of `other` or `fraudulent`.
    public var reason: StripeIssuingDisputeReason?
    /// Current status of dispute. One of `unsubmitted`, `under_review`, `won`, or `lost`.
    public var status: StripeIssuingDisputeStatus?
}

public struct StripeIssuingDisputeEvidence: StripeModel {
    /// Evidence to support a fraudulent dispute. This will only be present if your dispute’s `reason` is `fraudulent`.
    public var fraudulent: StripeIssuingDisputeEvidenceFraudulent?
    /// Evidence to support an uncategorized dispute. This will only be present if your dispute’s `reason` is `other`.
    public var other: StripeIssuingDisputeEvidenceOther?
}

public struct StripeIssuingDisputeEvidenceFraudulent: StripeModel {
    /// Brief freeform text explaining why you are disputing this transaction.
    public var disputeExplination: String?
    /// (ID of a file upload) Additional file evidence supporting your dispute.
    public var uncategorizedFile: String?
}

public struct StripeIssuingDisputeEvidenceOther: StripeModel {
    /// Brief freeform text explaining why you are disputing this transaction.
    public var disputeExplination: String?
    /// (ID of a file upload) Additional file evidence supporting your dispute.
    public var uncategorizedFile: String?
}

public enum StripeIssuingDisputeReason: String, StripeModel {
    case other
    case fraudulent
}

public enum StripeIssuingDisputeStatus: String, StripeModel {
    case unsubmitted
    case underReview = "under_review"
    case won
    case lost
}
