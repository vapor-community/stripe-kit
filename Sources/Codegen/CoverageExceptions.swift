// MARK: - Coverage Exceptions
// Known, accepted deviations from the spec, each with the reason it's accepted.
// Keys are the coverage check's issue keys (see CoverageCheck.swift):
//   "missing METHOD /path", "duplicate METHOD /path", "name METHOD /path",
//   "return METHOD /path", "param ParentStem.field"
// Generation fails on any deviation not listed here, and on any entry here that no
// longer matches a deviation.

let coverageExceptions: [String: String] = [:]
