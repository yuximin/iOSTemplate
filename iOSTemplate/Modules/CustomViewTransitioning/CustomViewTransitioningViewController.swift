//
//  HalfScreenAlertDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/2/28.
//

import UIKit

class CustomViewTransitioningViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "测试用例", rowItems: [
                ListRowItem(title: "仿抖音首页", tapAction: { [weak self] in
                    let viewController = MiMicDYMainViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "仿抖音评论区", tapAction: { [weak self] in
                    let viewController = MimicDYCommentDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
