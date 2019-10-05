import UIKit

#if !os(watchOS)
public class UserDevice: NSObject {

    public static var modelIdentifier: String {
        get {
            if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
            var sysinfo = utsname()
            uname(&sysinfo)

            return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
        }
    }

    #if os(iOS)
    public static func prepareFeedback(for feedbackGenerator: FeedbackGenerator) {
        if FeedbackSupportLevel.forDevice != .none {
            feedbackGenerator.prepare()
        }
    }

    public static func impactFeedback(with feedbackGenerator: ImpactFeedbackGenerator) {
        if FeedbackSupportLevel.forDevice != .none {
            feedbackGenerator.impactOccurred()
        }
    }

    public static func notifySuccessFeedback(with feedbackGenerator: NotificationFeedbackGenerator) {
        if FeedbackSupportLevel.forDevice != .none {
            feedbackGenerator.successNotificationOccurred()
        }
    }
    #endif
}
#endif
