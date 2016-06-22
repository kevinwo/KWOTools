//
//  KWOConfigurableReusableView.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 12/10/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import Foundation

@objc public protocol KWOConfigurableReusableView: ViewResizable {
    func configure(object: AnyObject)
    optional func setDelegate(delegate: AnyObject)
}
