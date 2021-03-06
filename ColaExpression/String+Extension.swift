//
//  String+Extension.swift
//  ColaExpression
//
//  Created by Meniny on 3/9/17.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

// MARK: - Boolean Operations

public extension String {
    
    /// A Boolean value indicating if this string matches the given pattern.
    ///
    /// - Parameter pattern: ColaExpression pattern
    /// - Returns: `true`, if matches. Otherwise, `false`.
    func isMatch(pattern: Pattern, options: ColaOptions = []) -> Bool {
        return ColaExpression(pattern).isMatch(with: self, options: options)
    }
    
    /// A Boolean value indicating if all the characters are letters.
    ///
    /// - Returns: `true`, if all characters are letters. Otherwise, `false`.
    func isAlpha() -> Bool {
        return contains(characters: .letters)
    }
    
    /// A Boolean value indicating if all the characters are alphanumeric.
    ///
    /// - Returns: `true`, if all characters are alphanumeric. Otherwise, `false`.
    func isAlphanumeric() -> Bool {
        return contains(characters: .alphanumerics)
    }
    
    /// A Boolean value indicating if the first characters in all of the words in the string are uppercased.
    ///
    /// - Returns: `true`, if the string is capitalized. Otherwise, `false`.
    func isCapitalized() -> Bool {
        return self == capitalized()
    }
    
    /// A Boolean value indicating if the first characters in all of the words in the string are lowercased.
    ///
    /// - Returns: `true`, if first character is lowercased. Otherwise, `false`.
    func isDecapitalized() -> Bool {
        return self == decapitalized()
    }
    
    /// A Boolean value indicating if all the characters are lowercased.
    ///
    /// - Returns: `true`, if the string is not capitalized. Otherwise, `false`.
    func isLowercased() -> Bool {
        return self == lowercased()
    }
    
    /// A Boolean value indicating if all the characters are numbers.
    ///
    /// - Returns: `true`, if all characters are numbers. Otherwise, `false`.
    func isNumeric() -> Bool {
        return contains(characters: .decimalDigits)
    }
    
    /// A Boolean value indicating if all the characters are uppercased.
    ///
    /// - Returns: `true`, if all characters are uppercased. Otherwise, `false`.
    func isUppercased() -> Bool {
        return self == uppercased()
    }
    
}

// MARK: - Contains

public extension String {
    
    /// A Boolean value indicating if all the characters in the string belong to a specific `CharacterSet`.
    ///
    /// - Parameter characterSet: The `CharacterSet` used to test the string.
    /// - Returns: True, if all the characters in the string belong to the `CharacterSet`. Otherwise, false.
    func contains(characters characterSet: CharacterSet) -> Bool {
        for scalar in unicodeScalars {
            guard characterSet.contains(scalar) else {
                return false
            }
        }
        return true
    }
    
