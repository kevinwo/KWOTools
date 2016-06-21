//
//  String+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/18/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension String {
    public func fb_cleanLineBreaks() -> String {
        return self.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
    }

    public var kwo_localized: String {
        #if !os(OSX)
            return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
        #else
            return CFBundleCopyLocalizedString(CFBundleGetMainBundle(), self, "", nil) as String
        #endif
    }

    public var kwo_length: Int {
        return self.characters.count
    }

    public var kwo_isUppercase: Bool {
        if self == self.lowercaseString {
            return false
        }

        return true
    }

    public mutating func kwo_insert(string: String, atIndex index: Int) {
        self.insertContentsOf(string.characters, at: self.startIndex.advancedBy(index))
    }

    public func kwo_regex(pattern: String) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matchesInString(self, options: [], range: NSMakeRange(0, nsString.length))
            return results
            //            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    public func kwo_trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }

    public func kwo_removeEmptyLines() -> String {
        return self.stringByReplacingOccurrencesOfString("\n\n", withString: "\n")
    }
}