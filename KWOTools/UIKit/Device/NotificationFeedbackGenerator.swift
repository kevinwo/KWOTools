#if os(iOS)
import UIKit
import AudioToolbox

public class NotificationFeedbackGenerator: FeedbackGenerator {

    public var feedbackGenerator: UIFeedbackGenerator?

    public init() {
        if FeedbackSupportLevel.forDevice == .haptic {
            self.feedbackGenerator = UINotificationFeedbackGenerator()
        }
    }

    public func successNotificationOccurred() {
        switch FeedbackSupportLevel.forDevice {
        case .haptic:
            // 2nd Generation Taptic Engine w/ Haptic Feedback (iPhone 7/7+/8/8+/X)
            if let feedbackGenerator = self.feedbackGenerator as? UINotificationFeedbackGenerator {
                feedbackGenerator.notificationOccurred(.success)
            }
        case .taptic:
            // 1st Generation Taptic Engine (iPhone 6S/6S+)
            let soundId = 1520 // pop
            let id = SystemSoundID(soundId)
            AudioServicesPlaySystemSound(id)
            break
        case .none:
            // No Taptic Engine
            break
        }
    }
}
#endif
