// Outils
// ErrorMessage.swift
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

/// A reusable swift error struct
///
/// ## Topics
///
/// ### Initializers
/// - ``init(_:file:function:line:column:)``
///
/// ### API
/// - ``message``
/// - ``callSite-swift.property``
///
/// ### String Conversion
/// - ``description``
/// - ``debugDescription``
public struct ErrorMessage: Error, Equatable, Hashable, Codable, CustomStringConvertible, CustomDebugStringConvertible, Sendable {

    // MARK: - Initializers

    /// Create an `ErrorMessage`
    /// - Parameters:
    ///   - message: The error message
    ///   - file: File containing the callsite where the error occured
    ///   - function: Function containing the callsite where the error occured
    ///   - line: Line number of the callsite where the error occured
    ///   - column: Column number of the callsite where the error occured
    public init(_ message: String = "An error occured",
                file: StaticString = #fileID,
                function: StaticString = #function,
                line: UInt = #line,
                column: UInt = #column) {
        let callSite = CallSite(file.description, function.description, line, column)
        self.init(message: message, callSite: callSite)
    }

    // MARK: - API

    /// A struct describing a call site
    public struct CallSite: Equatable, Hashable, Sendable, Codable, CustomStringConvertible {

        /// The file containing the call site
        let file: String

        /// The function containing the call site
        let function: String

        /// The line number of the call site
        let line: UInt

        /// The column number of the call site
        let column: UInt

        // MARK: - CustomStringConvertible

        public var description: String {
            [file, function, line.description, column.description].joined(separator: ":")
        }

        init(_ file: String, _ function: String, _ line: UInt, _ column: UInt) {
            self.file = file
            self.function = function
            self.line = line
            self.column = column
        }
    }

    /// The error message
    public let message: String

    /// The call site where the error occured
    public let callSite: CallSite

    // MARK: - CustomStringConvertible

    /// A textual representation of this instance.
    ///
    public var description: String {
        message
    }

    public var debugDescription: String {
        [callSite.description, message].joined(separator: ":")
    }

    // MARK: - Private

    private init(
        message: String,
        callSite: CallSite
    ) {
        self.message = message
        self.callSite = callSite
    }
}

public extension String.StringInterpolation {

    mutating func appendInterpolation(message error: ErrorMessage) {
        appendInterpolation(error.message)
    }

    mutating func appendInterpolation(callSite error: ErrorMessage) {
        appendInterpolation(error.callSite.description)
    }

    mutating func appendInterpolation(file error: ErrorMessage) {
        appendInterpolation(error.callSite.file)
    }

    mutating func appendInterpolation(function error: ErrorMessage) {
        appendInterpolation(error.callSite.function)
    }

    mutating func appendInterpolation(line error: ErrorMessage) {
        appendInterpolation(error.callSite.line.description)
    }

    mutating func appendInterpolation(column error: ErrorMessage) {
        appendInterpolation(error.callSite.column.description)
    }
}
