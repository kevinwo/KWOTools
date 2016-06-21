//
//  UIAlertController+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/9/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit.UIAlertController

@objc public protocol ActionSheetActionable: NSObjectProtocol {
    var actionSheetActionTitle: String { get }
}

extension UIAlertController {
    public class func kwo_alert(withError error: NSError) -> UIAlertController {
        let title = error.localizedDescription
        let message = (error.localizedRecoverySuggestion != nil) ? error.localizedRecoverySuggestion : error.localizedFailureReason
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))

        return alertVC
    }

    public class func kwo_alert(withTitle title: String, message: String? = nil, confirmationTitle: String? = nil, cancelTitle: String? = nil, isDestructive: Bool = false, confirmationHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        if let title = confirmationTitle {
            let style: UIAlertActionStyle = isDestructive ? .Destructive : .Default
            alertVC.addAction(UIAlertAction(title: title, style: style, handler: { (action) -> Void in
                confirmationHandler?()
            }))
        }

        let title = cancelTitle ?? "OK"
        alertVC.addAction(UIAlertAction(title: title, style: .Cancel, handler: { (action) -> Void in
            cancelHandler?()
        }))

        return alertVC
    }

    public class func kwo_actionSheet(title: String? = nil, message: String? = nil, options: [ActionSheetActionable], handler: (action: UIAlertAction, index: Int) -> Void) -> UIAlertController {
        return self.kwo_actionSheet(title, message: message, optionTitles: options.map({ $0.actionSheetActionTitle }), handler: handler)
    }

    public class func kwo_actionSheet(title: String? = nil, message: String? = nil, optionTitles: [String], tintColor: UIColor? = nil, sourceView: UIView? = nil, handler: (action: UIAlertAction, index: Int) -> Void) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)

        for (index, option) in optionTitles.enumerate() {
            let action = UIAlertAction(title: option, style: .Default, handler: { (action) -> Void in
                handler(action: action, index: index)
            })
            alertVC.addAction(action)
        }

        alertVC.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))

        if tintColor != nil {
            alertVC.view.tintColor = tintColor
        }

        if let view = sourceView {
            alertVC.popoverPresentationController?.sourceView = view
            alertVC.popoverPresentationController?.sourceRect = view.bounds
        }

        return alertVC
    }

    public func kwo_show(presentingViewController: UIViewController? = nil) {
        let controller = presentingViewController ?? UIApplication.sharedApplication().keyWindow!.rootViewController!
        controller.presentViewController(self, animated: true, completion: nil)
    }
}
