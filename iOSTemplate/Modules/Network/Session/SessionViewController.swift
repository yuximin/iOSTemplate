//
//  SessionViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import UIKit

class SessionViewController: ListViewController {
    
    let viewModel = SessionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            ListSection(title: "初级", rows: [
                ListRow(title: "simple")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension SessionViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("初级", "simple"):
            viewModel.requestJson()
        default:
            break
        }
    }
}
