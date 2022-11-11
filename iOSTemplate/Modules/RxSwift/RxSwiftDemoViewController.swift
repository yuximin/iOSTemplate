//
//  RxSwiftDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/17.
//

import UIKit

class RxSwiftDemoViewController: ListViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "Demo", rows: [
                ListRow(title: "Demo1")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension RxSwiftDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("Demo", "Demo1"):
            let viewController = RxSwiftDemo1ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
