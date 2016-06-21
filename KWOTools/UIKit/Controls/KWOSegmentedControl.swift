//
//  KWOSegmentedControl.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/10/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public class KWOSegmentedControl: UISegmentedControl {

    public init(items: [AnyObject]?, target: AnyObject?, selector: Selector, segmentWidth: CGFloat? = nil) {
        super.init(frame: CGRectZero)

        self.addTarget(target, action: selector, forControlEvents: .ValueChanged)

        if let theItems = items where theItems.count > 0 {
            for item in theItems {
                let end = self.numberOfSegments

                switch item {
                case is UIImage:
                    self.insertSegmentWithImage(item as? UIImage, atIndex: end, animated: false)
                case is String:
                    self.insertSegmentWithTitle(item as? String, atIndex: end, animated: false)
                default:
                    break
                }
            }
            self.selectedSegmentIndex = 0
        }

        if let width = segmentWidth {
            for segment in 0..<self.numberOfSegments {
                self.setWidth(width, forSegmentAtIndex: segment)
            }
        }

        self.sizeToFit()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
