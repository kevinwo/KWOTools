//
//  KWOConfigurableReusableView.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 12/10/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

#if !os(watchOS)
import Foundation

@objc public protocol KWOConfigurableReusableView: ViewResizable {
    func configure(_ object: AnyObject)
    @objc optional func setDelegate(_ delegate: AnyObject)
}
#endif
