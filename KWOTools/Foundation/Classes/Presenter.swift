//
//  Presenter.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/9/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

open class Presenter: NSObject {

    open func viewDidLoad() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    open func viewWillAppear() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    open func viewWillDisappear() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    open func viewDidAppear() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    open func showErrorAlert(_ error: Error) {
        UIAlertController.kwo_alert(withError: error).kwo_show()
    }
}
