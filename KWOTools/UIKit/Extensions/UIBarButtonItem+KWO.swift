//
//  UIBarButtonItem+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/25/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit.UIBarButtonItem

extension UIBarButtonItem {
    public class func fixedSpaceItem(width: CGFloat) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        item.width = width

        return item
    }
}