    /// Evaluates this string for all instances of a regular expression pattern and returns a list of matched strings for that string.
    ///
    /// - Parameters:
    ///     - pattern: A regular expression pattern
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    ///
    /// - Returns: A list of matches.
    func matches(pattern: Pattern, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> [String] {
        return ColaExpression(pattern).matches(of: self, options: options, matchingOptions: matchingOptions)
    }
    
    /// Evaluates a string for all instances of a regular expression pattern and returns the first of value of the list of matched strings for that string.
    ///
    /// - Parameters:
    ///     - string: The string that will be evaluated.
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///     - matchingOptions: Matching options. Defaults to [].
    ///
    /// - Returns: The first value of the list of matches.
    func firstMatch(pattern: Pattern, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> String? {
        return matches(pattern: pattern, options: options, matchingOptions: matchingOptions).first
    }
    
    /// Evaluates this string for all instances of a regular expression pattern and returns a list of matched ranges for that string.
    ///
    /// - Parameters:
    ///     - pattern: A regular expression pattern
    ///     - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///     - matchingOptions: Matching options. Defaults to [].
    ///
    /// - Returns: A list of matches.
    func matchedRanges(with pattern: Pattern, options: ColaOptions = [], matchingOptions: ColaMatchingOptions = []) -> [Range<String.Index>] {
        return ColaExpression(pattern).matchedRanges(of: self, options: options, matchingOptions: matchingOptions)
    }
    
    /// Evaluates this string for all instances of a regular expression pattern and returns a new string of all matches repleaced.
    ///
    /// - Parameters:
    ///   - pattern: A regular expression pattern
    ///   - options: Regular expression options that are applied to the string during matching. Defaults to [].
    ///   - matchingOptions: Matching options. Defaults to [].
    ///   - range: Range. Defaults to `nil`.
    ///   - templ: Template. Defaults to an empty string(`""`).
    /// - Returns: A new string with all matches repleaced.
    func stringByReplacingMatches(with pattern: Pattern,
                                         options: ColaOptions = [],
                                         matchingOptions: ColaMatchingOptions = [],
                                         range: NSRange? = nil,
                                         withTemplate templ: String = "") -> String {
        return ColaExpression(pattern).stringByReplacingMatches(in: self,
                                                                options: options,
                                                                matchingOptions: matchingOptions,
                                                                range: range,
                                                                withTemplate: templ)
    }
}

// MARK: - Case Operations

public extension String {
    
    /// Returns a camel cased version of the string.
    ///
    ///     let string = "HelloWorld"
    ///     print(string.camelCased())
    ///     // Prints "helloWorld"
    ///
    /// - Returns: A camel cased copy of the string.
    @discardableResult
    func camelCased() -> String {
        return pascalCased().decapitalized()
    }
    
    /// Returns a capitalized version of the string.
    ///
    /// - Warning: This method is a modified implementation of Swift stdlib's `capitalized` computer variabled.
    ///
    ///     let string = "hello World"
    ///     print(string.capitalized())
    ///     // Prints "Hello World"
    ///
    /// - Returns: A capitalized copy of the string.
    @discardableResult
    func capitalized() -> String {
        let ranges = ColaExpression.firstCharacterPattern.matchedRanges(of: self)
        
        var newString = self
        for range in ranges {
            let character = index(range.lowerBound, offsetBy: 0)
            let uppercasedCharacter = String(self[character]).uppercased()
            newString = newString.replacingCharacters(in: range, with: uppercasedCharacter)
        }
        
        return newString
    }
    
    /// Returns a decapitalized version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.decapitalized())
    ///     // Prints "hello world"
    ///
    /// - Returns: A decapitalized copy of the string.
    @discardableResult
    func decapitalized() -> String {
        let ranges = ColaExpression.firstCharacterPattern.matchedRanges(of: self)
        
        var newString = self
        for range in ranges {
            let character = self[range.lowerBound]
            let lowercasedCharacter = String(character).lowercased()
            newString = newString.replacingCharacters(in: range, with: lowercasedCharacter)
        }
        
        return newString
    }
    
    /// Returns the kebab cased (a.k.a. slug) version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.kebabCased())
    ///     // Prints "hello-world"
    ///
    /// - Returns: The kebabg cased copy of the string.
    @discardableResult
    func kebabCased() -> String {
        return ColaExpression.sanitze(string: self).splitWordsByCase().replacingOccurrences(of: " ", with: "-").lowercased()
    }
    
    /// Returns a pascal cased version of the string.
    ///
    ///     let string = "HELLO WORLD"
    ///     print(string.pascalCased())
    ///     // Prints "HelloWorld"
    ///
    /// - Returns: A pascal cased copy of the string.
    @discardableResult
    func pascalCased() -> String {
        return ColaExpression.sanitze(string: self).splitWordsByCase().capitalized().components(separatedBy: .whitespaces).joined()
    }
    
    /// Returns the snake cased version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.snakeCased())
    ///     // Prints "hello_world"
    ///
    /// - Returns: The snaked cased copy of the string.
    @discardableResult
    func snakeCased() -> String {
        return ColaExpression.sanitze(string: self).splitWordsByCase().replacingOccurrences(of: " ", with: "_").lowercased()
    }
    
    /// Splits a string into mutliple words, delimited by uppercase letters.
    ///
    ///     let string = "HelloWorld"
    ///     print(string.splitWordsByCase())
    ///     // Prints "Hello World"
    ///
    /// - Returns: A new string where each word in the original string is delimited by a whitespace.
    @discardableResult
    func splitWordsByCase() -> String {
        var newStringArray: [String] = []
        for character in ColaExpression.sanitze(string: self) {
            if String(character) == String(character).uppercased() {
                newStringArray.append(" ")
            }
            newStringArray.append(String(character))
        }
        
        return newStringArray
            .joined()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespaces)
            .filter({ !$0.isEmpty })
            .joined(separator: " ")
    }
    
    /// Returns the swap cased version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.swapCased())
    ///     // Prints "hELLO wORLD"
    ///
    /// - Returns: The swap cased copy of the string.
    @discardableResult
    func swapCased() -> String {
        return map({
            String($0).isLowercased() ? String($0).uppercased() : String($0).lowercased()
        }).joined()
    }
    
}

// MARK: - Character Operations

public extension String {

    /// Returns the first character of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.firstCharacter())
    ///     // Prints "H"
    ///
    /// - Returns: The first character of the string.
    @discardableResult
    func firstCharacter() -> String {
        return String(describing: self[startIndex])
    }

