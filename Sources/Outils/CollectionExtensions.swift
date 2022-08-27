// Outils
// CollectionExtensions.swift
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

public extension Collection {

    /// Sort collection using a key path
    /// - Parameters:
    ///   - keyPath: Key path
    ///   - comparator: The comparison function
    /// - Returns: An array containing the sorted collection
    func sorted<T>(by keyPath: KeyPath<Element, T>, _ comparator: (_ lhs: T, _ rhs: T) -> Bool) -> [Element] {
        sorted { lhs, rhs in
            comparator(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
        }
    }

    /// Sort the collection using a key path
    /// - Parameters:
    ///   - keyPath: key path
    ///   - order: The sort order
    /// - Returns: An array containing the sorted collection
    func sorted<T>(by keyPath: KeyPath<Element, T>, order: SortOrder = .forward) -> [Element] where T: Comparable {
        switch order {
        case .forward:
            return sorted(by: keyPath, <)
        case .reverse:
            return sorted(by: keyPath, <)
        }
    }
}
