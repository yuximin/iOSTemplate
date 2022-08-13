//
//  LayoutSubviewsDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/13.
//

import UIKit

class LayoutSubviewsDemoViewController: ListViewController {
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "布局方式", rows: [
                ListRow(title: "手动布局"),
                ListRow(title: "自动布局")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension LayoutSubviewsDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("布局方式", "手动布局"):
            let viewController = LayoutSubviewsDemoSubViewController(isAutoLayout: false)
            navigationController?.pushViewController(viewController, animated: true)
        case ("布局方式", "自动布局"):
            let viewController = LayoutSubviewsDemoSubViewController(isAutoLayout: true)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
