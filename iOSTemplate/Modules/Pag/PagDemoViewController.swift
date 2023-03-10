//
//  PagDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/2.
//

import UIKit

class PagDemoViewController: ListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "Case", rows: [
                ListRow(title: "简单演示"),
                ListRow(title: "幸运转盘"),
                ListRow(title: "性能测试")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension PagDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("Case", "简单演示"):
            let viewController = PagEasyPlayViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case ("Case", "幸运转盘"):
            let viewController = LuckyTurntableViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case ("Case", "性能测试"):
            let viewController = PagTestViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
