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
        if #available(iOS 10.0, *) {
            self.open(url, options: options, completionHandler: completion)
        } else {
            self.openURL(url)
        }
    }
}
