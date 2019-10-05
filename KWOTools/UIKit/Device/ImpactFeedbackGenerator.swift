#if os(iOS)
import UIKit
import AudioToolbox

public class ImpactFeedbackGenerator: FeedbackGenerator {

    public var feedbackGenerator: UIFeedbackGenerator?
    private let style: UIImpactFeedbackGenerator.FeedbackStyle

    public init(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        self.style = style

        if FeedbackSupportLevel.forDevice == .haptic {
            self.feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        }
    }

    public func impactOccurred() {
        switch FeedbackSupportLevel.forDevice {
        case .haptic:
            // 2nd Generation Taptic Engine w/ Haptic Feedback (iPhone 7/7+/8/8+/X)
            if let feedbackGenerator = self.feedbackGenerator as? UIImpactFeedbackGenerator {
                feedbackGenerator.impactOccurred()
            }
        case .taptic:
            // 1st Generation Taptic Engine (iPhone 6S/6S+)
            let soundId: UInt32? = {
                switch self.style {
                case .light, .soft:
                    return 1519 // peek
                case .medium, .heavy, .rigid:
                    return 1520 // pop
                @unknown default:
                    return nil
                }
            }()

            if let soundId = soundId {
                let id = SystemSoundID(soundId)
                AudioServicesPlaySystemSound(id)
            }
        case .none:
            // No Taptic Engine
            break
        }
    }
}
#endif
