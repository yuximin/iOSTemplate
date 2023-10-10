//
//  TabBarDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/10/9.
//

import UIKit

class TabBarDemoViewController: ListViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "示例", rows: [
                ListRow(title: "自定义TabBar")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension TabBarDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("示例", "自定义TabBar"):
            let viewController = CustomTabBarController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
