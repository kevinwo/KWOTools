//
//  NSDate+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/5/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension Date {
    public static func dateFromDouble(_ doubleDate: Double?) -> Date? {
        if let date = doubleDate {
            return Date(timeIntervalSince1970: TimeInterval(date))
        }

        return nil
    }
}
