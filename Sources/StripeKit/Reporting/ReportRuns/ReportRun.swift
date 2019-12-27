//
//  ReportRun.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import Foundation

/// The [Report Run Object](https://stripe.com/docs/api/reporting/report_run/object) .
public struct StripeReportRun: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If something should go wrong during the run, a message about the failure (populated when `status=failed`).
    public var error: String?
    /// Always true: reports can only be run on live-mode data.
    public var livemode: Bool?
    /// Parameters of this report run.
    public var parameters: StripeReportRunParameters?
    /// The ID of the report type to run, such as `"balance.summary.1"`.
    public var reportType: String?
    /// The file object representing the result of the report run (populated when `status=succeeded`).
    public var result: StripeFile?
    /// Status of this report run. This will be `pending` when the run is initially created. When the run finishes, this will be set to `succeeded` and the `result` field will be populated. Rarely, we may encounter an error, at which point this will be set to `failed` and the `error` field will be populated.
    public var status: StripeReportRunStatus?
    /// Timestamp at which this run successfully finished (populated when `status=succeeded`). Measured in seconds since the Unix epoch.
    public var succeededAt: Date?
}

public struct StripeReportRunParameters: StripeModel {
    /// The set of output columns requested for inclusion in the report run.
    public var columns: [String]?
    /// Connected account ID by which to filter the report run.
    public var connectedAccount: String?
    /// Currency of objects to be included in the report run.
    public var currency: StripeCurrency?
    /// Ending timestamp of data to be included in the report run (exclusive).
    public var intervalEnd: Date?
    /// Starting timestamp of data to be included in the report run.
    public var intervalStart: Date?
    /// Payout ID by which to filter the report run.
    public var payout: String?
    /// Category of balance transactions to be included in the report run.
    public var reportingCategory: String?
}

public enum StripeReportRunStatus: String, StripeModel {
    case pending
    case succeeded
    case failed
}

public struct StripeReportRunList: StripeModel {
    public var object: String
    public var data: [StripeReportRun]?
    public var hasMore: Bool?
    public var url: String?
}
