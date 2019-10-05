//
//  UITableView+KWO.swift
//  AcknowList
//
//  Created by Kevin Wolkober on 4/27/18.
//

#if !os(watchOS)
import UIKit

extension UITableView {
    public func animatedReloadData(_ duration: TimeInterval = 0.2) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations:
            { () -> Void in
                self.reloadData()
        }, completion: nil);
    }
}
#endif
