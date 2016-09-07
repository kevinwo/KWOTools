//
//  CollectionViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/7/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

open class CollectionViewDataSource: DataSource {

    open weak var collectionView: UICollectionView!

    convenience public init(collectionView: UICollectionView, sections: [[AnyObject]]) {
        self.init(collectionView: collectionView)
        self.sections = sections
    }

    public init(collectionView: UICollectionView, items: [AnyObject]? = nil, cellReuseIdentifier: String? = nil, cellDelegate: AnyObject? = nil) {
        self.collectionView = collectionView
        super.init(items: items, cellReuseIdentifier: cellReuseIdentifier, cellDelegate: cellDelegate)
        self.collectionView.dataSource = self
    }

    open func reload() {
        self.collectionView.reloadData()
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = self.sections[indexPath.section][indexPath.row]
        let reuseIdentifier = self.cellReuseIdentifier ?? Mirror.classNameForObject(object)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let reusableView = cell as! KWOConfigurableReusableView

        if self.cellDelegate != nil {
            reusableView.setDelegate?(self.cellDelegate!)
        }

        reusableView.configure(object)

        return reusableView as! UICollectionViewCell
    }
}
