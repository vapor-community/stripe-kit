//
//  Tax Code.swift
//  
//
//  Created by Andrew Edwards on 12/16/21.
//

import Foundation

public struct TaxCode: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A detailed description of which types of products the tax code represents.
    public var description: String
    /// A short name for the tax code.
    public var name: String
    
    public init(id: String,
                object: String,
                description: String,
                name: String) {
        self.id = id
        self.object = object
        self.description = description
        self.name = name
    }
}

public struct TaxCodeList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TaxCode]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TaxCode]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
