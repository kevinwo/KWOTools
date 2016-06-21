//
//  DataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/7/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public class DataSource: NSObject {
    var sections: [[AnyObject]]!
    public lazy var sectionTitles: [String] = {
        return [String]()
    }()
    var cellReuseIdentifier: String?
    weak var cellDelegate: AnyObject?
    public var items: [AnyObject]? {
        get {
            return self.sections.flatMap({ $0 }) as [AnyObject]?
        }
        set(value) {
            self.sections = [value!]
        }
    }

    init(items: [AnyObject]? = nil, cellReuseIdentifier: String? = nil, cellDelegate: AnyObject? = nil) {
        self.sections = [[AnyObject]]()
        if let items = items {
            self.sections.append(items)
        }

        self.cellReuseIdentifier = cellReuseIdentifier
        self.cellDelegate = cellDelegate
        super.init()
    }

    public func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.sections[indexPath.section][indexPath.row]
    }

    public func setSectionsWithPresortedObjects(objects: [Sectionable]) {
        var sections = [[AnyObject]]()
        var sectionTitles = [String]()
        var currentCharInTitle = ""
        var currentSectionArray = [AnyObject]()

        for (i, object) in objects.enumerate() {
            let name = object.sectioningName
            let firstChar = name.substringToIndex(name.startIndex.advancedBy(1)).uppercaseString

            if firstChar != currentCharInTitle {
                if currentSectionArray.count > 0 {
                    sections.append(currentSectionArray as [AnyObject])
                    sectionTitles.append(currentCharInTitle)
                    currentSectionArray.removeAll()
                }

                currentCharInTitle = firstChar
                currentSectionArray.append(object)
            } else {
                currentSectionArray.append(object)
            }

            if i == objects.count - 1 && !currentSectionArray.isEmpty {
                sections.append(currentSectionArray)
                sectionTitles.append(currentCharInTitle)
            }
        }

        self.sections = sections
        self.sectionTitles = sectionTitles
    }
}
