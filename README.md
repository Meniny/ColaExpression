<p align="center">
  <img src="./ColaExpression.png" alt="ColaExpression">
  <br/><a href="https://cocoapods.org/pods/ColaExpression">
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.1-brightgreen.svg">
  <img alt="Author" src="https://img.shields.io/badge/author-Meniny-blue.svg">
  <img alt="Build Passing" src="https://img.shields.io/badge/build-passing-brightgreen.svg">
  <img alt="Swift" src="https://img.shields.io/badge/swift-3.0%2B-orange.svg">
  <br/>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-lightgrey.svg">
  <img alt="MIT" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <br/>
  <img alt="Cocoapods" src="https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg">
  <img alt="Carthage" src="https://img.shields.io/badge/carthage-working%20on-red.svg">
  <img alt="SPM" src="https://img.shields.io/badge/swift%20package%20manager-working%20on-red.svg">
  </a>
</p>

***

## What's this?

`ColaExpression` is a Cross-Platform Regular Expression Library written in Swift.

## Requirements

* iOS 9.0+
* macOS 10.10+
* watchOS 3.0+
* tvOS 9.0+
* Xcode 8 with Swift 3

## Installation

#### CocoaPods

```ruby
pod 'ColaExpression'
```

## Contribution

You are welcome to fork and submit pull requests.

## License

`ColaExpression` is open-sourced software, licensed under the `MIT` license.

## Usage

#### `isMatch() -> Bool`

```swift
let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
let str = "admin@meniny.cn"
```

```swift
let cola = ColaExpression(pattern)
if cola.isMatch(with: str) {
  print("\(str) is a valid email")
  // admin@meniny.cn is a valid email
}
```

```swift
if str.isMatch(pattern: pattern) {
  print("\(str) is a valid email")
  // admin@meniny.cn is a valid email
}
```

#### `matches() -> [String]`

```swift
let pattern = "[a-z]{3}"
let str = "AAAbbbCCCdddEEEfff"
```

```swift
let cola = ColaExpression(pattern)
let matches = cola.matches(of: str)
// ["bbb", "ddd", "fff"]
```

```swift
let matches = str.matches(pattern: pattern)
// ["bbb", "ddd", "fff"]
```

#### `replaceOccurences() -> String`

```swift
let pattern = "[a-z]"
let str = "AAAbbbCCCdddEEEfff"
let replacement = "-"
```

```swift
let cola = ColaExpression(pattern)
let replaced = cola.replaceOccurences(in: str, with: replacement)
// AAA---CCC---EEE---
```

```swift
let replaced = str.replaceOccurences(matches: pattern, with: replacement)
// AAA---CCC---EEE---
```
