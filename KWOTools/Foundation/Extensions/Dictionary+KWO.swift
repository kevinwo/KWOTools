//
//  Dictionary+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/7/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension Dictionary {
    public mutating func addEntriesFromDictionary(dictionary: [Key: Value]) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
}