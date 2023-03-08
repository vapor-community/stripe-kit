//
//  ScheduledQueryRun.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation

/// The [Scheduled Query Run Object](https://stripe.com/docs/api/sigma/scheduled_queries/object).
public struct StripeScheduledQueryRun: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// When the query was run, Sigma contained a snapshot of your Stripe data at this time.
    public var dataLoadTime: Date?
    /// If the query run was not successful, this field contains information about the failure.
    public var error: StripeScheduledQueryRunError?
    /// The file object representing the results of the query.
    public var file: File?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Time at which the result expires and is no longer available for download.
    public var resultAvailableUntil: Date?
    /// SQL for the query.
    public var sql: String?
    /// The query’s execution status, which will be `completed` for successful runs, and `canceled`, `failed`, or `timed_out` otherwise.
    public var status: StripeScheduledQueryRunStatus?
    /// Title of the query.
    public var title: String?
}

public struct StripeScheduledQueryRunList: Codable {
    public var object: String
    public var data: [StripeScheduledQueryRun]?
    public var hasMore: Bool?
    public var url: String?
}

public struct StripeScheduledQueryRunError: Codable {
    /// Information about the run failure.
    public var message: String?
}

public enum StripeScheduledQueryRunStatus: String, Codable {
    case completed
    case canceled
    case failed
    case timedOut = "time_out"
}
