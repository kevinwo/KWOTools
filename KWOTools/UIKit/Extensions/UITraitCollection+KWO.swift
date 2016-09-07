//
//  UITraitCollection+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/29/16.
//  Adapted from Michael Koukoullis
//  https://github.com/kouky/adaptive-instagram-app/blob/master/AdaptiveInstagram/UITraitCollection%2BMKAdditions.m
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

extension UITraitCollection {
    public func kwo_matchesPhoneLandscape() -> Bool {
        if (self.horizontalSizeClass == .compact && self.verticalSizeClass == .compact) || (self.horizontalSizeClass == .regular && self.verticalSizeClass == .compact) {
            return true
        }

        return false
    }

    public func kwo_matchesPhonePortrait() -> Bool {
        if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
            return true
        }

        return false
    }
}
