//
//  PhoneDialer.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/28/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

open class PhoneDialer: NSObject {

    weak var application: UIApplication!

    public init(application: UIApplication) {
        self.application = application
    }

    open func dial(_ phoneNumber: String) {
        let strippedString = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let URL = Foundation.URL(string: "tel://\(strippedString)")!

        if (self.application.canOpenURL(URL)) {
            DispatchQueue.main.async(execute: {
                self.application.kwo_open(URL)
            })
        }
    }
}
