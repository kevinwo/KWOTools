//
//  UIAlertController+KWO.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 1/1/18.
//

#if !os(watchOS)
import UIKit.UIViewController
import UIKit.UIAlertController

public typealias KWOAlertHandlerBlock = () -> Void

extension UIAlertController {
    public static func kwo_errorAlert(_ error: NSError, buttonTitle: String = "OK") -> UIAlertController {
        let controller = UIAlertController(title: error.localizedFailureReason, message: error.localizedRecoverySuggestion, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        controller.addAction(action)

        return controller
    }

    public static func kwo_alert(
        title: String,
        message: String? = nil,
        confirmationTitle: String? = nil,
        cancelTitle: String? = nil,
        isDestructive: Bool = false,
        confirmationHandler: (() -> Void)? = nil,
        cancelHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let title = confirmationTitle {
            let style: UIAlertActionStyle = isDestructive ? .destructive : .default
            alertVC.addAction(UIAlertAction(title: title, style: style, handler: { (action) -> Void in
                confirmationHandler?()
            }))
        }

        let title = cancelTitle ?? "OK".kwo_localized
        alertVC.addAction(UIAlertAction(title: title, style: .cancel, handler: { (action) -> Void in
            cancelHandler?()
        }))

        return alertVC
    }

    public func kwo_show(in controller: UIViewController) {
        controller.present(self, animated: true, completion: nil)
    }
}
#endif
