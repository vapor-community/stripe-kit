// MARK: - Coverage Check
// Compares what the generator emitted with the spec, so nothing is dropped, misnamed or
// loosely typed without anyone noticing. Every deviation must either be fixed or listed with
// a reason in CoverageExceptions.swift; generation fails otherwise, and also fails when an
// exception no longer matches anything (so the list can't go stale).
//
// Checks:
//   missing   — a spec operation that isn't generated
//   duplicate — an operation generated on more than one route
//   name      — a route not named as the spec's x-stripeOperations names it
//               (a `{name}For{Parent}` or `{name}Current` collision suffix counts as the spec name)
//   return    — a route whose return type couldn't be read from the response schema
//   param     — a param typed looser than the spec (see ParamFallbacks)

import Foundation

struct CoverageCheck {
    let spec: OpenAPISpec
    let parser: SpecParser
    let resources: [StripeResource]
    /// Each resource's route operations, keyed by schema name
    let operations: [String: [RouteGenerator.RouteOperation]]
    let paramFallbacks: [String: String]
    let exceptions: [String: String]

    struct Operation {
        let method: String
        let path: String
        let routes: String
        let name: String
        let returnType: String
    }

    struct Issue {
        let key: String
        let detail: String
    }

    struct Result {
        /// Every generated route operation, sorted by method and path
        let operations: [Operation]
        /// Spec operations deliberately not generated (`missing` exceptions): "GET /v1/…" → reason
        let skipped: [String: String]
        /// Deviations covered by an exception
        let accepted: [(issue: Issue, reason: String)]
        /// Deviations with no exception
        let violations: [Issue]
        /// Exceptions that matched nothing
        let unusedExceptions: [String]
    }

    func run() -> Result {
        var operations: [Operation] = []
        var issues: [Issue] = []

        for resource in resources.sorted(by: { $0.swiftTypeName < $1.swiftTypeName }) {
            let routes = "\(resource.swiftTypeName)Routes"
            for op in self.operations[resource.schemaName] ?? [] {
                let returnType = op.returnType ?? resource.swiftTypeName
                operations.append(Operation(method: op.httpMethod, path: op.path, routes: routes, name: op.funcName, returnType: returnType))
                let endpoint = "\(op.httpMethod) \(op.path)"

                if let specName = parser.stripeMethodName(method: op.httpMethod, path: op.path, schemaName: resource.schemaName).map(snakeToCamel) {
                    if op.funcName != specName && !op.funcName.hasPrefix(specName + "For") && op.funcName != specName + "Current" {
                        issues.append(Issue(key: "name \(endpoint)", detail: "\(routes).\(op.funcName), spec names it \(specName)"))
                    }
                } else {
                    issues.append(Issue(key: "name \(endpoint)", detail: "\(routes).\(op.funcName), spec has no method name for it"))
                }

                if !op.returnTypeFromSpec {
                    issues.append(Issue(key: "return \(endpoint)", detail: "\(routes).\(op.funcName) returns \(returnType), not read from the response schema"))
                }
            }
        }
        operations.sort { ($0.path, $0.method) < ($1.path, $1.method) }

        let byEndpoint = Dictionary(grouping: operations, by: { "\($0.method) \($0.path)" })
        for (endpoint, ops) in byEndpoint where ops.count > 1 {
            issues.append(Issue(key: "duplicate \(endpoint)", detail: ops.map { "\($0.routes).\($0.name)" }.sorted().joined(separator: ", ")))
        }
        for endpoint in specEndpoints() where byEndpoint[endpoint] == nil {
            issues.append(Issue(key: "missing \(endpoint)", detail: "not generated"))
        }
        for (location, detail) in paramFallbacks {
            issues.append(Issue(key: "param \(location)", detail: detail))
        }
        issues.sort { $0.key < $1.key }

        let accepted = issues.compactMap { issue in exceptions[issue.key].map { (issue: issue, reason: $0) } }
        let violations = issues.filter { exceptions[$0.key] == nil }
        let issueKeys = Set(issues.map(\.key))
        let unused = exceptions.keys.filter { !issueKeys.contains($0) }.sorted()

        var skipped: [String: String] = [:]
        for (issue, reason) in accepted where issue.key.hasPrefix("missing ") {
            skipped[String(issue.key.dropFirst("missing ".count))] = reason
        }

        return Result(operations: operations, skipped: skipped, accepted: accepted, violations: violations, unusedExceptions: unused)
    }

    /// Every GET/POST/DELETE operation in the spec, as "METHOD /path"
    private func specEndpoints() -> [String] {
        spec.paths.flatMap { path, item in
            [("GET", item.get), ("POST", item.post), ("DELETE", item.delete)]
                .compactMap { method, op in op == nil ? nil : "\(method) \(path)" }
        }.sorted()
    }

    /// Swift source for the test target: every generated operation and every skipped one,
    /// which SpecCoverageTests checks against spec3.sdk.json.
    static func manifestSource(_ result: Result) -> String {
        var lines: [String] = [
            "//",
            "//  GeneratedOperations.swift",
            "//  StripeKitTests",
            "//",
            "//  Generated by stripe-kit-codegen",
            "//",
            "",
            "/// One API operation the generator emitted as a route.",
            "struct GeneratedOperation: Sendable {",
            "    let method: String",
            "    let path: String",
            "    let routes: String",
            "    let name: String",
            "    let returnType: String",
            "}",
            "",
            "/// Every operation the generator emitted.",
            "let generatedOperations: [GeneratedOperation] = [",
        ]
        for op in result.operations {
            lines.append("    GeneratedOperation(method: \(literal(op.method)), path: \(literal(op.path)), routes: \(literal(op.routes)), name: \(literal(op.name)), returnType: \(literal(op.returnType))),")
        }
        lines.append("]")
        lines.append("")
        lines.append("/// Spec operations deliberately not generated (\"METHOD /path\" → reason), from CoverageExceptions.swift.")
        if result.skipped.isEmpty {
            lines.append("let skippedOperations: [String: String] = [:]")
        } else {
            lines.append("let skippedOperations: [String: String] = [")
            for (endpoint, reason) in result.skipped.sorted(by: { $0.key < $1.key }) {
                lines.append("    \(literal(endpoint)): \(literal(reason)),")
            }
            lines.append("]")
        }
        lines.append("")
        return lines.joined(separator: "\n")
    }

    private static func literal(_ s: String) -> String {
        "\"" + s.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"") + "\""
    }
}
