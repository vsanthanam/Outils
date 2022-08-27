// Outils
// OptionalType.swift
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

import Combine
import Foundation

/// A protocol that all optional types conform to
public protocol OptionalType {

    /// The underlying non-optional type
    associatedtype Wrapped

    /// Get the value as an `Optional<Wrapped>`
    var asOptional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var asOptional: Wrapped? { self }
}

public extension Publisher where Output: OptionalType {

    /// Remove `nil` values from the sequence
    /// - Returns: The sequence
    func filterNil() -> Publishers.CompactMap<Self, Output.Wrapped> {
        compactMap { input in
            input.asOptional
        }
    }
}

public extension Publisher {

    /// Wrap the sequence in optional types
    /// - Returns: The sequence
    func toOptional() -> Publishers.Map<Self, Output?> {
        map { $0 }
    }
}

public extension Collection where Element: OptionalType {

    /// Remove `nil` values from the collection
    /// - Returns: The filtered collection
    func filterNil() -> [Element.Wrapped] {
        compactMap(\.asOptional)
    }
}
