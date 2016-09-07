//
//  NSIndexSet+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/11/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension IndexSet {
    public func toArray() -> [Int] {
        var indexes = [Int]()

        let indexSet = self as NSIndexSet
        var currentIndex = indexSet.firstIndex

        while currentIndex != NSNotFound {
            indexes.append(currentIndex)
            currentIndex = indexSet.indexGreaterThanIndex(currentIndex)
        }

        return indexes
    }
}
