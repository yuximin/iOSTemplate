//
//  WKWebViewDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/28.
//

import UIKit

class WKWebViewDemoViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "基础", rowItems: [
                ListRowItem(title: "WebView与原生交互", tapAction: { [weak self] in
                    let viewController = WKWebViewDemo1ViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }

}
