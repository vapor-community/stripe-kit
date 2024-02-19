//
//  Dictionary+QueryEncoding.swift
//  
//
//  Created by Andrew Edwards on 4/11/20.
//

import Foundation

extension Dictionary where Key == String {
    var queryParameters: String {
        // A quick implementation of URLEncodedFormSerializer that includes indices in array key-paths
        // -> `items[0][plan]=...` instead of `items[][plan]=...`
        return Dictionary.queryComponents(keyPath: [], self).map { keyPath, value in
            "\(keyPath.queryKeyPercentEncoded)=\(value.queryValuePercentEncoded)"
        }.joined(separator: "&")
    }
    
    private static func queryComponents(keyPath: [String], _ value: Any) -> [([String], String)] {
        if let dictionary = value as? [String: Any] {
            return dictionary.flatMap { key, value in
                queryComponents(keyPath: keyPath + [key], value)
            }
        } else if let array = value as? [Any] {
            return array.enumerated().flatMap { idx, value in
                queryComponents(keyPath: keyPath + ["\(idx)"], value)
            }
        } else {
            return [(keyPath, "\(value)")]
        }
    }
}

private extension CharacterSet {
    static var queryComponentAllowed: CharacterSet = {
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.remove("&")
        characterSet.remove("+")
        return characterSet
    }()
}

private extension Sequence where Element == String {
    var queryKeyPercentEncoded: String {
        return enumerated().map { idx, key in
            let encodedKey = key.queryValuePercentEncoded
            return idx == 0 ? encodedKey : "[\(encodedKey)]"
        }.joined()
    }
}

private extension String {
    var queryValuePercentEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .queryComponentAllowed) ?? ""
    }
}
