//
//  UIApplication+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/6/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

#if !os(watchOS)
import UIKit

extension UIApplication {
    public func kwo_open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
//        self.open(url, options: options, completionHandler: completion)
    }
}
#endif
