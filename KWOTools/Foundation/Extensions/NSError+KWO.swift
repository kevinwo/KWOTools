//
//  NSError+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 12/11/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import Foundation

extension NSError {

    public class func kwo_error(withTitle title: String, message: String? = nil, domain: String = "KWOErrorDomain", code: Int = 0) -> NSError {
        var userInfo = [NSLocalizedDescriptionKey: title]

        if message != nil {
            userInfo[NSLocalizedRecoverySuggestionErrorKey] = message
        }

        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}

func fatalUnimplementedMethodError(methodSignature: String, file: String) {
    fatalError("Please implement \(methodSignature) in \(file). Thank you")
}
