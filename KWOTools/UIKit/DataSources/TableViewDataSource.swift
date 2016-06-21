//
//  TableViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 3/15/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public typealias KWOTableViewDataSourceCellConfigurationBlock = (cell: UITableViewCell, object: AnyObject) -> Void

public class TableViewDataSource: DataSource {

    public weak var tableView: UITableView!
    public var cellConfigurationBlock: KWOTableViewDataSourceCellConfigurationBlock?

    public convenience init(tableView: UITableView, sections: [[AnyObject]]) {
        self.init(tableView: tableView)
        self.sections = sections
    }

    public init(tableView: UITableView, items: [AnyObject]? = nil, cellReuseIdentifier: String? = nil, cellConfigurationBlock: KWOTableViewDataSourceCellConfigurationBlock? = nil, cellDelegate: AnyObject? = nil) {
        self.tableView = tableView
        self.cellConfigurationBlock = cellConfigurationBlock
        super.init(items: items, cellReuseIdentifier: cellReuseIdentifier, cellDelegate: cellDelegate)
        self.tableView.dataSource = self
    }

    public func objectInCell(cell: UITableViewCell) -> AnyObject? {
        if let indexPath = self.tableView.indexPathForCell(cell) {
            return self.sections[indexPath.section][indexPath.row]
        }

        return nil
    }

    public func selectedObject() -> AnyObject? {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            return self.sections[indexPath.section][indexPath.row]
        }

        return nil
    }

    public func reload() {
        self.tableView.reloadData()
    }
}

extension TableViewDataSource: UITableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = self.sections[indexPath.section][indexPath.row]
        let reuseIdentifier = self.cellReuseIdentifier ?? Mirror.classNameForObject(object)
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let reusableView = cell as! KWOConfigurableReusableView

        if self.cellConfigurationBlock != nil {
            self.cellConfigurationBlock!(cell: cell, object: object)
        } else {
            if self.cellDelegate != nil {
                reusableView.setDelegate?(self.cellDelegate!)
            }

            reusableView.configure(object)

            return reusableView as! UITableViewCell
        }

        return cell
    }

    public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.sectionTitles.isEmpty ? nil : self.sectionTitles
    }

    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles.isEmpty ? nil : self.sectionTitles[section]
    }
}