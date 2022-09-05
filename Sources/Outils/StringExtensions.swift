// Outils
// StringExtensions.swift
//
// MIT License
//
// Copyright (c) 2021 Varun Santhanam
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
//
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED  AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public extension String {

    /// Decode a base64 encoded string
    /// - Parameter base64: The base64 encoded string
    /// - Returns: The decoded string
    static func decode(_ base64: String) throws -> String {
        guard let data = Data(base64Encoded: base64),
              let decoded = String(data: data, encoding: .utf8) else {
            throw AnyError("Base 64 Decode Failed",
                           failureReason: "Decode method(s) returned nil")
        }
        return decoded
    }

    /// Encode a string with base64 encoding
    /// - Parameter string: The string
    /// - Returns: The encoded string
    static func encode(_ string: String) -> String {
        Data(string.utf8).base64EncodedString()
    }

    /// Localized string for key.
    static func localized(_ str: String) -> String {
        str.localized
    }

    /// Localized string for key.
    static func localized(_ str: String, _ arguments: CVarArg ...) -> String {
        String(format: str.localized, arguments: arguments)
    }

    /// Localized string for key.
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    /// Create the string in snake case
    var inSnakeCase: String {
        func processCamalCaseRegex(input: String, pattern: String) -> String? {
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: count)
            return regex?.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "$1_$2")
        }

        let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
        let normalPattern = "([a-z0-9])([A-Z])"

        if let temp = processCamalCaseRegex(input: self, pattern: acronymPattern) {
            return processCamalCaseRegex(input: temp, pattern: normalPattern)?.lowercased() ?? lowercased()
        }

        return lowercased()
    }

}

extension Optional {

    /// Localized string for key.
    static func localized(_ str: String) -> String where Wrapped == String {
        .localized(str)
    }

    /// Localized string for key.
    static func localized(_ str: String, _ arguments: CVarArg ...) -> String where Wrapped == String {
        .localized(str, arguments)
    }
}
