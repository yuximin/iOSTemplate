//
//  RxSwiftDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/17.
//

import UIKit

class RxSwiftDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "Demo",
                            rowItems: [
                                ListRowItem(title: "Demo1", tapAction: { [weak self] in
                                    let viewController = RxSwiftDemo1ViewController()
                                    self?.navigationController?.pushViewController(viewController, animated: true)
                                })
                            ])
        ]
    }
    
}
