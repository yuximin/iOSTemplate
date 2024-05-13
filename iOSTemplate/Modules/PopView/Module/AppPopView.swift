//
//  AppPopView.swift
//  iOSTemplate
//
//  Created by apple on 2024/4/10.
//

import UIKit

public protocol AppPopViewProtocol where Self: UIView {
    
    var priority: AppPopViewPriority { get }
    
    func show()
}

extension AppPopViewProtocol {
    var priority: AppPopViewPriority { .normal }
    
    func show() {
        UIApplication.shared.addPopView(self)
    }
}

public struct AppPopViewPriority: Comparable {
    
    let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static func < (lhs: AppPopViewPriority, rhs: AppPopViewPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    public static func == (lhs: AppPopViewPriority, rhs: AppPopViewPriority) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    public static let normal: AppPopViewPriority = .init(rawValue: 750)
    
    public static let high: AppPopViewPriority = .init(rawValue: 1000)
    
    public static let low: AppPopViewPriority = .init(rawValue: 250)
    
}
