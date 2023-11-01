//
//  UIImageDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/4.
//

import UIKit

class UIImageDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        sectionItems = [
            ListSectionItem(title: "基础", rowItems: [
                ListRowItem(title: "图片翻转", tapAction: { [weak self] in
                    let viewController = UIImageOrientationViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
