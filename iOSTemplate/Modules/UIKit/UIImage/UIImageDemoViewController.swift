//
//  UIImageDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/4.
//

import UIKit
import SDWebImage

class UIImageDemoViewController: ListViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
    
    override func updateSectionItems() {
        sectionItems = [
            ListSectionItem(title: "基础", rowItems: [
                ListRowItem(title: "图片翻转", tapAction: { [weak self] in
                    let viewController = UIImageOrientationViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "图片水印", tapAction: { [weak self] in
                    let viewController = ImageWaterMarkViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
