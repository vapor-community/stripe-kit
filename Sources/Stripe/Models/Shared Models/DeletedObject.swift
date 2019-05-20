//
//  DeletedObject.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//


public struct StripeDeletedObject: StripeModel {
    public var id: String
    public var object: String
    public var deleted: Bool
}
