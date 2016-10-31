//
//  TransitionInteractor.swift
//  KWOTools
//
//  Created by Robert Chen on 1/6/16.
//  https://github.com/ThornTechPublic/InteractiveModal/blob/master/InteractiveModal/Interactor.swift
//  Copyright © 2016 Thorn Technologies. All rights reserved.
//
//  Adapted by Kevin Wolkober on 10/31/16.
//

import Foundation

public class TransitionInteractor: UIPercentDrivenInteractiveTransition {
    public var hasStarted = false
    public var shouldFinish = false
    public var transitionDuration: TimeInterval = 0

    public init(transitionDuration: TimeInterval) {
        self.transitionDuration = transitionDuration
    }
}
