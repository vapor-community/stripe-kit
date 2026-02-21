// MARK: - stripe-kit-codegen CLI
//
// Generates Swift types, routes, and params from the Stripe OpenAPI spec.
//
// What gets regenerated:
//   Sources/StripeKit/Generated/
//     ├── Models/           — Codable structs per resource (Account.swift, Customer.swift, ...)
//     ├── Routes/           — @Sendable closure-based route structs + .live() + .test stubs
//     ├── Params/           — Typed param structs for create/update operations
//     ├── Types/            — Inline schemas (shared sub-types referenced by resources)
//     └── StripeClient.swift — Auto-wired client with all route properties
//
// What stays hand-written (Infrastructure/):
//     ├── StripeAPIHandler.swift   — HTTP transport, request encoding
//     ├── StripeExpandable.swift   — @Expandable / @DynamicExpandable property wrappers
//     ├── StripeError.swift        — Error types
//     ├── StripeParams.swift       — StripeParams protocol
//     └── Helpers.swift            — Query encoding utilities
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
        
        // Build resource type name set for collision detection
        let resourceTypeNames = Set(resources.map(\.swiftTypeName))
        _ = resourceTypeNames  // used by inline schema generation
        
        print("📊 Parsed \(resources.count) resources, \(inlineSchemas.count) inline types")
        print()
        
        // ── 3. Initialize generators ─────────────────────────────
        let pathMapping = parser.buildPathMapping()
        print("🗺️  Path mapping: \(pathMapping.count) schemas → API paths")
        let modelGen = ModelGenerator(allSchemas: openAPISpec.components.schemas)
        let routeGen = RouteGenerator(spec: openAPISpec, parser: parser, pathMapping: pathMapping)
        let paramGen = ParamGenerator(spec: openAPISpec, parser: parser, pathMapping: pathMapping)
        
        let outputURL = URL(filePath: output)
        
        // Clean generated directory (preserves hand-written Infrastructure/)
        let generatedURL = outputURL.appending(path: "Generated")
        if FileManager.default.fileExists(atPath: generatedURL.path()) {
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
            if let routeSource = routeGen.generate(resource: resource) {
                let routeDir = generatedURL
                    .appending(path: "Routes")
                    .appending(path: domain)
                try FileManager.default.createDirectory(at: routeDir, withIntermediateDirectories: true)
                
                let routeFile = routeDir.appending(path: "\(resource.swiftTypeName)Routes.swift")
                try routeSource.write(to: routeFile, atomically: true, encoding: .utf8)
                routeCount += 1
            }
            
            // Params
            if let paramSource = paramGen.generate(resource: resource) {
                let paramDir = generatedURL
                    .appending(path: "Params")
                    .appending(path: domain)
                try FileManager.default.createDirectory(at: paramDir, withIntermediateDirectories: true)
                
                let paramFile = paramDir.appending(path: "\(resource.swiftTypeName)+Params.swift")
                try paramSource.write(to: paramFile, atomically: true, encoding: .utf8)
                paramCount += 1
                
                // Param enums (if any)
                let enumLines = paramGen.generateParamEnums(resource: resource)
                if !enumLines.isEmpty {
                    let enumSource = [
                        "//",
                        "//  \(resource.swiftTypeName)+ParamEnums.swift",
                        "//  StripeKit",
                        "//",
                        "//  Generated by stripe-kit-codegen",
                        "//",
                        "",
                        "import Foundation",
                        "",
                    ] + enumLines
                    let enumFile = paramDir.appending(path: "\(resource.swiftTypeName)+ParamEnums.swift")
                    try enumSource.joined(separator: "\n").write(to: enumFile, atomically: true, encoding: .utf8)
                }
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
        let infraGen = InfraGenerator(spec: openAPISpec, parser: parser, resources: resources, pathMapping: pathMapping)
        let clientSource = infraGen.generateStripeClient()
        try clientSource.write(
            to: generatedURL.appending(path: "StripeClient.swift"),
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
        print("  └── StripeClient.swift")
        print()
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("📦 \(modelCount + inlineCount) types, \(routeCount) routes, \(paramCount) params")
        print(" API Version: \(openAPISpec.info.version)")
        print("📂 Output: \(output)/Generated/")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    }
    
    private func printHeader() {
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("  stripe-kit-codegen")
        print("  Generate Swift types from Stripe OpenAPI spec")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print()
    }
}
