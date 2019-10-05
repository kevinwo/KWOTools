//
//  Date.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 10/30/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

public class Dater {

    public var rawDate: Date
    fileprivate var formatter = DateFormatter()

    public init(date: Date, timeZone: TimeZone = TimeZone.current) {
        self.rawDate = date
        self.formatter.timeZone = timeZone
    }

    public func string(for format: String) -> String {
        self.formatter.dateFormat = format

        return formatter.string(from: self.rawDate)
    }
}
