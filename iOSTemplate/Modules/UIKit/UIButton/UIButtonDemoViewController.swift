//
//  UIButtonDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/3/12.
//

import UIKit

class UIButtonDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "UIButton", rowItems: [
                ListRowItem(title: "Float Button", tapAction: { [weak self] in
                    let viewController = FloatButtonDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
