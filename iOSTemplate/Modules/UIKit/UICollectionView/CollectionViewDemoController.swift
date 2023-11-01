//
//  CollectionViewDemoController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/1.
//

import UIKit

class CollectionViewDemoController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "自定义", rowItems: [
                ListRowItem(title: "样式1", tapAction: { [weak self] in
                    let viewController = CollectionViewStyle1ViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "进阶", rowItems: [
                ListRowItem(title: "Cell封装", tapAction: { [weak self] in
                    let viewController = CellPackageViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
