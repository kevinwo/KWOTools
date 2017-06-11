//
//  Stopwatch.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/16/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import Foundation

open class Stopwatch: NSObject {

    open var timeElapsed: Double
    fileprivate var timer: Timer!

    public override init() {
        self.timeElapsed = 0
        super.init()
    }

    open func start() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerFired), userInfo: nil, repeats: true)
    }

    open func stop() {
        self.timer.invalidate()
    }

    // MARK: Private interface

    @objc func timerFired() {
        self.timeElapsed += 0.01
    }
}
