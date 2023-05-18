//
//  Utilities.swift
//  
//
//  Created by Andrew Edwards on 5/18/23.
//

import XCTest

/// This is only needed because the "real" `XCTUnwrap()` doesn't accept an async autoclosure (it's waiting for reasync).
func XCTUnwrapAsync<T>(
    _ expression: @autoclosure () async throws -> T?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async throws -> T {
    let result = try await expression()
    return try XCTUnwrap(result, message(), file: file, line: line)
}

/// Same thing for this as above. Unfortunately, thanks to the lack of resasync, we have to force both expression autoclosures to be async.
func XCTAssertEqualAsync<T>(
    _ expression1: @autoclosure () async throws -> T,
    _ expression2: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async where T: Equatable {
    do {
        let expr1 = try await expression1()
        let expr2 = try await expression2()

        return XCTAssertEqual(expr1, expr2, message(), file: file, line: line)
    } catch {
        // Trick XCTest into behaving correctly for a thrown error.
        return XCTAssertEqual(try { () -> Bool in throw error }(), false, message(), file: file, line: line)
    }
}

/// Same as above for equality with numeric accuracy.
func XCTAssertEqualAsync<T>(
    _ expression1: @autoclosure () async throws -> T, _ expression2: @autoclosure () async throws -> T, accuracy: T,
    _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line
) async where T: Numeric {
    do {
        let expr1 = try await expression1(), expr2 = try await expression2()
        return XCTAssertEqual(expr1, expr2, accuracy: accuracy, message(), file: file, line: line)
    } catch {
        return XCTAssertEqual(try { () -> Bool in throw error }(), false, message(), file: file, line: line)
    }
}

/// Same as above for equality with floating-point accuracy.
func XCTAssertEqualAsync<T>(
    _ expression1: @autoclosure () async throws -> T, _ expression2: @autoclosure () async throws -> T, accuracy: T,
    _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line
) async where T: FloatingPoint {
    do {
        let expr1 = try await expression1(), expr2 = try await expression2()
        return XCTAssertEqual(expr1, expr2, accuracy: accuracy, message(), file: file, line: line)
    } catch {
        return XCTAssertEqual(try { () -> Bool in throw error }(), false, message(), file: file, line: line)
    }
}

/// Same as above for simple truth assertion
func XCTAssertTrueAsync(_ predicate: @autoclosure () async throws -> Bool, file: StaticString = #filePath, line: UInt = #line) async rethrows {
    let result = try await predicate()
    XCTAssertTrue(result, file: file, line: line)
}

/// Same as above for simple mistruth assertion
func XCTAssertFalseAsync(_ predicate: @autoclosure () async throws -> Bool, file: StaticString = #filePath, line: UInt = #line) async rethrows {
    let result = try await predicate()
    XCTAssertFalse(result, file: file, line: line)
}

/// Same as above for thrown error assertion
func XCTAssertThrowsErrorAsync<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (Error) -> () = { _ in }
) async {
    do {
        _ = try await expression()
        XCTAssertThrowsError(try { () throws -> () in }, message(), file: file, line: line, errorHandler)
    } catch {
        XCTAssertThrowsError(try { () throws -> () in throw error }, message(), file: file, line: line, errorHandler)
    }
}

/// Same as above for nil-ness assertion
func XCTAssertNilAsync(_ expression: @autoclosure () async throws -> Any?, file: StaticString = #filePath, line: UInt = #line) async rethrows {
    let result = try await expression()
    XCTAssertNil(result, file: file, line: line)
}

/// Same as above for non-nil-ness assertion
func XCTAssertNotNilAsync(_ expression: @autoclosure () async throws -> Any?, file: StaticString = #filePath, line: UInt = #line) async rethrows {
    let result = try await expression()
    XCTAssertNotNil(result, file: file, line: line)
}
