//
//  ResizableViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/21/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

@objc protocol ViewResizable {
    var frame: CGRect { get set }
    func systemLayoutSizeFittingSize(targetSize: CGSize) -> CGSize
}

protocol ResizableViewDataSource {
    var resizableViewLookup: [String: (viewClassName: String, view: KWOConfigurableReusableView?)] { get set }
    var resizableViewHeight: CGFloat? { get }
    func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject
}

extension ResizableViewDataSource {
    mutating func sizeForReusableViewAtIndexPath(indexPath: NSIndexPath) -> CGSize {
        let object = self.objectAtIndexPath(indexPath)
        let className = Mirror.classNameForObject(object)

        let sizingViewTuple = self.resizableViewLookup[className]!
        var sizingView = sizingViewTuple.view

        if sizingView == nil {
            let cellNib = UINib(nibName: sizingViewTuple.viewClassName, bundle: nil)
            sizingView = (cellNib.instantiateWithOwner(nil, options: nil) as NSArray).firstObject as? KWOConfigurableReusableView
            self.resizableViewLookup[className]!.view = sizingView
        }

        sizingView!.configureWithObject(object)
        let size = sizingView!.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let height = self.resizableViewHeight ?? sizingView!.frame.height

        return CGSizeMake(size.width, height)
    }
}