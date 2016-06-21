//
//  UIFont+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/14/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

extension UIFont {
    public class func kwo_preferredFont(forTextStyle style: String, customFontName: String? = nil) -> UIFont {
        if let name = customFontName {
            let systemDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(style)
            let size = systemDynamicFontDescriptor.pointSize

            return UIFont(name: name, size: size)!
        }

        return UIFont.preferredFontForTextStyle(style)
    }
}
