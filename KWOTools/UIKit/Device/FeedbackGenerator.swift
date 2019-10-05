#if os(iOS)
import UIKit

public protocol FeedbackGenerator {
    var feedbackGenerator: UIFeedbackGenerator? { get }
}

extension FeedbackGenerator {
    public func prepare() {
        feedbackGenerator?.prepare()
    }
}
#endif
