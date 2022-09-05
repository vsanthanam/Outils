// Outils
// EnvironmentValuesExtensions.swift
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
import SwiftUI

private struct SwiftUIPreviewsEnvironmentKey: EnvironmentKey {

    // MARK: - EnvironmentKey

    typealias Value = Bool

    static var defaultValue: Value {
        #if DEBUG
            EnvironmentVariables["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
            false
        #endif
    }
}

private struct UITestEnvironmentKey: EnvironmentKey {

    // MARK: - EnvironmentKey

    typealias Value = Bool

    static let defaultValue: Bool = ProcessInfo.processInfo.arguments.contains("-ui_testing")

}

public extension EnvironmentValues {

    /// Whether or not the view is running within SwiftUI previews.
    var isPreview: Bool {
        get {
            self[SwiftUIPreviewsEnvironmentKey.self]
        }
        set {
            self[SwiftUIPreviewsEnvironmentKey.self] = newValue
        }
    }

    /// Whether or not the view is running within then the UITest environment.
    var isUITest: Bool {
        get {
            self[UITestEnvironmentKey.self]
        }
        set {
            self[UITestEnvironmentKey.self] = newValue
        }
    }
}
