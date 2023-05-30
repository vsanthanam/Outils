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
public struct ErrorMessage: Error, Equatable, Hashable, CustomStringConvertible, Sendable {

    // MARK: - Initializers

    /// Create an `ErrorMessage`
    /// - Parameters:
    ///   - message: The error message
    ///   - file: File containing the callsite where the error occured
    ///   - function: Function containing the callsite where the error occured
    ///   - line: Line number of the callsite where the error occured
    ///   - column: Column number of the callsite where the error occured
    public init(_ message: String,
                file: StaticString = #file,
                function: StaticString = #function,
                line: UInt = #line,
                column: UInt = #column) {
        self.message = message
        self.file = file
        self.function = function
        self.line = line
        self.column = column
    }

    // MARK: - API

    /// The error message
    public let message: String

    /// File containing the callsite where the error occured
    public let file: StaticString

    /// Function containing the callsite where the error occured
    public let function: StaticString

    /// Line number of the callsite where the error occured
    public let line: UInt

    /// Column number of the callsite where the error occured
    public let column: UInt

    // MARK: - CustomStringConvertible

    public var description: String {
        [file.description,
         function.description,
         line.description,
         column.description,
         message]
            .joined(separator: ":")
    }

    // MARK: - Equatable

    public static func == (lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
        lhs.message == rhs.message && lhs.file.description == rhs.file.description && lhs.function.description == rhs.function.description && lhs.line == rhs.line && lhs.column == rhs.column
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(message)
        hasher.combine(file.description)
        hasher.combine(function.description)
        hasher.combine(line)
        hasher.combine(column)
    }
}
