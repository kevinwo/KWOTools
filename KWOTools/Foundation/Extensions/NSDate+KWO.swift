//
//  NSDate+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/5/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension NSDate {
    public class func dateFromDouble(doubleDate: Double?) -> NSDate? {
        if let date = doubleDate {
            return NSDate(timeIntervalSince1970: NSTimeInterval(date))
        }

        return nil
    }
}