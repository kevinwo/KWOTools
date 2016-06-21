//
//  PhoneDialer.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/28/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public class PhoneDialer: NSObject {

    weak var application: UIApplication!

    public init(application: UIApplication) {
        self.application = application
    }

    public func dial(phoneNumber: String) {
        let strippedString = phoneNumber.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        let URL = NSURL(string: "tel://\(strippedString)")!

        if (self.application.canOpenURL(URL)) {
            dispatch_async(dispatch_get_main_queue(), {
                self.application.openURL(URL)
            })
        }
    }
}
