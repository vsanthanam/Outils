// Outils
// Casting.swift
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

/// Case the provided value into the provided type, or throw an error
///
/// You can supply the desired type as an argument, or have the compiler infer it from the call site
///
/// ```swift
/// let val: SomeType = ...
/// let explicit = try cast(val, to: SomeOtherType.self) // Explicitly dictate the type
/// let implicit: SomeOtherType = try cast(val) // Infer the type from the call site
/// ```
///
/// - Parameters:
///   - value: The value to cast
///   - type: The desired type
///   - message: The error message to use if the cast fails
///   - file: The file containing the call site
///   - function: The function containing the call site
///   - line: The line number of the call site
///   - column: The column number of the call site
/// - Throws: An ``ErrorMessage``, if the cast fails
/// - Returns: An instance of `T`, casted from `value`
public func cast<T>(
    _ value: Any,
    to type: T.Type = T.self,
    message: @autoclosure () -> String? = nil,
    file: StaticString = #fileID,
    function: StaticString = #function,
    line: UInt = #line,
    column: UInt = #column
) throws -> T {
    guard let value = value as? T else {
        throw ErrorMessage(
            message() ?? "Could not cast value \(value) to type \(T.self)",
            file: file,
            function: function,
            line: line,
            column: column
        )
    }
    return value
}

/// Cast the provided value into the provided type, or assert if the cast fails
///
/// - Parameters:
///   - value: The value to cast
///   - type: The desired type
///   - message: The error message to use if the cast fails
///   - file: The file containing the call site
///   - function: The function containing the call site
///   - line: The line number of the call site
///   - column: The column number of the call site
/// - Returns: An instance of `T`, casted from `value`, or `nil` if the cast failed.
/// - Important: Failed casts will result in an `assertionFailure`, which will be a no-op for production users, but will halt execution of the program in debug builds.
public func castOrAssert<T>(
    _ value: Any,
    to type: T.Type = T.self,
    message: @autoclosure () -> String? = nil,
    file: StaticString = #fileID,
    function: StaticString = #function,
    line: UInt = #line,
    column: UInt = #column
) -> T? {
    guard let value = value as? T else {
        assertionFailure(message() ?? "Could not cast value \(value) to type \(T.self)", file: file, line: line)
        return nil
    }
    return value
}
