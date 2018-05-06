//
//  UIColor+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 2/21/18.
//

import UIKit

extension UIColor {
    public func inverted() -> UIColor {
        var red         :   CGFloat  =   255.0
        var green       :   CGFloat  =   255.0
        var blue        :   CGFloat  =   255.0
        var alpha       :   CGFloat  =   1.0

        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        red     =   255.0 - (red * 255.0)
        green   =   255.0 - (green * 255.0)
        blue    =   255.0 - (blue * 255.0)

        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
