//
//  DragDismissable.swift
//  KWOTools
//
//  Created by Robert Chen on 1/6/16.
//  https://github.com/ThornTechPublic/InteractiveModal/blob/master/InteractiveModal/ModalViewController.swift
//  Copyright © 2016 Thorn Technologies. All rights reserved.

//  Adapted by Kevin Wolkober on 10/31/16.
//

#if os(iOS)
import UIKit

public protocol DragDismissable: NSObjectProtocol {
    var transitionInteractor: TransitionInteractor? { get set }
    func addPanGestureRecognition(target: Any?, action: Selector?)
    func handleGesture(with recognizer: UIPanGestureRecognizer)
}

extension DragDismissable where Self: UIViewController {
    public func addPanGestureRecognition(target: Any?, action: Selector?) {
        let recognizer = UIPanGestureRecognizer(target: target, action: action)
        recognizer.cancelsTouchesInView = true
        recognizer.delaysTouchesEnded = true
        self.view.addGestureRecognizer(recognizer)
    }

    public func handleGesture(with recognizer: UIPanGestureRecognizer) {
        let percentThreshold: CGFloat = 0.3

        // convert y-position to downward pull progress (percentage)
        let translation = recognizer.translation(in: self.view)
        let verticalMovement = translation.y / self.view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)

        guard let interactor = self.transitionInteractor else { return }

        switch recognizer.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
}
#endif
