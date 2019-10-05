//
//  ResizableViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 6/21/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

#if !os(watchOS)
import UIKit

@objc public protocol ViewResizable: NSObjectProtocol {
    var frame: CGRect { get set }
    func systemLayoutSizeFittingSize(_ targetSize: CGSize) -> CGSize
}

public protocol ResizableViewDataSource: NSObjectProtocol {
    var resizableViewLookup: [String: (viewClassName: String, view: KWOConfigurableReusableView?)] { get set }
    var resizableViewHeight: CGFloat? { get }
    func objectAtIndexPath(_ indexPath: IndexPath) -> AnyObject
}

extension ResizableViewDataSource {
    public func sizeForReusableViewAtIndexPath(_ indexPath: IndexPath) -> CGSize {
        let object = self.objectAtIndexPath(indexPath)
        let className = Mirror.classNameForObject(object)

        let sizingViewTuple = self.resizableViewLookup[className]!
        var sizingView = sizingViewTuple.view

        if sizingView == nil {
            let cellNib = UINib(nibName: sizingViewTuple.viewClassName, bundle: nil)
            sizingView = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as? KWOConfigurableReusableView
            self.resizableViewLookup[className]!.view = sizingView
        }

        sizingView!.configure(object)
        let size = sizingView!.systemLayoutSizeFittingSize(UIView.layoutFittingCompressedSize)
        let height = self.resizableViewHeight ?? sizingView!.frame.height

        return CGSize(width: size.width, height: height)
    }
}
#endif
