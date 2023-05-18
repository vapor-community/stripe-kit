//
//  ReportType.swift
//  
//
//  Created by Andrew Edwards on 12/3/19.
//

import Foundation

/// The [Report Type Object](https://stripe.com/docs/api/reporting/report_type/object) .
public struct ReportType: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Most recent time for which this Report Type is available. Measured in seconds since the Unix epoch.
    public var dataAvailableEnd: Date?
    /// Earliest time for which this Report Type is available. Measured in seconds since the Unix epoch.
    public var dataAvailableStart: Date?
    /// Human-readable name of the Report Type
    public var name: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// List of column names that are included by default when this Report Type gets run. (If the Report Type doesn’t support the columns parameter, this will be null.)
    public var defaultColumns: [String]?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// When this Report Type was latest updated. Measured in seconds since the Unix epoch.
    public var updated: Date?
    /// Version of the Report Type. Different versions report with the same ID will have the same purpose, but may take different run parameters or have different result schemas.
    public var version: Int?
    
    public init(id: String,
                dataAvailableEnd: Date? = nil,
                dataAvailableStart: Date? = nil,
                name: String? = nil,
                object: String,
                defaultColumns: [String]? = nil,
                livemode: Bool,
                updated: Date? = nil,
                version: Int? = nil) {
        self.id = id
        self.dataAvailableEnd = dataAvailableEnd
        self.dataAvailableStart = dataAvailableStart
        self.name = name
        self.object = object
        self.defaultColumns = defaultColumns
        self.livemode = livemode
        self.updated = updated
        self.version = version
    }
}

public struct ReportTypeList: Codable {
    public var object: String
    public var data: [ReportType]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [ReportType]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
