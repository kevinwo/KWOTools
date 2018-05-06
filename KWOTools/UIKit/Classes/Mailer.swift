//
//  Mailer.swift
//  Branch
//
//  Created by Kevin Wolkober on 2/24/18.
//

import UIKit
import MessageUI

open class Mailer: NSObject {

    private weak var presentingController: UIViewController!
    private var completion: ((_ error: Error?) -> Void)?

    public init(presentingController: UIViewController) {
        self.presentingController = presentingController
        super.init()
    }

    public static func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }

    open func sendEmail(_ recipients: [String], subject: String? = nil, body: String? = nil, completion: ((_ error: Error?) -> Void)?) {
        if Mailer.canSendMail() {
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

            self.completion = completion
            self.presentingController.present(controller, animated: true, completion: nil)
        } else {
            var message: String
            
            if let recipient = recipients.first {
                message = "This device is not configured to send mail. Please send an email to \(recipient)"
            } else {
                message = "This device is not configured to send mail."
            }
            
            UIAlertController.kwo_errorAlert(NSError.kwo_error(withTitle: "System mail not configured", message: message)).kwo_show(in: self.presentingController)
        }
    }
}

extension Mailer: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.completion?(error)
    }
}

