// MARK: - stripe-kit-codegen CLI
//
// Generates Swift types, routes, and params from the Stripe OpenAPI spec.
//
// What gets regenerated:
//   Sources/StripeKit/Generated/
//     ├── Models/           — Codable structs per resource (Account.swift, Customer.swift, ...)
//     ├── Routes/           — @Sendable closure-based route structs + .live(handler:) factories
//     ├── Params/           — Typed param structs for create/update operations
//     ├── Types/            — Inline schemas (shared sub-types referenced by resources)
//     ├── StripeClient.swift — Auto-wired client with all route properties
//     ├── StripeEventType.swift — Enum of the spec's event types
//     └── StripeEvent.swift  — The event struct, from the spec's `event` schema
//   Tests/StripeKitTests/Generated/
//     ├── FixtureTypes.swift — Schema name → Swift type map for fixture decoding tests
//     └── GeneratedOperations.swift — Operation manifest checked by SpecCoverageTests
//
// What stays hand-written (Infrastructure/):
//     ├── StripeAPIHandler.swift   — HTTP transport
//     ├── StripeClient+Scoping.swift — Connected-account and idempotency scoping
//     ├── StripeExpandable.swift   — @Expandable / @ExpandableCollection property wrappers
//     ├── Indirect.swift           — @Indirect, storing embedded resources out of line
//     ├── StripeError.swift        — Error types
//     ├── StripeEvent+Webhooks.swift — EventData, EventRequest, webhook signature verification
//     ├── JSONValue.swift          — Any JSON value (free-form objects, raw event data)
//     ├── StripeParams.swift       — StripeParams protocol and form encoding
//     ├── StripeRangeQuery.swift   — Range filters for list params (`created`, …)
//     ├── StripeSearchResult.swift — Search endpoint responses
//     └── ObjectOrDeleted.swift    — Object-or-deleted-object responses
//
// The codegen always processes the full spec — no domain filtering.
// Idempotent: running twice with the same spec produces identical output.

import ArgumentParser
import Foundation

