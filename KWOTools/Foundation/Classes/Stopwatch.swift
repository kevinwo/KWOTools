//
//  Stopwatch.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/16/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

public class Stopwatch: NSObject {

    public var timeElapsed: Double
    private var timer: NSTimer!

    public override init() {
        self.timeElapsed = 0
        super.init()
    }

    public func start() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.timerFired), userInfo: nil, repeats: true)
    }

    public func stop() {
        self.timer.invalidate()
    }

    // MARK: Private interface

    func timerFired() {
        self.timeElapsed += 0.01
    }
}
