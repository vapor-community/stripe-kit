import Foundation
import Testing
import StripeKit

/// Checks the generated routes cover the spec: every operation in `spec3.sdk.json` is generated
/// exactly once or deliberately skipped, and nothing generated is missing from the spec.
///
/// `Generated/GeneratedOperations.swift` is written by stripe-kit-codegen, which runs the full
/// coverage check (names, return types, param typing) and fails on unexplained deviations.
/// This test catches what the generator can't: a spec updated without regenerating.
@Suite("Spec coverage")
struct SpecCoverageTests {

    /// "METHOD /path" for every GET/POST/DELETE operation in spec3.sdk.json at the repo root
    static let specOperations: Set<String> = {
        let specURL = URL(filePath: #filePath)
            .deletingLastPathComponent()  // StripeKitTests
            .deletingLastPathComponent()  // Tests
            .deletingLastPathComponent()  // repo root
            .appending(path: "spec3.sdk.json")
        guard let data = try? Data(contentsOf: specURL),
              let spec = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let paths = spec["paths"] as? [String: [String: Any]]
        else { return [] }
        var operations = Set<String>()
        for (path, item) in paths {
            for method in ["get", "post", "delete"] where item[method] != nil {
                operations.insert("\(method.uppercased()) \(path)")
            }
        }
        return operations
    }()

    static let generated: [String: [GeneratedOperation]] =
        Dictionary(grouping: generatedOperations, by: { "\($0.method) \($0.path)" })

    @Test("The spec loads")
    func specLoads() {
        #expect(Self.specOperations.count > 500, "couldn't read spec3.sdk.json from the repo root")
    }

    @Test("Every spec operation is generated or skipped with a reason")
    func everySpecOperationIsCovered() {
        let uncovered = Self.specOperations
            .filter { Self.generated[$0] == nil && skippedOperations[$0] == nil }
            .sorted()
        #expect(uncovered.isEmpty, "Not generated, and not in CoverageExceptions.swift. Regenerate with stripe-kit-codegen: \(uncovered)")
    }

    @Test("Every generated or skipped operation is in the spec")
    func nothingStale() {
        let stale = (Set(Self.generated.keys).union(skippedOperations.keys))
            .subtracting(Self.specOperations)
            .sorted()
        #expect(stale.isEmpty, "Not in spec3.sdk.json; regenerate with stripe-kit-codegen: \(stale)")
    }

    @Test("No operation is generated twice")
    func noDuplicates() {
        let duplicates = Self.generated
            .filter { $0.value.count > 1 }
            .map { "\($0.key): \($0.value.map { "\($0.routes).\($0.name)" }.joined(separator: ", "))" }
            .sorted()
        #expect(duplicates.isEmpty, "\(duplicates)")
    }

    /// Routes that need special handling in the generator. The key paths only compile if
    /// the routes have these signatures.
    @Test("File and current-object routes have their expected signatures")
    func specialRouteSignatures() {
        // application/pdf from files.stripe.com, returned as bytes
        let _: KeyPath<QuoteRoutes, @Sendable (String, [String]?) async throws -> Data> = \.pdf
        // GET /v1/account: the API key's own account, next to GET /v1/accounts/{account}
        let _: KeyPath<AccountRoutes, @Sendable ([String]?) async throws -> Account> = \.retrieveCurrent
    }

    @Test("Skipped operations aren't also generated")
    func skippedAreNotGenerated() {
        let both = skippedOperations.keys.filter { Self.generated[$0] != nil }.sorted()
        #expect(both.isEmpty, "\(both)")
    }
}
