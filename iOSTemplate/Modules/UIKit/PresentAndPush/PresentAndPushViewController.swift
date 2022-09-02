//
//  PresentAndPushViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/19.
//

import UIKit

class PresentAndPushViewController: ListViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "基础", rows: [
                ListRow(title: "一次dismiss多个视图控制器")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension PresentAndPushViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("基础", "一次dismiss多个视图控制器"):
            let viewController = PresentViewController()
            viewController.content = "1111"
            present(viewController, animated: true) {
                let sViewController = PresentViewController()
                sViewController.content = "2222"
                viewController.present(sViewController, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        if self.presentedViewController != nil {
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        default:
            break
        }
    }
}
