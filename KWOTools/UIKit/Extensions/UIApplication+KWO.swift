//
//  UIApplication+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/6/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit.UIApplication

extension UIApplication {
    public class func resignKeyboard() {
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }

    public class func canOpen(URLScheme: String) -> Bool {
        return UIApplication.sharedApplication().canOpenURL(
            NSURL(string: URLScheme)!)
    }
}