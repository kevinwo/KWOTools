import Foundation

public protocol AlertableError: Swift.Error {

    var alertTitle: String { get }
    var alertMessage: String? { get }
}

extension AlertableError {

    public var localizedDescription: String {
        return ("TITLE: \(alertTitle)\nMESSAGE: \(alertMessage ?? "nil")")
    }
}
