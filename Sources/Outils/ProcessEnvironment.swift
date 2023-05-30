// Outils
// ProcessEnvironment.swift
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

public enum ProcessEnvironment {

    public static let variables = Variables()

    public static var arguments: [String] {
        ProcessInfo.processInfo.arguments
    }

    public struct Variables {
        public subscript<T>(_ key: String) -> T where T: EnvironmentVariableRepresentable {
            value(forKey: key)
        }

        public subscript(_ key: String) -> String? {
            rawValue(forKey: key)
        }

        public func value<T>(forKey key: String, _ type: T.Type = T.self) -> T where T: EnvironmentVariableRepresentable {
            T(environmentVariable: rawValue(forKey: key))
        }

        public func rawValue(forKey key: String) -> String? {
            ProcessInfo.processInfo.environment[key]
        }

        public func containsValue(forKey key: String) -> Bool {
            rawValue(forKey: key) != nil
        }
    }
}

public protocol EnvironmentVariableRepresentable {
    init(environmentVariable: String?)
}

extension String?: EnvironmentVariableRepresentable {
    public init(environmentVariable: String?) {
        if let environmentVariable {
            self = .some(environmentVariable)
        } else {
            self = .none
        }
    }
}

extension Bool: EnvironmentVariableRepresentable {
    public init(environmentVariable: String?) {
        switch environmentVariable {
        case "0":
            self = false
        case "false":
            self = false
        case "NO":
            self = false
        case "1":
            self = true
        case "true":
            self = true
        case "YES":
            self = true
        default:
            self = false
        }
    }
}
