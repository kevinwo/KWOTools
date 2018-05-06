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
        let components = String.init(describing: self).split{$0 == "."}.map(String.init)

        return components.last!
    }
}

extension Mirror {
    public static func classNameForObject(_ object: AnyObject) -> String {
        let objectMirror = Mirror(reflecting: object)

        return String.init(describing: objectMirror.subjectType)
    }
}
