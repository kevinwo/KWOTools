//
//  UIView+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 2/21/18.
//

#if !os(watchOS)
import UIKit

extension UIView {
    public func setIgnoresInvertColors(_ shouldIgnore: Bool) {
        if #available(iOS 11.0, *) {
            self.accessibilityIgnoresInvertColors = shouldIgnore
        }
    }
}
#endif
