//
//  TBCustomTabBar.swift
//  iOSTemplate
//
//  Created by apple on 2023/10/9.
//

import UIKit

protocol TBCustomTabBarDelegate: AnyObject {
    func tabBar(_ tabBar: TBCustomTabBar, didSelectIndex index: Int)
}

class TBCustomTabBar: UIView {
    
    weak var delegate: TBCustomTabBarDelegate?
    
    var items: [TBCustomTabBarItem] = [] {
        didSet {
            self.updateItems()
        }
    }
    
    private var selectedButton: TBCustomButton?
    
    private func updateItems() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        let isRTL = UIView.userInterfaceLayoutDirection(for: UIView.appearance().semanticContentAttribute) == .rightToLeft
        let buttonWidth = (UIScreen.main.bounds.width - 2 * 2 - 4 * CGFloat(self.items.count - 1)) / CGFloat(self.items.count)
        for (index, item) in self.items.enumerated() {
            let buttonX = isRTL ? (UIScreen.main.bounds.width - 2 - CGFloat(index + 1) * (buttonWidth + 4)) : (2 + CGFloat(index) * (buttonWidth + 4))
            let button = TBCustomButton()
            button.frame = CGRect(x: buttonX, y: 1, width: buttonWidth, height: 48)
            button.tag = index
            button.item = item
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            self.addSubview(button)
            
            if index == 0 {
                self.didTapButton(button)
            }
        }
    }
    
    // MARK: - Action
    
    @objc private func didTapButton(_ sender: TBCustomButton) {
        self.selectedButton?.isSelected = false
        sender.isSelected = true
        self.selectedButton = sender
        self.delegate?.tabBar(self, didSelectIndex: sender.tag)
    }

}

// MARK: - interface
extension TBCustomTabBar {
    func showBadge(at index: Int) {
        for subview in self.subviews {
            if let button = subview as? TBCustomButton,
               button.tag == index {
                button.isBadgeHidden = false
                break
            }
        }
    }
    
    func hideBadge(at index: Int) {
        for subview in self.subviews {
            if let button = subview as? TBCustomButton,
               button.tag == index {
                button.isBadgeHidden = true
                break
            }
        }
    }
}
