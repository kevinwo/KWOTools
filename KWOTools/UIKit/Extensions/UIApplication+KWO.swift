//
//  UIApplication+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/6/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

extension UIApplication {
    public static var kwo_shared: UIApplication? {
        get {
            let selector: Selector = NSSelectorFromString("shared")
            guard let klass = NSClassFromString("UIApplication") else { return nil }
            guard class_respondsToSelector(klass, selector) else { return nil }

            return (klass as! NSObjectProtocol).perform(selector).takeRetainedValue() as? UIApplication
        }
    }

    public class func kwo_resignKeyboard() {
        UIApplication.kwo_shared?.keyWindow?.endEditing(true)
    }

    public class func kwo_canOpen(_ URLScheme: String) -> Bool {
        return UIApplication.kwo_shared?.canOpenURL(
            URL(string: URLScheme)!) ?? false
    }

    public func kwo_open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
        // @TODO Fix this to actually make it work!
        let selector: Selector = NSSelectorFromString("_:options:completionHandler:")
        if self.responds(to: selector) {
            self.perform(selector)
        }
    }
}
