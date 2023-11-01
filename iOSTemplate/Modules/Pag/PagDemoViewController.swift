//
//  PagDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/2.
//

import UIKit

class PagDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "Case",
                            rowItems: [
                                ListRowItem(title: "简单演示", tapAction: { [weak self] in
                                    let viewController = PagEasyPlayViewController()
                                    self?.navigationController?.pushViewController(viewController, animated: true)
                                }),
                                ListRowItem(title: "幸运转盘", tapAction: { [weak self] in
                                    let viewController = LuckyTurntableViewController()
                                    self?.navigationController?.pushViewController(viewController, animated: true)
                                }),
                                ListRowItem(title: "性能测试", tapAction: { [weak self] in
                                    let viewController = PagTestViewController()
                                    self?.navigationController?.pushViewController(viewController, animated: true)
                                }),
                                ListRowItem(title: "PAGImageViewList", tapAction: { [weak self] in
                                    let viewController = PagImageViewListViewController()
                                    self?.navigationController?.pushViewController(viewController, animated: true)
                                })
                            ])
        ]
    }

}
