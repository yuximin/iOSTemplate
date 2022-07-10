//
//  ListViewController.swift
//  iOSTemplate
//
//  Created by whaley on 2022/7/10.
//

import UIKit

class ListViewController: UITableViewController {
    
    var sections: [ListSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
}

// MARK: - UITableViewDataSource
extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let rowItem = sections[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = rowItem.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}
