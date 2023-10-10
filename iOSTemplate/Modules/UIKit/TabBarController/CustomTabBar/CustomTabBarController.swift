//
//  CustomTabBarController.swift
//  iOSTemplate
//
//  Created by apple on 2023/10/9.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    enum TabBarItem {
        case explore
        case party
        case moment
        case message
        case me
        
        var title: String {
            switch self {
            case .explore:
                return "Explore"
            case .party:
                return "Party"
            case .moment:
                return "Moments"
            case .message:
                return "Message"
            case .me:
                return "My"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .explore:
                return UIImage(named: "tab_bar_item_explore")
            case .party:
                return UIImage(named: "tab_bar_item_party")
            case .moment:
                return UIImage(named: "tab_bar_item_moment")
            case .message:
                return UIImage(named: "tab_bar_item_message")
            case .me:
                return UIImage(named: "tab_bar_item_me")
            }
        }
        
        var animationFile: String {
            switch self {
            case .explore:
                return "tab_bar_animation_explore"
            case .party:
                return "tab_bar_animation_party"
            case .moment:
                return "tab_bar_animation_moment"
            case .message:
                return "tab_bar_animation_message"
            case .me:
                return "tab_bar_animation_me"
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .explore:
                return .white
            case .party:
                return .gray
            case .moment:
                return .systemPink
            case .message:
                return .yellow
            case .me:
                return .blue
            }
        }
    }
    
    var items: [TabBarItem] = [.explore, .party, .moment, .message, .me]
    
    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.hidesBottomBarWhenPushed = true
        self.setupChildControllers()
        self.setupTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.myTabBar.frame = self.tabBar.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for subview in self.tabBar.subviews {
            if subview.isKind(of: UIControl.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.myTabBar.showBadge(at: 3)
    }
    
    // MARK: - ui
    
    private func setupChildControllers() {
        for item in items {
            let viewController = UIViewController()
            viewController.view.backgroundColor = item.backgroundColor
            viewController.navigationItem.title = item.title
            viewController.tabBarItem = UITabBarItem(title: item.title, image: nil, selectedImage: nil)
            addChild(viewController)
        }
    }
    
    private func setupTabBar() {
        self.tabBar.addSubview(self.myTabBar)
        self.myTabBar.items = self.items.map({ TBCustomTabBarItem(title: $0.title, image: $0.image, animationFile: $0.animationFile) })
        self.tabBar(self.myTabBar, didSelectIndex: 0)
    }
    
    // MARK: - view
    
    private lazy var myTabBar: TBCustomTabBar = {
        let tabBar = TBCustomTabBar()
        tabBar.delegate = self
        return tabBar
    }()
}

// MARK: - TBCustomTabBarDelegate
extension CustomTabBarController: TBCustomTabBarDelegate {
    func tabBar(_ tabBar: TBCustomTabBar, didSelectIndex index: Int) {
        self.selectedIndex = index
    }
}
