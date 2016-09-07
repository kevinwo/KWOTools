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
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }

    public var kwo_localized: String {
        #if !os(OSX)
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        #else
            return CFBundleCopyLocalizedString(CFBundleGetMainBundle(), self, "", nil) as String
        #endif
    }

    public var kwo_length: Int {
        return self.characters.count
    }

    public var kwo_isUppercase: Bool {
        if self == self.lowercased() {
            return false
        }

        return true
    }

    public mutating func kwo_insert(_ string: String, atIndex index: Int) {
        self.insert(contentsOf: string.characters, at: self.index(self.startIndex, offsetBy: index))
    }

    public func kwo_regex(_ pattern: String) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results
            //            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    public func kwo_trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public func kwo_removeEmptyLines() -> String {
        return self.replacingOccurrences(of: "\n\n", with: "\n")
    }
}

extension NSAttributedString {
    public func kwo_size(constrainedToWidth width: CGFloat, inset: CGSize = CGSize.zero) -> CGSize {
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin]
        let rect = self.boundingRect(with: CGSize(width: width - (inset.width * 2), height: CGFloat.greatestFiniteMagnitude), options: options, context: nil)

        return CGSize(width: rect.width, height: rect.height + (inset.height * 2))
    }
}
