//
//  UIApplication+KWOApp.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 10/5/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

extension UIApplication {
    public class func kwo_resignKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    public class func kwo_canOpen(_ URLScheme: String) -> Bool {
        return UIApplication.shared.canOpenURL(
            URL(string: URLScheme)!)
    }
}
