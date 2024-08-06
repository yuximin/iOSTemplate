//
//  DemoScrollViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit

class DemoScrollViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "ScrollStackView", rowItems: [
                ListRowItem(title: "ScrollStackView", tapAction: { [weak self] in
                    let viewController = ScrollableStackViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
