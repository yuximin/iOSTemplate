//
//  SessionViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import UIKit

class SessionViewController: ListViewController {
    
    let viewModel = SessionViewModel()
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "初级", rowItems: [
                ListRowItem(title: "dataTask", tapAction: { [weak self] in
                    self?.viewModel.loadJson()
                }),
                ListRowItem(title: "dataTaskWithRequest", tapAction: { [weak self] in
                    self?.viewModel.loadJsonWithRequest()
                }),
                ListRowItem(title: "Custom Session", tapAction: { [weak self] in
                    self?.viewModel.loadJsonWithCustomSession()
                })
            ]),
            ListSectionItem(title: "Tasks", rowItems: [
                ListRowItem(title: "downloadTask", tapAction: { [weak self] in
                    self?.viewModel.downloadTask()
                })
            ])
        ]
    }

}
