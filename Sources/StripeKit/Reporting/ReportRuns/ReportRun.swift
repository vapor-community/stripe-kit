//
//  ReportRun.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import Foundation

/// The [Report Run Object](https://stripe.com/docs/api/reporting/report_run/object) .
public struct ReportRun: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Parameters of this report run.
    public var parameters: ReportRunParameters?
    /// The ID of the report type to run, such as `"balance.summary.1"`.
    public var reportType: String?
    /// The file object representing the result of the report run (populated when `status=succeeded`).
    public var result: File?
    /// Status of this report run. This will be `pending` when the run is initially created. When the run finishes, this will be set to `succeeded` and the `result` field will be populated. Rarely, we may encounter an error, at which point this will be set to `failed` and the `error` field will be populated.
    public var status: ReportRunStatus?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If something should go wrong during the run, a message about the failure (populated when `status=failed`).
    public var error: String?
    /// Always true: reports can only be run on live-mode data.
    public var livemode: Bool?
    /// Timestamp at which this run successfully finished (populated when `status=succeeded`). Measured in seconds since the Unix epoch.
    public var succeededAt: Date?
    
    public init(id: String,
                parameters: ReportRunParameters? = nil,
                reportType: String? = nil,
                result: File? = nil,
                status: ReportRunStatus? = nil,
                object: String,
                created: Date,
                error: String? = nil,
                livemode: Bool? = nil,
                succeededAt: Date? = nil) {
        self.id = id
        self.parameters = parameters
        self.reportType = reportType
        self.result = result
        self.status = status
        self.object = object
        self.created = created
        self.error = error
        self.livemode = livemode
        self.succeededAt = succeededAt
    }
}

public struct ReportRunParameters: Codable {
    /// The set of output columns requested for inclusion in the report run.
    public var columns: [String]?
    /// Connected account ID by which to filter the report run.
    public var connectedAccount: String?
    /// Currency of objects to be included in the report run.
    public var currency: Currency?
    /// Ending timestamp of data to be included in the report run (exclusive).
    public var intervalEnd: Date?
    /// Starting timestamp of data to be included in the report run.
    public var intervalStart: Date?
    /// Payout ID by which to filter the report run.
    public var payout: String?
    /// Category of balance transactions to be included in the report run.
    public var reportingCategory: String?
    /// Defaults to Etc/UTC. The output timezone for all timestamps in the report. A list of possible time zone values is maintained at the IANA Time Zone Database. Has no effect on `interval_start` or `interval_end`.
    public var timezone: String?
    
    public init(columns: [String]? = nil,
                connectedAccount: String? = nil,
                currency: Currency? = nil,
                intervalEnd: Date? = nil,
                intervalStart: Date? = nil,
                payout: String? = nil,
                reportingCategory: String? = nil,
                timezone: String? = nil) {
        self.columns = columns
        self.connectedAccount = connectedAccount
        self.currency = currency
        self.intervalEnd = intervalEnd
        self.intervalStart = intervalStart
        self.payout = payout
        self.reportingCategory = reportingCategory
        self.timezone = timezone
    }
}

public enum ReportRunStatus: String, Codable {
    case pending
    case succeeded
    case failed
}

public struct ReportRunList: Codable {
    public var object: String
    public var data: [ReportRun]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [ReportRun]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
