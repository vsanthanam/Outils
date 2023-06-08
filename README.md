# Outils

[![MIT License](https://img.shields.io/github/license/vsanthanam/Outils)](https://github.com/vsanthanam/Outils/blob/main/LICENSE)
[![Package Releases](https://img.shields.io/github/v/release/vsanthanam/Outils)](https://github.com/vsanthanam/Outils/releases)
[![Build Statis](https://img.shields.io/github/actions/workflow/status/vsanthanam/Outils/spm-build-test.yml)](https://github.com/vsanthanam/Outils/actions)
[![Swift Version](https://img.shields.io/badge/swift-5.8-critical)](https://swift.org)
[![Supported Platforms](https://img.shields.io/badge/platform-iOS%2012-lightgrey)](https://developer.apple.com)

Outils is a collection of Swift functions and library extensions that I find myself regularly re-creating in my projects. They contain free standing functions and types, as well as extensions on Swift standard library, Foundation, UIKit, and SwiftUI.

## Installation

To add Outils as a dependency to an existing Swift package, add the following line of code to the `dependencies` parameter of your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/vsanthanam/Outils.git", .upToNextMajor(from: "0.0.0"))
]
```

To add Outils as a dependency to an Xcode Project: 

- Choose `File` → `Add Packages...`
- Enter package URL `https://github.com/vsanthanam/Outils.git` and select your release and of choice.

Other distribution mechanisms like CocoaPods or Carthage may be added in the future.

## Usage & Documentation

Outils's documentation is built with [DocC](https://developer.apple.com/documentation/docc) and included in the repository as a DocC archive. The latest version is hosted on [GitHub Pages](https://pages.github.com) and is available [here](https://vsanthanam.github.io/Outils/docs/documentation/outils).

Additional installation instructions are available on the [Swift Package Index](https://swiftpackageindex.com/vsanthanam/Outils)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvsanthanam%2FOutils%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/vsanthanam/Outils)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvsanthanam%2FOutils%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/vsanthanam/Outils)

Explore [the documentation](https://vsanthanam.github.io/Outils/docs/documentation/outils) for more details.

## License

**Outils** is available under the MIT license. See the LICENSE file for more information.
