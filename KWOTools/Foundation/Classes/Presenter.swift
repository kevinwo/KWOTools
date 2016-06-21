//
//  Presenter.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/9/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public class Presenter: NSObject {

    public func viewDidLoad() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    public func viewWillAppear() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    public func viewWillDisappear() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    public func viewDidAppear() {
        fatalUnimplementedMethodError(#function, file: #file)
    }

    public func showErrorAlert(error: NSError) {
        UIAlertController.kwo_alert(withError: error).kwo_show()
    }
}
