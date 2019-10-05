//
//  DragDismissableViewControllerPresenter.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 10/31/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

#if os(iOS)
import UIKit

public protocol DragDismissableViewControllerPresenter: UIViewControllerTransitioningDelegate {
    var transitionInteractor: TransitionInteractor { get set }
}

extension DragDismissableViewControllerPresenter where Self: UIViewController {
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator(transitionInteractor: self.transitionInteractor)
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.transitionInteractor.hasStarted ? self.transitionInteractor : nil
    }
}
#endif
