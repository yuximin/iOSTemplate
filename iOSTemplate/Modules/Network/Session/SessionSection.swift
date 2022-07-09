//
//  SessionSection.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import Foundation

enum SessionSection: CaseIterable {
    case primary
    
    var title: String {
        switch self {
        case .primary:
            return "初级"
        }
    }
    
    var rows: [SessionRow] {
        switch self {
        case .primary:
            return [.simple]
        }
    }
}

enum SessionRow {
    case simple
    
    var title: String {
        switch self {
        case .simple:
            return "简单使用"
        }
    }
}
