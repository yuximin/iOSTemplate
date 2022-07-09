//
//  OperationSection.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import Foundation

enum OperationSection: CaseIterable {
    case primary
    case practical
    
    var title: String? {
        switch self {
        case .primary:
            return "初级"
        case .practical:
            return "实操"
        }
    }
    
    var rows: [OperationRow] {
        switch self {
        case .primary:
            return [.simple, .maxCount, .barrier, .dependency, .customOperation]
        case .practical:
            return [.downloader]
        }
    }
}

enum OperationRow {
    case simple
    case maxCount
    case barrier
    case dependency
    case customOperation
    
    case downloader
    
    var title: String {
        switch self {
        case .simple:
            return "简单使用"
        case .maxCount:
            return "最大并发数"
        case .barrier:
            return "栅栏"
        case .dependency:
            return "依赖"
        case .customOperation:
            return "自定义 Operation"
        case .downloader:
            return "下载器"
        }
    }
}
