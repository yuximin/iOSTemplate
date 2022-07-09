//
//  SessionViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import UIKit

class SessionViewController: UITableViewController {
    
    let viewModel = SessionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

}

// MARK: - UITableViewDelegate
extension SessionViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowItem = viewModel.sections[indexPath.section].rows[indexPath.row]
        switch rowItem {
        case .simple:
            Logger.info("simple")
        }
    }
}

// MARK: - UITableViewDataSource
extension SessionViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let rowItem = viewModel.sections[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = rowItem.title
        return cell
    }
}
