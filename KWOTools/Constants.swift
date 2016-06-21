//
//  Constants.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/19/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

public let kKWOErrorDomain = "KWOErrorDomain"
public let kKWOAppBundleName: String? = NSBundle.mainBundle().infoDictionary?[kCFBundleNameKey as String] as? String
public typealias KWOSuccessBlock = () -> Void
public typealias KWOFailureBlock = (error: NSError) -> Void
