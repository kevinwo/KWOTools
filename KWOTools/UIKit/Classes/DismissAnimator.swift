//
//  DismissAnimator.swift
//  KWOTools
//
//  Created by Robert Chen on 1/8/16.
//  https://github.com/ThornTechPublic/InteractiveModal/blob/master/InteractiveModal/DismissAnimator.swift
//  Copyright © 2016 Thorn Technologies. All rights reserved.
//
//  Adapted by Kevin Wolkober on 10/31/16.
//

import UIKit

public class DismissAnimator: NSObject {

    let transitionDuration: TimeInterval
    
    public init(transitionInteractor: TransitionInteractor) {
        self.transitionDuration = transitionInteractor.transitionDuration
    }
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }

        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
        },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
}
