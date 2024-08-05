//
//  LanguageSettingViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit

class LanguageSettingViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "请选择", rowItems: [
                ListRowItem(title: "中文简体", tapAction: {
                    LanguageContext.appLanguage = .zh
                }),
                ListRowItem(title: "English", tapAction: {
                    LanguageContext.appLanguage = .en
                }),
                ListRowItem(title: "بالعربية", tapAction: {
                    LanguageContext.appLanguage = .ar
                })
            ])
        ]
    }

}
