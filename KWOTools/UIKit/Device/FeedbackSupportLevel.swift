#if !os(watchOS)
import UIKit

public enum FeedbackSupportLevel {
    case haptic
    case taptic
    case none

    public static var forDevice: FeedbackSupportLevel {
        if let feedbackSupportLevel = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int {
            switch feedbackSupportLevel {
            case 2:
                return .haptic
            case 1:
                return .taptic
            case 0:
                return .none
            default:
                return .none
            }
        }

        return .none
    }
}
#endif
