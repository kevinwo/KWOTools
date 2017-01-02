//
//  Mailer.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/24/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit
import MessageUI
import KWOTools

open class Mailer: NSObject {

    weak var presentingController: UIViewController!
    var completion: (() -> Void)?

    public init(presentingController: UIViewController, completion: (() -> Void)?) {
        self.presentingController = presentingController
        self.completion = completion
        super.init()
    }

    open func sendEmail(_ recipients: [String], subject: String? = nil, body: String? = nil) {
        if MFMailComposeViewController.canSendMail() {
            let controller = MFMailComposeViewController()
            controller.mailComposeDelegate = self
            controller.setToRecipients(recipients)
            controller.modalPresentationStyle = .formSheet

            if let text = subject {
                controller.setSubject(text)
            }

            if let text = body {
                controller.setMessageBody(text, isHTML: false)
            }

            self.presentingController.present(controller, animated: true, completion: nil)
        } else {
            var message: String

            if let recipient = recipients.first {
                message = "This device is not configured to send mail. Please send an email to \(recipient)"
            } else {
                message = "This device is not configured to send mail."
            }

            UIAlertController.kwo_alert(with: NSError.kwo_error(withTitle: "System mail not configured", message: message)).kwo_show(self.presentingController)
        }
    }
}

extension Mailer: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.completion?()
    }
}
