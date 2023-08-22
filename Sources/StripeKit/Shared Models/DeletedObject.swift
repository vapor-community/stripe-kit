//
//  DeletedObject.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//


public struct DeletedObject: Codable {
    public var id: String
    public var object: String
    public var deleted: Bool
    
    public init(id: String,
                object: String,
                deleted: Bool) {
        self.id = id
        self.object = object
        self.deleted = deleted
    }
}