@main
struct CodegenCLI: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "stripe-kit-codegen",
        abstract: "Generate Swift types from Stripe OpenAPI spec"
    )

    @Option(name: [.long, .customShort("s")], help: "Path to OpenAPI spec")
    var spec: String = "spec3.sdk.json"

    @Option(name: [.long, .customShort("o")], help: "Output directory")
    var output: String = "Sources/StripeKit"

    @Option(name: [.long, .customShort("t")], help: "Test target directory (for the fixture type registry)")
    var testsOutput: String = "Tests/StripeKitTests"

    func run() async throws {
        printHeader()
        
        // ── 1. Load spec ──────────────────────────────────────────
        let specURL = URL(filePath: spec)
        let specData = try Data(contentsOf: specURL)
        let openAPISpec = try JSONDecoder().decode(OpenAPISpec.self, from: specData)
        
        print("📄 Spec: \(spec) (\(ByteCountFormatter.string(fromByteCount: Int64(specData.count), countStyle: .file)))")
        print("🔖 API Version: \(openAPISpec.info.version)")
        print("📋 \(openAPISpec.components.schemas.count) schemas, \(openAPISpec.paths.count) paths")
        print()
        
        // ── 2. Parse ──────────────────────────────────────────────
        let parser = SpecParser(spec: openAPISpec)
        let resources = parser.parseResources()
        let inlineSchemas = parser.parseInlineSchemas()
        
        print("📊 Parsed \(resources.count) resources, \(inlineSchemas.count) inline types")
        print()
        
        // ── 3. Initialize generators ─────────────────────────────
        let pathMapping = parser.buildPathMapping()
        print("🗺️  Path mapping: \(pathMapping.count) schemas → API paths")
        let modelGen = ModelGenerator(parser: parser, resources: resources, inlineTypes: inlineSchemas)
        let routeGen = RouteGenerator(spec: openAPISpec, parser: parser, pathMapping: pathMapping)
        let paramGen = ParamGenerator(spec: openAPISpec, parser: parser)

        // Each resource's operations, computed once and shared by every generator below
        let operations = Dictionary(uniqueKeysWithValues: resources.map { ($0.schemaName, routeGen.findOperations(for: $0)) })
        
        let outputURL = URL(filePath: output)
        
        // Clean generated directory (preserves hand-written Infrastructure/)
        let generatedURL = outputURL.appending(path: "Generated")
        // path(percentEncoded: false): path() percent-encodes, so a checkout path containing a
        // space never matched and stale files from earlier runs were left behind.
        if FileManager.default.fileExists(atPath: generatedURL.path(percentEncoded: false)) {
            try FileManager.default.removeItem(at: generatedURL)
        }
        
        var modelCount = 0
        var routeCount = 0
        var paramCount = 0
        var inlineCount = 0
        
        // ── 4. Generate resources ─────────────────────────────────
        print("📦 Generating resources...")
        
        for resource in resources {
            let domain = resource.domain.directoryName
            let routeOperations = operations[resource.schemaName] ?? []
            let paramOperations = paramGen.paramOperations(for: resource, routes: routeOperations)
            
            // Model
            let modelDir = generatedURL
                .appending(path: "Models")
                .appending(path: domain)
            try FileManager.default.createDirectory(at: modelDir, withIntermediateDirectories: true)
            
            let modelSource = modelGen.generate(resource: resource)
            let modelFile = modelDir.appending(path: "\(resource.swiftTypeName).swift")
            try modelSource.write(to: modelFile, atomically: true, encoding: .utf8)
            modelCount += 1
            
            // Routes
            if let routeSource = routeGen.generate(resource: resource, operations: routeOperations) {
                let routeDir = generatedURL
                    .appending(path: "Routes")
                    .appending(path: domain)
                try FileManager.default.createDirectory(at: routeDir, withIntermediateDirectories: true)
                
                let routeFile = routeDir.appending(path: "\(resource.swiftTypeName)Routes.swift")
                try routeSource.write(to: routeFile, atomically: true, encoding: .utf8)
                routeCount += 1
            }
            
            // Params
            if let paramSource = paramGen.generate(resource: resource, operations: paramOperations) {
                let paramDir = generatedURL
                    .appending(path: "Params")
                    .appending(path: domain)
                try FileManager.default.createDirectory(at: paramDir, withIntermediateDirectories: true)
                
                let paramFile = paramDir.appending(path: "\(resource.swiftTypeName)+Params.swift")
                try paramSource.write(to: paramFile, atomically: true, encoding: .utf8)
                paramCount += 1
            }
        }
        
        // ── 5. Generate inline types ──────────────────────────────
        let typesDir = generatedURL.appending(path: "Types")
        try FileManager.default.createDirectory(at: typesDir, withIntermediateDirectories: true)
        
        for inline in inlineSchemas {
            let modelSource = modelGen.generate(resource: inline)
            let modelFile = typesDir.appending(path: "\(inline.swiftTypeName).swift")
            try modelSource.write(to: modelFile, atomically: true, encoding: .utf8)
            inlineCount += 1
        }
        
        // ── 6. Generate StripeClient (route wiring) ───────────────
        let infraGen = InfraGenerator(
            spec: openAPISpec,
            resources: resources,
            routedResources: resources.filter { operations[$0.schemaName]?.isEmpty == false }
        )
        let clientSource = infraGen.generateStripeClient()
        try clientSource.write(
            to: generatedURL.appending(path: "StripeClient.swift"),
            atomically: true,
            encoding: .utf8
        )
        
        // ── 7. Generate StripeEventType enum ──────────────────────
        let eventTypeSource = infraGen.generateEventType()
        try eventTypeSource.write(
            to: generatedURL.appending(path: "StripeEventType.swift"),
            atomically: true,
            encoding: .utf8
        )
        
        // ── 8. Generate StripeEvent struct ────────────────────────
        let eventSource = infraGen.generateStripeEvent()
        try eventSource.write(
            to: generatedURL.appending(path: "StripeEvent.swift"),
            atomically: true,
            encoding: .utf8
        )
        
        // ── 9. Generate test fixture type registry ────────────────
        let testsGeneratedURL = URL(filePath: testsOutput).appending(path: "Generated")
        try FileManager.default.createDirectory(at: testsGeneratedURL, withIntermediateDirectories: true)
        try infraGen.generateFixtureTypeRegistry(inlineSchemas: inlineSchemas).write(
            to: testsGeneratedURL.appending(path: "FixtureTypes.swift"),
            atomically: true,
            encoding: .utf8
        )

        // ── 10. Coverage check against the spec ───────────────────
        let coverage = CoverageCheck(
            spec: openAPISpec,
            parser: parser,
            resources: resources,
            operations: operations,
            paramFallbacks: paramGen.fallbacks.entries,
            exceptions: coverageExceptions
        ).run()
        try CoverageCheck.manifestSource(coverage).write(
            to: testsGeneratedURL.appending(path: "GeneratedOperations.swift"),
            atomically: true,
            encoding: .utf8
        )

        // ── Summary ───────────────────────────────────────────────
        print()
        print("  Generated/")
        print("  ├── Models/       \(modelCount) resources")
        print("  ├── Routes/       \(routeCount) route files")
        print("  ├── Params/       \(paramCount) param files")
        print("  ├── Types/        \(inlineCount) inline schemas")
        print("  ├── StripeClient.swift")
        print("  ├── StripeEventType.swift")
        print("  └── StripeEvent.swift")
        print()
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("📦 \(modelCount + inlineCount) types, \(routeCount) routes, \(paramCount) params")
        print("🔔 StripeEventType enum + StripeEvent struct")
        print(" API Version: \(openAPISpec.info.version)")
        print("📂 Output: \(output)/Generated/")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print()
        print("🔍 Coverage: \(coverage.operations.count) operations generated, \(coverage.skipped.count) skipped, \(coverage.accepted.count) accepted deviations")

        guard coverage.violations.isEmpty && coverage.unusedExceptions.isEmpty else {
            if !coverage.violations.isEmpty {
                print()
                print("❌ \(coverage.violations.count) deviation(s) from the spec. Fix each, or add it with a reason to Sources/Codegen/CoverageExceptions.swift:")
                for issue in coverage.violations {
                    print("   \"\(issue.key)\"  — \(issue.detail)")
                }
            }
            if !coverage.unusedExceptions.isEmpty {
                print()
                print("❌ \(coverage.unusedExceptions.count) exception(s) in CoverageExceptions.swift no longer match anything. Remove them:")
                for key in coverage.unusedExceptions {
                    print("   \"\(key)\"")
                }
            }
            throw ExitCode.failure
        }
    }
    
    private func printHeader() {
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("  stripe-kit-codegen")
        print("  Generate Swift types from Stripe OpenAPI spec")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print()
    }
}
