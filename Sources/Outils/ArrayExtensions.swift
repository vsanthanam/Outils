// Outils
// ArrayExtensions.swift
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

public extension Array {

    /// Sort the arrary using a keypath
    /// - Parameters:
    ///   - keyPath: The keypath used to sort the array
    ///   - comparator: The comparison function
    mutating func sort<T>(by keyPath: KeyPath<Element, T>, _ comparator: (_ lhs: T, _ rhs: T) -> Bool) {
        self = sorted(by: keyPath, comparator)
    }

    /// - Parameters:
    ///   - keyPath: The keypath
    ///   - order: The sorting order
    mutating func sort<T>(by keyPath: KeyPath<Element, T>, order: SortOrder = .forward) where T: Comparable {
        self = sorted(by: keyPath, order: order)
    }

    /// Safely retrieve an element the array using its indexs
    subscript(safe index: Index) -> Element? {
        guard index < count else { return nil }
        return self[index]
    }
}