    /// Returns the last character of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.lastCharacter())
    ///     // Prints "d"
    ///
    /// - Returns: The last character of the string.
    @discardableResult
    func lastCharacter() -> String {
        guard let c = reversed().last else {
            return ""
        }
        return String(c)
    }

    /// Returns the latinized version of the string without diacritics.
    ///
    ///     let string = "Hello! こんにちは! สวัสดี! مرحبا! 您好!"
    ///     print(string.latinized())
    ///     // Prints "Hello! kon'nichiha! swasdi! mrhba! nin hao!"
    ///
    /// - Returns: The latinized version of the string without diacritics.
    @discardableResult
    func latinized() -> String {
        #if !os(Linux)
            if #available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 3.0, *) {
                return (applyingTransform(.toLatin, reverse: false) ?? self).withoutAccents()
            } else {
                assertionFailure("The latinized function is only available iOS 9.0+, macOS 10.11+, tvOS 9.0+, and watchOS 3.0+")
                return self.withoutAccents()
            }
        #else
            assertionFailure("The latinized function is only available for Darwin devices; iOS, macOS, tvOS, watchOS")
            return self.withoutAccents()
        #endif
    }

    /// Returns the character count of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.length())
    ///     // Prints 11
    ///
    /// - Returns: The character count of the string.
    func length() -> Int {
        return count
    }

    /// Retuns the reversed version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(string.reversed)
    ///     // Prints "dlroW olleH"
    ///
    /// - Returns: The reversed copy of the string.
    var reversed: String {
        return String(reversed())
    }

    /// Returns the string without diacritics.
    ///
    ///     let string = "Crème brûlée"
    ///     print(string.withoutAccents())
    ///     // Prints "Creme brulee"
    ///
    /// - Returns: The string without diacritics.
    @discardableResult
    func withoutAccents() -> String {
        #if !os(Linux)
            if #available(iOS 9.0, macOS 10.11, tvOS 9.0, watchOS 2.0, *) {
                return (applyingTransform(.stripCombiningMarks, reverse: false) ?? self)
            } else {
                assertionFailure("The withoutAccents function is only available iOS 9.0+, macOS 10.11+, tvOS 9.0+, and watchOS 2.0+")
                return self
            }
        #else
            return folding(options: .diacriticInsensitive, locale: .current)
        #endif
    }
    
    /// Replace specific ranges in this string with a specific character using a given regular expression pattern.
    ///
    /// - Parameters:
    ///   - string: The string that will be manipulated.
    ///   - character: The character that is injected in certain ranges within the original string.
    /// - Returns: A new string based on the old string, but with specific ranges containing a different character.
    func replaceOccurences(matches pattern: Pattern, with character: String) -> String {
        return ColaExpression(pattern).replaceOccurences(in: self, with: character)
    }
    
}

// MARK: - Padding Operations

public extension String {
    
    /// Returns the center-padded version of the string.
    ///
    /// Example 1:
    ///
    ///     let string = "Hello World"
    ///     print(string.padding(length: 13))
    ///     // Prints " Hello World "
    ///
    /// Example 2:
    ///
    ///     let string = "Hello World"
    ///     print(string.padding(length: 13, withToken: "*"))
    ///     // Prints "*Hello World*"
    ///
    /// - Parameters:
    ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned. If the the sum-total of characters added is odd, the left side of the string will have one less instance of the token.
    ///   - token: The string used to pad the String. Must be 1 character in length. Defaults to a white space if the parameter is left blank.
    /// - Returns: The padded copy of the string.
    func padding(length: Int, token: String = " ") -> String {
        guard paddingConditionsSatisfied(tokenCount: token.count, length: length) else { return self }
        
        let delta = Int(ceil(Double(length-self.length())/2))
        return paddingLeft(length: length-delta, token: token).paddingRight(length: length, token: token)
    }
    
    /// Returns the left-padded version of the string.
    ///
    /// Example 1:
    ///
    ///     let string = "Hello World"
    ///     print(string.paddingLeft(length: 13))
    ///     // Prints "  Hello World"
    ///
    /// Example 2:
    ///
    ///     let string = "Hello World"
    ///     print(string.paddingLeft(length: 13, withToken: "*"))
    ///     // Prints "**Hello World"
    ///
    /// - Parameters:
    ///
    ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
    ///   - token: The string used to pad the String. Must be 1 character in length. Defaults to a white space if the parameter is left blank.
    /// - Returns: The left-padded copy of the string.
    @discardableResult
    func paddingLeft(length: Int, token: String = " ") -> String {
        guard paddingConditionsSatisfied(tokenCount: token.count, length: length) else { return self }
        
        var s = self
        repeat { s.insert(token[token.startIndex], at: startIndex) } while s.count < length
        return s
    }
    
