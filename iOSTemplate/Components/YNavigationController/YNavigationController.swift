//
//  YNavigationController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/7.
//

import UIKit

public protocol YNavigationBarStyleProtocol: AnyObject {
    var isNavigationBarHidden: Bool { get }
}

class YNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
}

// MARK: - UINavigationControllerDelegate
extension YNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let viewController = viewController as? UIViewController & YNavigationBarStyleProtocol {
            viewController.navigationController?.navigationBar.isHidden = viewController.isNavigationBarHidden
        } else {
            viewController.navigationController?.navigationBar.isHidden = false
        }
    }
}
