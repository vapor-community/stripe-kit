//
//  Reader.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import Foundation

/// The [Reader Object](https://stripe.com/docs/api/terminal/readers/object).
public struct StripeReader: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The current software version of the reader.
    public var deviceSwVersion: String?
    /// Type of reader, one of`verifone_P400` or `bbpos_chipper2x`.
    public var deviceType: String?
    /// The local IP address of the reader.
    public var ipAddress: String?
    /// Custom label given to the reader for easier identification.
    public var label: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The location identifier of the reader.
    public var location: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Serial number of the reader.
    public var serialNumber: String?
    /// The networking status of the reader.
    public var status: String?
}

public struct StripeReaderList: StripeModel {
    public var object: String
    public var data: [StripeReader]?
    public var hasMore: Bool?
    public var url: String?
}
