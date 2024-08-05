//
//  SystemViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit

class SystemViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "System", rowItems: [
                ListRowItem(title: "设置语言", tapAction: { [weak self] in
                    let viewController = LanguageSettingViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
