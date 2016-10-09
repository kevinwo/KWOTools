//
//  UIApplication+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/6/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

extension UIApplication {
    public func kwo_open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
        // @TODO Fix this to actually make it work!
        let selector: Selector = NSSelectorFromString("_:options:completionHandler:")
        if self.responds(to: selector) {
            self.perform(selector)
        }
    }
}
