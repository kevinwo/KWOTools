//
//  NSObject+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 2/24/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

extension NSObject {
    public static var className: String {
        let components = String(self).characters.split{$0 == "."}.map(String.init)

        return components.last!
    }
}

extension Mirror {
    public static func classNameForObject(object: AnyObject) -> String {
        let objectMirror = Mirror(reflecting: object)

        return String(objectMirror.subjectType)
    }
}