//
//  CollectionViewDemoController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/1.
//

import UIKit

class CollectionViewDemoController: ListViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "自定义", rows: [
                ListRow(title: "样式1")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension CollectionViewDemoController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("自定义", "样式1"):
            let viewController = CollectionViewStyle1ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
