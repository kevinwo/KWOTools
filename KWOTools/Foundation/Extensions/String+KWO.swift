//
//  String+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/18/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension String {
    public var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch _ as NSError {
            return nil
        }
    }
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }

    public func fb_cleanLineBreaks() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }

    public var meetupHtml2String: String {
        var plainString = self

        plainString = plainString.replacingOccurrences(of: "<p><img[^>]+></p>", with: "", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "<p>", with: "", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "</p>", with: "\n\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "<br />", with: "\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "<br/>", with: "\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "<br>", with: "\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "  ", with: "", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "   ", with: "", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "\n ", with: "\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "\n  ", with: "\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "\n   ", with: "\n", options: .regularExpression, range: nil)
        plainString = plainString.replacingOccurrences(of: "\n    ", with: "\n", options: .regularExpression, range: nil)

        return plainString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public var kwo_localized: String {
        #if !os(OSX)
            return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        #else
            return CFBundleCopyLocalizedString(CFBundleGetMainBundle(), self, "", nil) as String
        #endif
    }

    public var kwo_length: Int {
        return self.count
    }

    public var kwo_isUppercase: Bool {
        if self == self.lowercased() {
            return false
        }

        return true
    }

    public var kwo_isValidEmail: Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    public mutating func kwo_insert(_ string: String, atIndex index: Int) {
        self.insert(contentsOf: string, at: self.index(self.startIndex, offsetBy: index))
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

    public func kwo_numberOfWords() -> Int {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let components = self.components(separatedBy: chararacterSet)
        let words = components.filter { !$0.isEmpty }

        return words.count
    }

    public func kwo_slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

extension NSAttributedString {
    public func kwo_size(constrainedToWidth width: CGFloat, inset: CGSize = CGSize.zero) -> CGSize {
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin]
        let rect = self.boundingRect(with: CGSize(width: width - (inset.width * 2), height: CGFloat.greatestFiniteMagnitude), options: options, context: nil)

        return CGSize(width: rect.width, height: rect.height + (inset.height * 2))
    }
}
