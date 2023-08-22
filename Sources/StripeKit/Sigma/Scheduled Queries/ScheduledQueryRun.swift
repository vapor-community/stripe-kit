//
//  ScheduledQueryRun.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation

/// The [Scheduled Query Run Object](https://stripe.com/docs/api/sigma/scheduled_queries/object)
public struct ScheduledQueryRun: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// When the query was run, Sigma contained a snapshot of your Stripe data at this time.
    public var dataLoadTime: Date?
    /// The file object representing the results of the query.
    public var file: File?
    /// SQL for the query.
    public var sql: String?
    /// The query’s execution status, which will be `completed` for successful runs, and `canceled`, `failed`, or `timed_out` otherwise.
    public var status: ScheduledQueryRunStatus?
    /// Title of the query.
    public var title: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If the query run was not successful, this field contains information about the failure.
    public var error: ScheduledQueryRunError?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Time at which the result expires and is no longer available for download.
    public var resultAvailableUntil: Date?
    
    public init(id: String,
                dataLoadTime: Date? = nil,
                file: File? = nil,
                sql: String? = nil,
                status: ScheduledQueryRunStatus? = nil,
                title: String? = nil,
                object: String,
                created: Date,
                error: ScheduledQueryRunError? = nil,
                livemode: Bool? = nil,
                resultAvailableUntil: Date? = nil) {
        self.id = id
        self.dataLoadTime = dataLoadTime
        self.file = file
        self.sql = sql
        self.status = status
        self.title = title
        self.object = object
        self.created = created
        self.error = error
        self.livemode = livemode
        self.resultAvailableUntil = resultAvailableUntil
    }
}

public struct ScheduledQueryRunList: Codable {
    public var object: String
    public var data: [ScheduledQueryRun]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [ScheduledQueryRun]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

public struct ScheduledQueryRunError: Codable {
    /// Information about the run failure.
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}

public enum ScheduledQueryRunStatus: String, Codable {
    case completed
    case canceled
    case failed
    case timedOut = "time_out"
}
