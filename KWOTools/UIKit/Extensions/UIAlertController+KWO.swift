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
    public class func kwo_alert(withError error: Error) -> UIAlertController {
        let title = error.localizedDescription
        let message = ((error as NSError).localizedRecoverySuggestion != nil) ? (error as NSError).localizedRecoverySuggestion : (error as NSError).localizedFailureReason
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        return alertVC
    }

    public class func kwo_alert(withTitle title: String, message: String? = nil, confirmationTitle: String? = nil, cancelTitle: String? = nil, isDestructive: Bool = false, confirmationHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let title = confirmationTitle {
            let style: UIAlertActionStyle = isDestructive ? .destructive : .default
            alertVC.addAction(UIAlertAction(title: title, style: style, handler: { (action) -> Void in
                confirmationHandler?()
            }))
        }

        let title = cancelTitle ?? "OK"
        alertVC.addAction(UIAlertAction(title: title, style: .cancel, handler: { (action) -> Void in
            cancelHandler?()
        }))

        return alertVC
    }

    public class func kwo_actionSheet(_ title: String? = nil, message: String? = nil, options: [ActionSheetActionable], handler: @escaping (_ action: UIAlertAction, _ index: Int) -> Void) -> UIAlertController {
        return self.kwo_actionSheet(title, message: message, optionTitles: options.map({ $0.actionSheetActionTitle }), handler: handler)
    }

    public class func kwo_actionSheet(_ title: String? = nil, message: String? = nil, optionTitles: [String], tintColor: UIColor? = nil, sourceView: UIView? = nil, handler: @escaping (_ action: UIAlertAction, _ index: Int) -> Void) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        for (index, option) in optionTitles.enumerated() {
            let action = UIAlertAction(title: option, style: .default, handler: { (action) -> Void in
                handler(action, index)
            })
            alertVC.addAction(action)
        }

        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if tintColor != nil {
            alertVC.view.tintColor = tintColor
        }

        if let view = sourceView {
            alertVC.popoverPresentationController?.sourceView = view
            alertVC.popoverPresentationController?.sourceRect = view.bounds
        }

        return alertVC
    }

    public func kwo_show(_ presentingViewController: UIViewController? = nil) {
        if let controller = presentingViewController ?? UIApplication.kwo_shared?.keyWindow!.rootViewController! {
            controller.present(self, animated: true, completion: nil)
        }
    }
}
