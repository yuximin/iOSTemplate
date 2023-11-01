//
//  ListViewController.swift
//  iOSTemplate
//
//  Created by whaley on 2022/7/10.
//

import UIKit

class ListViewController: UITableViewController {
    
    var sectionItems: [ListSectionItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        updateSectionItems()
    }
    
    func updateSectionItems() {
        // 子类继承
    }
}

// MARK: - UITableViewDataSource
extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionItems.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionItems[section].rowItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let rowItem = sectionItems[indexPath.section].rowItems[indexPath.row]
        cell.textLabel?.text = rowItem.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionItems[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = self.sectionItems[indexPath.section]
        let rowItem = sectionItem.rowItems[indexPath.row]
        rowItem.tapAction?()
    }
}
