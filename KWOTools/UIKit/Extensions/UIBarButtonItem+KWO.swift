//
//  UIBarButtonItem+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/25/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit.UIBarButtonItem

extension UIBarButtonItem {
    public class func fixedSpaceItem(_ width: CGFloat) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = width

        return item
    }
}
