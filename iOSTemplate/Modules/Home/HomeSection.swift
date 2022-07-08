//
//  HomeSection.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import Foundation
import UIKit

enum HomeSection {
    case multiThread
    
    var title: String? {
        switch self {
        case .multiThread:
            return "多线程"
        }
    }
    
    var rows: [HomeRow] {
        switch self {
        case .multiThread:
            return [.gcd, .operation]
        }
    }
}

enum HomeRow {
    case gcd
    case operation
    
    var title: String {
        switch self {
        case .gcd:
            return "GCD"
        case .operation:
            return "Operation"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .gcd:
            return GCDViewController()
        case .operation:
            return OperationViewController()
        }
    }
}
