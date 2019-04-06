//
//  ColaExpression.swift
//  ColaExpression
//
//  Created by Meniny on 3/9/17.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

// MARK - ColaExpression

public struct ColaExpression {
    
    /// Regular expression pattern that will be used to evaluate a specific string.
    public let pattern: Pattern

    /// `fatalError` occurs when using this empty initializer as ColaExpression must be initialized using `init(_ pattern:)` or `init(pattern:)`.
    public init() {
        fatalError("ColaExpression must be initialized using `init(_ pattern:)` or `init(pattern:)`.")
//        self.pattern = "."
    }

    /// Designated Initializer for `ColaExpression`
    ///
    /// - Parameters:
    ///     - pattern: The pattern that will be used to perform the match.
    public init(_ pattern: Pattern) {
        self.pattern = pattern
    }
    
    /// Designated Initializer for `ColaExpression`
    ///
    /// - Parameters:
    ///     - pattern: The pattern that will be used to perform the match.
    public init(pattern: Pattern) {
        self.pattern = pattern
    }
    
//    public private(set) var expression: NSRegularExpression?
}

// MARK: - Match

public extension ColaExpression {

    /// Evaluates a string for all instances of a regular expression pattern and returns a new string of matches repleaced.
    ///
    /// - Parameters:
    ///   - string: The string that will be evaluated.
    ///   - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    ///   - range: Range. Defaults to `nil`.
    ///   - templ: Template. Defaults to an empty string(`""`).
    /// - Returns: A new string with all matches repleaced.
    func stringByReplacingMatches(in string: String,
                                         options: ColaOptions = [],
                                         matchingOptions: ColaMatchingOptions = [],
                                         range: NSRange? = nil,
                                         withTemplate templ: String = "") -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return string
        }
        
        return regex.stringByReplacingMatches(in: string,
                                              options: matchingOptions,
                                              range: range ?? NSMakeRange(0, string.count),
                                              withTemplate: templ)
    }
    
    /// Evaluates a string for all instances of a regular expression pattern and returns a list of matched ranges for that string.
    ///
    /// - Parameters:
    ///     - string: The string that will be evaluated.
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    ///
    /// - Returns: A list of matches.
    func matchedRanges(of string: String, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> [Range<String.Index>] {
        let range = NSRange(location: 0, length: string.count)
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return []
        }

        let matches = regex.matches(in: string, options: matchingOptions, range: range)

        let ranges = matches.compactMap { (match) -> Range<String.Index>? in
            let nsRange = match.range
            return nsRange.range(of: string)
        }

        return ranges
    }

    /// Evaluates a string for all instances of a regular expression pattern and returns a list of matched strings for that string.
    ///
    /// - Parameters:
    ///     - string: The string that will be evaluated.
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    ///
    /// - Returns: A list of matches.
    func matches(of string: String, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> [String] {
        let ranges = matchedRanges(of: string, options: options, matchingOptions: matchingOptions)

        var strings: [String] = []
        for range in ranges {
            strings.append(String(string[range]))
        }

        return strings
    }
    
    /// Evaluates a string for all instances of a regular expression pattern and returns the first of value of the list of matched strings for that string.
    ///
    /// - Parameters:
    ///     - string: The string that will be evaluated.
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    ///
    /// - Returns: The first value of the list of matches.
    func firstMatch(of string: String, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> String? {
        return matches(of: string, options: options, matchingOptions: matchingOptions).first
    }

    /// Tests a string to see if it matches the regular expression pattern.
    ///
    /// - Parameters:
    ///     - string: The string that will be evaluated.
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    /// 
    /// - Returns: `true` if string passes the test, otherwise, `false`.
    func isMatch(with string: String, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> Bool {
        return !matchedRanges(of: string, options: options, matchingOptions: matchingOptions).isEmpty
    }

    /// Replace specific ranges in a string with a specific character.
    ///
    /// - Parameters:
    ///   - string: The string that will be manipulated.
    ///   - character: The character that is injected in certain ranges within the original string.
    /// - Returns: A new string based on the old string, but with specific ranges containing a different character.
    func replaceOccurences(in string: String, with character: String) -> String {
        let ranges = ColaExpression(pattern).matchedRanges(of: string)
        
        var newString = string
        for range in ranges {
            newString.replaceSubrange(range, with: character)
        }
        
        return newString
    }
    
    /// Returns an array containing the first letter of each word in the test string.
    ///
    /// - Parameter string: The string to evaluate.
    /// - Returns: An array containing the first letter of each word in the provided string.
    static func firstCharacterOfEachWord(in string: String) -> [String] {
        return ColaExpression.firstCharacterPattern.matches(of: string)
    }
    
    /// Returns an array containing the last letter of each word in the test string.
    ///
    /// - Parameter string: The string to evaluate.
    /// - Returns: An array containing the last letter of each word in the provided string.
    static func lastCharacterOfEachWord(in string: String) -> [String] {
        return ColaExpression.lastCharacterPattern.matches(of: string)
    }
    
    /// Tests a string to check if it is a valid email address by using a regular expression.
    ///
    /// - Parameters:
    ///     - email: The string that needs to be evaluated.
    ///
    /// - Returns: `true` if `string` is a valid email address, otherwise `false`.
    static func check(email: String) -> Bool {
        return ColaExpression.emailPattern.isMatch(with: email)
    }
    
    /// Sanitizes of a string by removing all non-Alphanumeric characters (excluding whitespaces)
    ///
    /// - Parameter string: The string that should be sanitized.
    /// - Returns: The sanitized string.
    static func sanitze(string: String) -> String {
        return ColaExpression.nonAlphanumericPattern.replaceOccurences(in: string, with: " ").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
