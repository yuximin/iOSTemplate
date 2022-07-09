//
//  HomeSection.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import Foundation
import UIKit

enum HomeSection: CaseIterable {
    case multiThread
    case network
    
    var title: String? {
        switch self {
        case .multiThread:
            return "多线程"
        case .network:
            return "网络编程"
        }
    }
    
    var rows: [HomeRow] {
        switch self {
        case .multiThread:
            return [.gcd, .operation]
        case .network:
            return [.session]
        }
    }
}

enum HomeRow {
    case gcd
    case operation
    
    case session
    
    var title: String {
        switch self {
        case .gcd:
            return "GCD"
        case .operation:
            return "Operation"
        case .session:
            return "UISession"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .gcd:
            return GCDViewController()
        case .operation:
            return OperationViewController()
        case .session:
            return SessionViewController()
        }
    }
}
