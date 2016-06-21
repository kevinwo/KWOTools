//
//  CollectionViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/7/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public class CollectionViewDataSource: DataSource {

    public weak var collectionView: UICollectionView!

    convenience public init(collectionView: UICollectionView, sections: [[AnyObject]]) {
        self.init(collectionView: collectionView)
        self.sections = sections
    }

    public init(collectionView: UICollectionView, items: [AnyObject]? = nil, cellReuseIdentifier: String? = nil, cellDelegate: AnyObject? = nil) {
        self.collectionView = collectionView
        super.init(items: items, cellReuseIdentifier: cellReuseIdentifier, cellDelegate: cellDelegate)
        self.collectionView.dataSource = self
    }

    public func reload() {
        self.collectionView.reloadData()
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let object = self.sections[indexPath.section][indexPath.row]
        let reuseIdentifier = self.cellReuseIdentifier ?? Mirror.classNameForObject(object)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let reusableView = cell as! KWOConfigurableReusableView

        if self.cellDelegate != nil {
            reusableView.setDelegate?(self.cellDelegate!)
        }

        reusableView.configure(object)

        return reusableView as! UICollectionViewCell
    }
}
