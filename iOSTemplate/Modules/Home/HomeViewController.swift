//
//  HomeViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/6.
//

import UIKit
import SnapKit

class HomeViewController: UITableViewController, YNavigationBarStyleProtocol {
    
    var isNavigationBarHidden: Bool {
        true
    }
    
    let viewModel = HomeViewModel()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

}

// MARK: - UITableViewDelegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowItem = viewModel.sections[indexPath.section].rows[indexPath.row]
        let viewController = rowItem.viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController {
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
