//
//  Exports.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

// StripeKit is split into modules so none is too big to optimize in one compiler process.
// Importing StripeKit brings in all of them, so callers never import the others themselves.
@_exported import StripeKitCore
@_exported import StripeKitModels
@_exported import StripeKitParams
