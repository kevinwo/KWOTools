#if os(iOS)
import UIKit
import MessageUI

public protocol MailerType {

    static func canSendMail() -> Bool
    func composer(_ recipients: [String], subject: String?, body: String?, completion: ((_ error: AlertableError?) -> Void)?) throws -> UIViewController
}

public class Mailer: NSObject, MailerType {

    // MARK: - Enums

    public enum Error: AlertableError {
        case composerError
        case deviceNotConfigured([String])

        public var alertTitle: String {
            switch self {
            case .composerError:
                return "Mail could not be sent."
            case .deviceNotConfigured(_):
                return "System mail not configured"
            }
        }

        public var alertMessage: String? {
            switch self {
            case .composerError:
                return "Please close the composer, reopen, and try again."
            case .deviceNotConfigured(let recipients):
                let message = { () -> String in
                    if let recipient = recipients.first {
                        return "This device is not configured to send mail. Please send an email to \(recipient)"
                    } else {
                        return "This device is not configured to send mail."
                    }
                }()
                return message
            }
        }
    }

    // MARK: - Properties

    private var completion: ((_ error: AlertableError?) -> Void)?

    // MARK: - Public interface

    public static func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }

    public func composer(_ recipients: [String], subject: String?, body: String?, completion: ((_ error: AlertableError?) -> Void)?) throws -> UIViewController {
        self.completion = completion

        guard Mailer.canSendMail() else {
            throw Error.deviceNotConfigured(recipients)
        }

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


        return controller
    }
}

extension Mailer: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // @TODO: Convert local error into an appropriate set of alertable errors.
        self.completion?(Error.composerError)
    }
}
#endif
