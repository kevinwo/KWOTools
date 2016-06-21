//
//  NSIndexSet+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/11/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension NSIndexSet {
    public func toArray() -> [Int] {
        var indexes = [Int]()

        self.enumerateIndexesUsingBlock { (index:Int, _) in
            indexes.append(index)
        }

        return indexes
    }
}
