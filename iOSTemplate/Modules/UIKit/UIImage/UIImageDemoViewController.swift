//
//  UIImageDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/4.
//

import UIKit

class UIImageDemoViewController: ListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "基础", rows: [
                ListRow(title: "图片翻转")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension UIImageDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("基础", "图片翻转"):
            let viewController = UIImageOrientationViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
