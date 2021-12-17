//
//  Tax Code.swift
//  
//
//  Created by Andrew Edwards on 12/16/21.
//

import Foundation

public struct StripeTaxCode: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A detailed description of which types of products the tax code represents.
    public var description: String
    /// A short name for the tax code.
    public var name: String
}

public struct StripeTaxCodeList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeTaxCode]?
}
