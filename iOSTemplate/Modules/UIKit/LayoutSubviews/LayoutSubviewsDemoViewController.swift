//
//  LayoutSubviewsDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/13.
//

import UIKit

class LayoutSubviewsDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "布局方式", rowItems: [
                ListRowItem(title: "手动布局", tapAction: { [weak self] in
                    let viewController = LayoutSubviewsDemoSubViewController(isAutoLayout: false)
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "自动布局", tapAction: { [weak self] in
                    let viewController = LayoutSubviewsDemoSubViewController(isAutoLayout: true)
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
