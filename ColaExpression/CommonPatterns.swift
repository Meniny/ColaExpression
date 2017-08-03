//
//  CommonPatterns.swift
//  Pods
//
//  Created by Meniny on 2017-08-03.
//
//

import Foundation

public extension ColaExpression {
    
    /// Pattern matches email addresses.
    public static let emailPattern = ColaExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    
    /// Pattern matches first alphanumeric character of each word.
    public static let firstCharacterPattern = ColaExpression("(\\b\\w|(?<=_)[^_])")
    
    /// Pattern matches last alphanumeric character of each word.
    public static let lastCharacterPattern = ColaExpression("(\\w\\b|[^_](?=_))")
    
    /// Pattern matches non-Alphanumeric characters.
    public static let nonAlphanumericPattern = ColaExpression("[^a-zA-Z\\d]")
    
    /// Pattern matches non-Alphanumeric and non-Whitespace characters.
    public static let nonAlphanumericSpacePattern = ColaExpression("[^a-zA-Z\\d\\s]")
    
    /// Pattern matches scientific notations
    public static let scientificNotation = ColaExpression("^([+-]?)((?<!0)\\d\\.\\d{1,})E([-]?)(\\d+)$")
}
