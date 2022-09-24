//
//  AnimationDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/24.
//

import UIKit

class AnimationDemoViewController: ListViewController {
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "类型", rows: [
                ListRow(title: "无限旋转")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension AnimationDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("类型", "无限旋转"):
            let viewController = AnimationDemo1ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
