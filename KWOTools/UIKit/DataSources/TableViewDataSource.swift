//
//  TableViewDataSource.swift
//  KWOTools
//
//  Created by Kevin Wolkober on 3/15/16.
//  Copyright © 2016 Kevin Wolkober. All rights reserved.
//

import UIKit

public typealias KWOTableViewDataSourceCellConfigurationBlock = (_ cell: UITableViewCell, _ object: AnyObject) -> Void

open class TableViewDataSource: DataSource {

    open weak var tableView: UITableView!
    open var cellConfigurationBlock: KWOTableViewDataSourceCellConfigurationBlock?

    public convenience init(tableView: UITableView, sections: [[AnyObject]]) {
        self.init(tableView: tableView)
        self.sections = sections
    }

    public init(tableView: UITableView, items: [AnyObject]? = nil, cellReuseIdentifier: String? = nil, cellConfigurationBlock: KWOTableViewDataSourceCellConfigurationBlock? = nil) {
        self.tableView = tableView
        self.cellConfigurationBlock = cellConfigurationBlock
        super.init(items: items, cellReuseIdentifier: cellReuseIdentifier)
        self.tableView.dataSource = self
    }

    open func objectInCell(_ cell: UITableViewCell) -> AnyObject? {
        if let indexPath = self.tableView.indexPath(for: cell) {
            return self.sections[indexPath.section][indexPath.row]
        }

        return nil
    }

    open func selectedObject() -> AnyObject? {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            return self.sections[indexPath.section][indexPath.row]
        }

        return nil
    }

    open func reload() {
        self.tableView.reloadData()
    }
}

extension TableViewDataSource: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = self.sections[indexPath.section][indexPath.row]
        let reuseIdentifier = self.cellReuseIdentifier ?? Mirror.classNameForObject(object)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        self.cellConfigurationBlock!(cell, object)

        return cell
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionTitles.isEmpty ? nil : self.sectionTitles
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles.isEmpty ? nil : self.sectionTitles[section]
    }
}
