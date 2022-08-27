// Outils
// EnvironmentVariables.swift
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

/// An API to access environment variables via subscripting.
///
/// ```
/// if EnvironmentVariables["VARIABLE_NAME"] == true {
///    // Do something.
/// }
/// ```
///
/// ## Creating Variables
///
/// The Environment API uses a generic enum. You can create a namespace for your environment variables by declaring a new type.
/// You can use any type to satisfy generic, as long as it conforms to `EnvironmentVariable`
///
/// To reduce boilerplate, conformance `EnvironentVariable` is automatic for `String`
/// It's also automatic for types that conform to `RawRepresentable`, where `RawValue == String`
///
/// This is particularly convenient for enums:
///
/// ```
/// enum MyVariables: String, EnvironmentVarialble {
///     case API_KEY
///     case USE_DEVELOPED_MODE
///     case RETRY_AMOUNT
/// }
/// ```
///
/// Then, you can aceess your keys like this:
///
/// ```
/// if BaseEnvironmentVariables<MyVariables>[.USE_DEVELOPER_MODE] == true {
///    // do developer mode stuff
/// }
///
/// let apiKey: String? = BaseEnvironmentVariables<MyVariables>[.API_KEY]?.stringValue
/// ```
///
/// I'd recommend defining a `typealias` for every type you declare that conforms to `EnvironmentVariable`:
///
/// ```
/// typealias MyEnvironment = BaseEnvironmentVariables<MyVariable>
///
/// let useDeveloperMode: Bool? = MyEnvironment[.USE_DEVELOPER_MODE]?.boolValue
/// let apiKey: String? = MyEnvironment[.API_KEY]?.stringValue
/// let retryAmount: Int? = MyEnvironment[.RETRY_AMOUNT]?.intValue
/// ```
///
/// ## Using Strings
///
/// Because `String` already conforms to `EnvironmentVariable`, you also don't to bother with declaring types at all.
/// Instead, you can just use `String` for all your environment variables.
/// You'll lose type safety though on the variable itself though.
///
/// ```
/// let value: String? = BaseEnvironmentVariables<String>["MY_SETTING"]?.stringValue
/// ```
///
/// As a convenience `Environment` is already defined as a type alias of `BaseEnvironmentVariables<String>`
/// As such, the above example could also be written like this:
///
/// ```
/// let value: String? = EnvironmentVariables["MY_SETTING"]?.stringValue
/// ```
///
/// ## Comparisons and Literals
///
/// To make comparisons easier, All values produced from `BaseEnvironmentVariables` are expressible by a number of literal types.
/// They also all conform to `Equatable` and `Comparable`:
///
/// ```
/// if EnvironmentVariables["NUM_RETRIES"] < 5 {
///    // do something
/// } else if EnvironmentVariables["DEVELOPER_MODE"] == true {
///    // do something else
/// }
///
/// ```
public enum BaseEnvironmentVariables<T> where T: EnvironmentVariable {

    /// Retrive `Value`in the `BaseEnvironment` using a subscript
    public static subscript(_ variable: T) -> Value? {
        mappedEnvironment[variable.computedKey]
    }

    /// A type used to describe a value bound to an environment variable
    public struct Value: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByBooleanLiteral, ExpressibleByFloatLiteral, Equatable, Comparable, Hashable, CustomStringConvertible {

        // MARK: - API

        /// The value, expressed as a `String`
        public var stringValue: String {
            ambiguousValue
        }

        /// The value, expressed as an `Int`
        public var intValue: Int {
            Int(ambiguousValue) ?? 0
        }

        /// The value, expressed as an `Double`
        public var floatValue: Double {
            Double(ambiguousValue) ?? 0.0
        }

        /// The value, expressed as a `Bool`
        public var boolValue: Bool {
            switch ambiguousValue {
            case "YES":
                return true
            default:
                return false
            }
        }

        // MARK: - ExpressibleByStringLiteral

        public init(stringLiteral value: String) {
            self.init(ambiguousValue: value)
        }

        // MARK: - ExpressibleByIntegerLiteral

        public init(integerLiteral value: Int) {
            self.init(ambiguousValue: String(value))
        }

        // MARK: - ExpressibleByBooleanLiteral

        public init(booleanLiteral value: Bool) {
            if value {
                self.init(ambiguousValue: "YES")
            } else {
                self.init(ambiguousValue: "NO")
            }
        }

        // MARK: - ExpressibleByFloatLiteral

        public init(floatLiteral value: Double) {
            self.init(ambiguousValue: String(value))
        }

        // MARK: - Hashable

        public func hash(into hasher: inout Hasher) {
            hasher.combine(ambiguousValue)
        }

        // MARK: - Equatable

        public static func == (lhs: Value, rhs: Value) -> Bool {
            lhs.ambiguousValue == rhs.ambiguousValue
        }

        // MARK: - Comparable

        public static func < (lhs: Value, rhs: Value) -> Bool {
            lhs.intValue < rhs.intValue
        }

        // MARK: - CustomStringConvertible

        public var description: String { ambiguousValue }

        // MARK: - Private

        fileprivate init(ambiguousValue: String) {
            self.ambiguousValue = ambiguousValue
        }

        private let ambiguousValue: String
    }

    private static var mappedEnvironment: [String: Value] {
        ProcessInfo.processInfo.mappedEnvironment()
    }
}

/// Environment API for `String` Environment Variables
public typealias EnvironmentVariables = BaseEnvironmentVariables<String>

/// A protocol describing an environment variable
public protocol EnvironmentVariable {
    static var namespace: String? { get }
    var key: String { get }
}

public extension EnvironmentVariable {
    static var namespace: String? { nil }
    fileprivate var computedKey: String {
        guard let namespace = Self.namespace else {
            return key
        }
        return namespace + "_" + key
    }
}

extension String: EnvironmentVariable {
    public var key: String { self }
}

public extension EnvironmentVariable where Self: RawRepresentable, RawValue == String {
    var key: String { rawValue }
}

private extension ProcessInfo {
    func mappedEnvironment<T>() -> [String: BaseEnvironmentVariables<T>.Value] {
        ProcessInfo.processInfo.environment.mapValues { value in
            BaseEnvironmentVariables<T>.Value(ambiguousValue: value)
        }
    }
}
