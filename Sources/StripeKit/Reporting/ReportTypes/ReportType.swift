//
//  ReportType.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import Foundation

/// The [Report Type Object](https://stripe.com/docs/api/reporting/report_type/object) .
public struct StripeReportType: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Most recent time for which this Report Type is available. Measured in seconds since the Unix epoch.
    public var dataAvailableEnd: Date?
    /// Earliest time for which this Report Type is available. Measured in seconds since the Unix epoch.
    public var dataAvailableStart: Date?
    /// List of column names that are included by default when this Report Type gets run. (If the Report Type doesn’t support the columns parameter, this will be null.)
    public var defaultColumns: [String]?
    /// Human-readable name of the Report Type
    public var name: String?
    /// When this Report Type was latest updated. Measured in seconds since the Unix epoch.
    public var updated: Date?
    /// Version of the Report Type. Different versions report with the same ID will have the same purpose, but may take different run parameters or have different result schemas.
    public var version: Int?
}

public struct StripeReportTypeList: StripeModel {
    public var object: String
    public var data: [StripeReportType]?
    public var hasMore: Bool?
    public var url: String?
    
    public enum CodingKeys: String, CodingKey {
        case object, url, data
        case hasMore = "has_more"
    }
}
