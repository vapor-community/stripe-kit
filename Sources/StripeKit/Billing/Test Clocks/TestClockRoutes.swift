//
//  TestClockRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/14/23.
//

import NIO
import NIOHTTP1
import Foundation

public protocol TestClockRoutes: StripeAPIRoute {
    /// Creates a new test clock that can be attached to new customers and quotes.
    /// - Parameters:
    ///   - frozenTime: The initial frozen time for this test clock.
    ///   - name: The name for this test clock.
    /// - Returns: The newly created ``TestClock`` object is returned upon success. Otherwise, this call returns an error.
    func create(frozenTime: Date, name: String?) async throws -> TestClock
    
    
    /// Retrieves a test clock.
    /// - Parameter testClock: Id of the test clock.
    /// - Returns: Returns the ``TestClock`` object. Otherwise, this call returns an error.
    func retrieve(testClock: String) async throws -> TestClock
    
    /// Deletes a test clock.
    /// - Parameter testClock: Id of the test clock.
    /// - Returns: The deleted ``TestClock`` object is returned upon success. Otherwise, this call returns an error.
    func delete(testClock: String) async throws -> DeletedObject
    
    /// Starts advancing a test clock to a specified time in the future. Advancement is done when status changes to `Ready`.
    /// - Parameters:
    ///   - testClock: Id of the test clock.
    ///   - frozenTime: The time to advance the test clock. Must be after the test clock’s current frozen time. Cannot be more than two intervals in the future from the shortest subscription in this test clock. If there are no subscriptions in this test clock, it cannot be more than two years in the future.
    /// - Returns: A ``TestClock`` object with status `Advancing` is returned upon success. Otherwise, this call returns an error.
    func advance(testClock: String, frozenTime: Date) async throws -> TestClock
    
    
    /// Returns a list of your test clocks.
    /// - Parameter filter: A dictionary used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` test clocks, starting after `starting_after`. Each entry in the array is a separate test clock object. If no more test clocks are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> TestClockList
}

public struct StripeTestClockRoutes: TestClockRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let testclocks = APIBase + APIVersion + "test_helpers/test_clocks"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(frozenTime: Date, name: String?) async throws -> TestClock {
        var body: [String: Any] = ["frozen_time": Int(frozenTime.timeIntervalSince1970)]
        
        if let name {
            body["name"] = name
        }
        
        return try await apiHandler.send(method: .POST, path: testclocks, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(testClock: String) async throws -> TestClock {
        try await apiHandler.send(method: .GET, path: "\(testclocks)/\(testClock)", headers: headers)
    }
    
    public func delete(testClock: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(testclocks)/\(testClock)", headers: headers)
    }
    
    public func advance(testClock: String, frozenTime: Date) async throws -> TestClock {
        var body: [String: Any] = ["frozen_time": Int(frozenTime.timeIntervalSince1970)]
        
        return try await apiHandler.send(method: .POST, path: "\(testclocks)/\(testClock)/advance", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]?) async throws -> TestClockList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: testclocks, query: queryParams, headers: headers)
    }
}
