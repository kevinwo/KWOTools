//
//  NSDate+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/5/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension Date {
    public static func from(milliseconds: Double, offset: Double? = nil) -> Date? {
        var millisecondsDate = milliseconds

        if let offset = offset {
            millisecondsDate = millisecondsDate + offset
        }

        return Date(timeIntervalSince1970: millisecondsDate)
    }
}

//public func ==(lhs: Date, rhs: Date) -> Bool {
//    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
//}
//
//public func <(lhs: Date, rhs: Date) -> Bool {
//    return lhs.compare(rhs) == .OrderedAscending
//}

