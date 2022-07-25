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
                ListRow(title: "dataTask"),
                ListRow(title: "dataTaskWithRequest"),
                ListRow(title: "Custom Session")
            ]),
            ListSection(title: "Tasks", rows: [
                ListRow(title: "downloadTask")
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
        case ("初级", "dataTask"):
            viewModel.loadJson()
        case ("初级", "dataTaskWithRequest"):
            viewModel.loadJsonWithRequest()
        case ("初级", "Custom Session"):
            viewModel.loadJsonWithCustomSession()
        case ("Tasks", "downloadTask"):
            viewModel.downloadTask()
        default:
            break
        }
    }
}
