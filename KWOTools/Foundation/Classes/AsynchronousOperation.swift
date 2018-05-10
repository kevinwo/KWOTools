//
//  AsynchronousOperation.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/10/18.
//

import Foundation

open class AsynchronousOperation: Operation {

    public enum State: String {
        case ready = "ready"
        case executing = "executing"
        case finished = "finished"

        var keyPath: String {
            get{
                return "is" + self.rawValue.capitalized
            }
        }
    }

    open override var isAsynchronous: Bool {
        get {
            return true
        }
    }

    public var state = State.ready {
        willSet {
            self.willChangeValue(forKey: state.rawValue)
            self.willChangeValue(forKey: state.keyPath)
            self.willChangeValue(forKey: newValue.rawValue)
            self.willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            self.didChangeValue(forKey: oldValue.rawValue)
            self.didChangeValue(forKey: oldValue.keyPath)
            self.didChangeValue(forKey: state.rawValue)
            self.didChangeValue(forKey: state.keyPath)
        }
    }

    open override var isExecuting: Bool {
        get {
            return state == .executing
        }
    }

    open override var isFinished: Bool {
        return state == .finished
    }

    open override func start() {
        if self.isCancelled {
            self.state = .finished
        } else {
            self.state = .ready
            main()
        }
    }
    
    open override func main() {
        self.state = { () -> State in
            if self.isCancelled {
                return .finished
            } else {
                return .executing
            }
        }()
    }
}
