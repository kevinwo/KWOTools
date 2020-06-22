import UIKit

public struct KWOAlert {
    public let title: String
    public let message: String?
    public let confirmButtonTitle: String
    public let cancelButtonTitle: String
    public let confirmAction: (() -> Void)?
    public let cancelAction: (() -> Void)?

    public init(
        title: String,
        message: String?,
        confirmButtonTitle: String = "Confirm",
        cancelButtonTitle: String = "OK",
        confirmAction: (() -> Void)? = nil,
        cancelAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.confirmButtonTitle = confirmButtonTitle
        self.cancelButtonTitle = cancelButtonTitle
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
    }
}

public protocol ViewRoutable: AnyObject {

    func present(view: ViewRoutable, animated flag: Bool, completion: (() -> Void)?)
    func presentAlert(for error: AlertableError)
    func presentOnTabBarController(view: ViewRoutable, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)

    func pushOnNavigationController(view: ViewRoutable, animated flag: Bool)
    func popViewOnNavigationController(animated flag: Bool)
}

#if !os(watchOS)
extension ViewRoutable where Self: UIViewController {

    public func present(view: ViewRoutable, animated flag: Bool, completion: (() -> Void)?) {
        let view = view as! UIViewController
        present(view, animated: flag, completion: completion)
    }

    public func presentAlert(for error: AlertableError) {
        let alert = KWOAlert(title: error.alertTitle, message: error.alertMessage)
    }

    public func presentAlert(_ alert: KWOAlert) {
        let controller = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let action = UIAlertAction(title: alert.cancelButtonTitle, style: .default, handler: nil)
        controller.addAction(action)

        present(controller, animated: true, completion: nil)
    }

    public func presentOnTabBarController(view: ViewRoutable, animated flag: Bool, completion: (() -> Void)?) {
        let view = view as! UIViewController
        self.tabBarController?.present(view, animated: flag, completion: completion)
    }

    public func pushOnNavigationController(view: ViewRoutable, animated flag: Bool) {
        let view = view as! UIViewController
        self.navigationController?.pushViewController(view, animated: flag)
    }

    public func popViewOnNavigationController(animated flag: Bool) {
        self.navigationController?.popViewController(animated: flag)
    }
}

extension UIViewController: ViewRoutable {}
#endif