    /// Returns the right-padded version of the string.
    ///
    /// Example 1:
    ///
    ///     let string = "Hello World"
    ///     print(string.paddingRight(length: 13))
    ///     // Prints "Hello World  "
    ///
    /// Example 2:
    ///
    ///     let string = "Hello World"
    ///     print(string.paddingRight(length: 13, withToken: "*", ))
    ///     // Prints "Hello World**"
    ///
    /// - Parameters:
    ///   - length: The final length of your string. If the provided length is less than or equal to the original string, the original string is returned.
    ///   - token: The string used to pad the String. Must be 1 character in length. Defaults to a white space if the parameter is left blank.
    /// - Returns: The right-padded copy of the string.
    @discardableResult
    func paddingRight(length: Int, token: String = " ") -> String {
        guard paddingConditionsSatisfied(tokenCount: token.count, length: length) else { return self }
        
        var s = self
        repeat { s.insert(token[token.startIndex], at: endIndex) } while s.count < length
        return s
    }
    
}

public extension String {
    
    /// A Boolean value indicating if all the pre-padding operation conditions are satisfied.
    ///
    /// - Parameters:
    ///   - token: The token that will be used for padding.
    ///   - length: The final length of the string.
    /// - Returns: True, if the string can be padded. Otherise, false.
    func paddingConditionsSatisfied(tokenCount: Int, length: Int) -> Bool {
        guard length > count, tokenCount == 1 else {
            return false
        }
        return true
    }
    
}

// MARK: - Trimming Operations

public extension String {
    
    /// Returns a prefixed version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(trimLeft(byKeeping: 7))
    ///     // Prints "Hello W"
    ///
    /// - Parameter length: The length of the string that you'd like to return, starting at the beginning of the string. If the provided length is greater than the original string, the original string is returned.
    /// - Returns: A prefixed copy of the string.
    @discardableResult
    func trimLeft(byKeeping length: Int) -> String {
        return String(prefix(length))
    }
    
    /// Returns a suffixed version of the string.
    ///
    ///     let string = "Hello World"
    ///     print(trimRight(byKeeping: 7))
    ///     // Prints "o World"
    ///
    /// - Parameter length: The length of the string that you'd like to return, starting at the end of the string. If the provided length is greater than the original string, the original string is returned.
    /// - Returns: A prefixed copy of the string.
    @discardableResult
    func trimRight(byKeeping length: Int) -> String {
        return String(suffix(length))
    }
    
    /// Returns the left-trimmed version of the string.
    ///
    /// Example:
    ///
    ///     let string = "Hello World"
    ///     print(string.trimLeft(byRemoving: length: 7))
    ///     // Prints "o World"
    ///
    /// - Parameter length: The number of characters to trim from the beginning of the string. If the provided length is greater than the original string, the original string is returned.
    /// - Returns: The left-trimmed copy of the string.
    @discardableResult
    func trimLeft(byRemoving length: Int) -> String {
        guard count - length > 0 else {
            return self
        }
        return trimRight(byKeeping: count - length)
    }
    
    /// Returns the right-trimmed version of the string.
    ///
    /// Example 1:
    ///
    ///     let string = "Hello World"
    ///     print(string.trimRight(byRemoving: length: 7))
    ///     // Prints "Hello W"
    ///
    /// - Parameter length: The number of characters to trim from the end of the string. If the provided length is greater than the original string, the original string is returned.
    /// - Returns: The right-trimmed copy of the string.
    @discardableResult
    func trimRight(byRemoving length: Int) -> String {
        guard count - length > 0 else {
            return self
        }
        return trimLeft(byKeeping: count - length)
    }
    
    /// Returns the truncated string with an ellipsis.
    ///
    /// Example:
    ///
    ///     let string = "Hello World"
    ///     print(string.truncated(length: 8))
    ///     // Prints "Hello..."
    ///
    /// - Parameter length: The final length of the string, which includes the ellipsis: `...`).
    /// - Returns: The truncated copy of the string.
    @discardableResult
    func truncated(length: Int) -> String {
        let ellipsis = "..."
        
        let delta = self.length() - length
        guard delta > 0 else {
            return self
        }
        
        let lengthWithoutEllipsis = length-ellipsis.length()
        guard lengthWithoutEllipsis > 0 else {
            return self
        }
        
        return trimLeft(byKeeping: lengthWithoutEllipsis) + ellipsis
    }
}
