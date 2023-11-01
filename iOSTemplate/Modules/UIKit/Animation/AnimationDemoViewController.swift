//
//  AnimationDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/24.
//

import UIKit

class AnimationDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "类型", rowItems: [
                ListRowItem(title: "无限旋转", tapAction: { [weak self] in
                    let viewController = AnimationDemo1ViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "UICollectionView reload时cell中动画效果", tapAction: { [weak self] in
                    let viewController = AnimationDemo2ViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
