import UIKit

#if !os(watchOS)
public protocol Router: NSObjectProtocol {

    associatedtype T: UIViewController
    static var storyboard: UIStoryboard { get }
    var view: T! { get set }
    init(view: T)
}
#endif
