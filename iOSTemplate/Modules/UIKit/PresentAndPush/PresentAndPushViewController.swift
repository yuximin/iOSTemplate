//
//  PresentAndPushViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/19.
//

import UIKit

class PresentAndPushViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "基础", rowItems: [
                ListRowItem(title: "一次dismiss多个视图控制器", tapAction: { [weak self] in
                    let viewController = PresentViewController()
                    viewController.content = "1111"
                    self?.present(viewController, animated: true) {
                        let sViewController = PresentViewController()
                        sViewController.content = "2222"
                        viewController.present(sViewController, animated: true) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if self?.presentedViewController != nil {
                                    self?.dismiss(animated: true)
                                }
                            }
                        }
                    }
                })
            ])
        ]
    }

}
