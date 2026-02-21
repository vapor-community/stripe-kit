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

import Foundation

@main
struct CodegenCLI {
    static func main() async throws {
        let config = try parseArgs(CommandLine.arguments)
        
        printHeader()
        
        // ── 1. Load spec ──────────────────────────────────────────
        let specData = try Data(contentsOf: URL(fileURLWithPath: config.specPath))
        let spec = try JSONDecoder().decode(OpenAPISpec.self, from: specData)
        
        print("📄 Spec: \(config.specPath) (\(ByteCountFormatter.string(fromByteCount: Int64(specData.count), countStyle: .file)))")
        print("🔖 API Version: \(spec.info.version)")
        print("� \(spec.components.schemas.count) schemas, \(spec.paths.count) paths")
        print()
        
        // ── 2. Parse ──────────────────────────────────────────────
        let parser = SpecParser(spec: spec)
        let resources = parser.parseResources()
        let inlineSchemas = parser.parseInlineSchemas()
        
        // Build resource type name set for collision detection
        let resourceTypeNames = Set(resources.map(\.swiftTypeName))
        
        print("� Parsed \(resources.count) resources, \(inlineSchemas.count) inline types")
        print()
        
        // ── 3. Initialize generators ─────────────────────────────
        let pathMapping = parser.buildPathMapping()
        print("🗺️  Path mapping: \(pathMapping.count) schemas → API paths")
        let modelGen = ModelGenerator(allSchemas: spec.components.schemas)
        let routeGen = RouteGenerator(spec: spec, parser: parser, pathMapping: pathMapping)
        let paramGen = ParamGenerator(spec: spec, parser: parser, pathMapping: pathMapping)
        
        let outputDir = URL(fileURLWithPath: config.outputDir)
        let fileManager = FileManager.default
        
        // Clean generated directory (preserves hand-written Infrastructure/)
        let generatedDir = outputDir.appendingPathComponent("Generated")
        if fileManager.fileExists(atPath: generatedDir.path) {
            try fileManager.removeItem(at: generatedDir)
        }
        
        var modelCount = 0
        var routeCount = 0
        var paramCount = 0
        var inlineCount = 0
        
        // ── 4. Generate resources ─────────────────────────────────
        //
        // Output structure:
        //   Generated/Models/{Domain}/{TypeName}.swift
        //   Generated/Routes/{Domain}/{TypeName}Routes.swift
        //   Generated/Params/{Domain}/{TypeName}+Params.swift
        //
        print("📦 Generating resources...")
        
        for resource in resources {
            let domain = resource.domain.directoryName
            
            // Model
            let modelDir = generatedDir
                .appendingPathComponent("Models")
                .appendingPathComponent(domain)
            try fileManager.createDirectory(at: modelDir, withIntermediateDirectories: true)
            
            let modelSource = modelGen.generate(resource: resource)
            let modelFile = modelDir.appendingPathComponent("\(resource.swiftTypeName).swift")
            try modelSource.write(to: modelFile, atomically: true, encoding: .utf8)
            modelCount += 1
            
            // Routes
            if let routeSource = routeGen.generate(resource: resource) {
                let routeDir = generatedDir
                    .appendingPathComponent("Routes")
                    .appendingPathComponent(domain)
                try fileManager.createDirectory(at: routeDir, withIntermediateDirectories: true)
                
                let routeFile = routeDir.appendingPathComponent("\(resource.swiftTypeName)Routes.swift")
                try routeSource.write(to: routeFile, atomically: true, encoding: .utf8)
                routeCount += 1
            }
            
            // Params
            if let paramSource = paramGen.generate(resource: resource) {
                let paramDir = generatedDir
                    .appendingPathComponent("Params")
                    .appendingPathComponent(domain)
                try fileManager.createDirectory(at: paramDir, withIntermediateDirectories: true)
                
                let paramFile = paramDir.appendingPathComponent("\(resource.swiftTypeName)+Params.swift")
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
                    let enumFile = paramDir.appendingPathComponent("\(resource.swiftTypeName)+ParamEnums.swift")
                    try enumSource.joined(separator: "\n").write(to: enumFile, atomically: true, encoding: .utf8)
                }
            }
        }
        
        // ── 5. Generate inline types ──────────────────────────────
        //
        // Output structure:
        //   Generated/Types/{TypeName}.swift
        //
        // Inline schemas that collide with a resource name get
        // prefixed to disambiguate (e.g., request → ForwardingRequest)
        //
        let typesDir = generatedDir.appendingPathComponent("Types")
        try fileManager.createDirectory(at: typesDir, withIntermediateDirectories: true)
        
        for inline in inlineSchemas {
            let modelSource = modelGen.generate(resource: inline)
            let modelFile = typesDir.appendingPathComponent("\(inline.swiftTypeName).swift")
            try modelSource.write(to: modelFile, atomically: true, encoding: .utf8)
            inlineCount += 1
        }
        
        // ── 6. Generate StripeClient (route wiring) ───────────────
        //
        // Only the client needs regeneration — it wires all route
        // structs into a single entry point. Everything else in
        // Infrastructure/ is hand-written API surface.
        //
        let infraGen = InfraGenerator(spec: spec, parser: parser, resources: resources, pathMapping: pathMapping)
        let clientSource = infraGen.generateStripeClient()
        try clientSource.write(
            to: outputDir.appendingPathComponent("Generated").appendingPathComponent("StripeClient.swift"),
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
        print(" API Version: \(spec.info.version)")
        print("📂 Output: \(config.outputDir)/Generated/")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    }
    
    // MARK: - CLI
    
    struct Config {
        let specPath: String
        let outputDir: String
    }
    
    static func parseArgs(_ args: [String]) throws -> Config {
        var specPath = "spec3.sdk.json"
        var outputDir = "Sources/StripeKit"
        
        var i = 1
        while i < args.count {
            switch args[i] {
            case "--spec", "-s":
                i += 1
                guard i < args.count else { throw CodegenError.missingArgValue("--spec") }
                specPath = args[i]
            case "--output", "-o":
                i += 1
                guard i < args.count else { throw CodegenError.missingArgValue("--output") }
                outputDir = args[i]
            case "--help", "-h":
                printUsage()
                Foundation.exit(0)
            default:
                break
            }
            i += 1
        }
        
        return Config(specPath: specPath, outputDir: outputDir)
    }
    
    static func printHeader() {
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("  stripe-kit-codegen")
        print("  Generate Swift types from Stripe OpenAPI spec")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print()
    }
    
    static func printUsage() {
        print("""
        USAGE: stripe-kit-codegen [options]
        
        OPTIONS:
          --spec, -s <path>    Path to OpenAPI spec (default: spec3.sdk.json)
          --output, -o <dir>   Output directory (default: Sources/StripeKit)
          --help, -h           Show this help
        
        EXAMPLES:
          stripe-kit-codegen
          stripe-kit-codegen --spec spec3.sdk.json --output Sources/StripeKit
        """)
    }
}

enum CodegenError: Error, CustomStringConvertible {
    case missingArgValue(String)
    
    var description: String {
        switch self {
        case .missingArgValue(let arg): return "Missing value for argument: \(arg)"
        }
    }
}
