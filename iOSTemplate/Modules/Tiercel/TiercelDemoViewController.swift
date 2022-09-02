//
//  TiercelDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/30.
//

import UIKit
import Tiercel

class TiercelDemoViewController: ListViewController {
    
//    let sessionManager = SessionManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "Base", rows: [
                ListRow(title: "Test")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension TiercelDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("Base", "Test"):
            baseTest()
        default:
            break
        }
    }
}

// MARK: - method
extension TiercelDemoViewController {
    
    func baseTest() {
//        sessionManager.download("https://dev-static.ohlaapp.cn/d/f77842c04b3f55af5579f888bf659375.pag")
    }
}
