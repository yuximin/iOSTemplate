//
//  TabBarDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/10/9.
//

import UIKit

class TabBarDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "示例", rowItems: [
                ListRowItem(title: "自定义TabBar", tapAction: { [weak self] in
                    let viewController = CustomTabBarController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
