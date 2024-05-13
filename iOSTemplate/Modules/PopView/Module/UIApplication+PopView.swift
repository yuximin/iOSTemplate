//
//  UIApplication+PopView.swift
//  iOSTemplate
//
//  Created by apple on 2024/4/10.
//

import UIKit

public extension UIApplication {
    
    func addPopView(_ popView: AppPopViewProtocol) {
        guard let keyWindow = xKeyWindow else { return }
        
        if let targetView = keyWindow.subviews.compactMap({ $0 as? AppPopViewProtocol })
            .first(where: { $0.priority > popView.priority }) {
            keyWindow.insertSubview(popView, belowSubview: targetView)
        } else {
            keyWindow.addSubview(popView)
        }
    }
}

/// 获取当前 keyWindow
public var xKeyWindow: UIWindow? {
    if #available(iOS 15, *) {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    if #available(iOS 13, *) {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
    return UIApplication.shared.keyWindow
}
