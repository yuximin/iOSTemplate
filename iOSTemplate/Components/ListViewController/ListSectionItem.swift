//
//  ListSectionItem.swift
//  iOSTemplate
//
//  Created by whaley on 2022/7/10.
//

import Foundation

struct ListSectionItem {
    let title: String
    let rowItems: [ListRowItem]
}

struct ListRowItem {
    let title: String
    var tapAction: (() -> Void)?
}
