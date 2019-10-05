//
//  KWOSegmentedControl.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/10/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

#if !os(watchOS)
import UIKit

open class KWOSegmentedControl: UISegmentedControl {

    public init(items: [AnyObject]?, target: AnyObject?, selector: Selector, segmentWidth: CGFloat? = nil) {
        super.init(frame: CGRect.zero)

        self.addTarget(target, action: selector, for: .valueChanged)

        if let theItems = items , theItems.count > 0 {
            for item in theItems {
                let end = self.numberOfSegments

                switch item {
                case is UIImage:
                    self.insertSegment(with: item as? UIImage, at: end, animated: false)
                case is String:
                    self.insertSegment(withTitle: item as? String, at: end, animated: false)
                default:
                    break
                }
            }
            self.selectedSegmentIndex = 0
        }

        if let width = segmentWidth {
            for segment in 0..<self.numberOfSegments {
                self.setWidth(width, forSegmentAt: segment)
            }
        }

        self.sizeToFit()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
