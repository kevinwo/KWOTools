//
//  CollectionViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 5/7/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public typealias KWOCollectionViewDataSourceCellConfigurationBlock = (_ cell: UICollectionViewCell, _ object: AnyObject, _ indexPath: IndexPath) -> Void
public typealias KWOCollectionViewDataSourceSupplementaryViewConfigurationBlock = (_ cell: UICollectionReusableView, _ object: AnyObject) -> Void

open class CollectionViewDataSource: DataSource {

    public weak var collectionView: UICollectionView!
    var cellConfigurationBlock: KWOCollectionViewDataSourceCellConfigurationBlock
    
    public init(
        collectionView: UICollectionView,
        items: [AnyObject],
        cellConfigurationBlock: @escaping KWOCollectionViewDataSourceCellConfigurationBlock,
        cellReuseIdentifier: String? = nil) {
        self.collectionView = collectionView
        self.cellConfigurationBlock = cellConfigurationBlock
        super.init(items: items, cellReuseIdentifier: cellReuseIdentifier)
        self.collectionView.dataSource = self
    }
    
    public func reload() {
        self.collectionView.reloadData()
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = self.sections[indexPath.section][indexPath.row]
        let reuseIdentifier = self.cellReuseIdentifier ?? Mirror.classNameForObject(object)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        self.cellConfigurationBlock(cell, object, indexPath)
        
        return cell
    }
}
