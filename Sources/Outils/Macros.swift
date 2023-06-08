// Outils
// Macros.swift
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

/// A macro that produces a `URL` from a static string literatal
///
/// For example
///
/// ```swift
/// #URL("https://www.apple.com")
/// ```
///
/// produces the following URL
///
/// ```swift
/// URL(string: "https://www.apple.com")!
/// ```
///
/// The macro gaurantess at compile time that the forced unwrap will never fail.
@freestanding(expression)
public macro URL(_ value: StaticString) -> URL = #externalMacro(module: "OutilsMacros", type: "URLMacro")

/// A macro that produces a linkable `URL` from a static string literatal
///
/// For example
///
/// ```swift
/// #link("https://www.apple.com")
/// ```
///
/// produces the following URL
///
/// ```swift
/// URL(string: "https://www.apple.com")!
/// ```
///
/// The macro gaurantess at compile time that the forced unwrap will never fail. A malformed URL will also trigger a compile time error.
@freestanding(expression)
public macro link(_ value: StaticString) -> URL = #externalMacro(module: "OutilsMacros", type: "LinkMacro")

/// A macro that produces a mail to`URL` from a static string literatal email
///
/// For example
///
/// ```swift
/// #link("talkto@vsanthanam.com")
/// ```
///
/// produces the following URL
///
/// ```swift
/// URL(string: "mailto:talkto@vsanthanam.com")!
/// ```
///
/// The macro gaurantess at compile time that the forced unwrap will never fail. A malformed email address will also trigger a compile time error.
@freestanding(expression)
public macro mailTo(_ value: StaticString) -> URL = #externalMacro(module: "OutilsMacros", type: "MailToMacro")

/// A macro that creates a `Date` from a `String`
///
/// ```
/// let date = #date("08-22-1995")
/// ```
///
/// If a valid `Date` object cannot be parsed from the string, a compile time error will occur
/// You can use any format you supported by Apple's data detector API.
@freestanding(expression)
public macro date(_ value: StaticString) -> Date = #externalMacro(module: "OutilsMacros", type: "DateMacro")
