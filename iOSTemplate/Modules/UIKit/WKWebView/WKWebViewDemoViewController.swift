//
//  WKWebViewDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/28.
//

import UIKit

class WKWebViewDemoViewController: ListViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            ListSection(title: "基础", rows: [
                ListRow(title: "WebView与原生交互")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension WKWebViewDemoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("基础", "WebView与原生交互"):
            let viewController = WKWebViewDemo1ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
