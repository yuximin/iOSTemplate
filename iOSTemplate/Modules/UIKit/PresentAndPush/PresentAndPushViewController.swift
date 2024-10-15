//
//  PresentAndPushViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/19.
//

import UIKit
/// present 和 push 测试
/// 结论：UINavigationController 和 UITabBarController 都相当于一个容器，无论他们之间怎么嵌套，处于其中的任意视图控制器，模态出来的新的视图控制器都是基于最外层的这个容器弹出的。
/// 在上面的基础上，当模态出一个新的视图控制器之后，基于这个新的视图控制器继续模态其他视图控制器的话，其他视图控制器就是基于这个新的视图控制器弹出的。
/// 若模态出来的其他控制器是UINavigationController 或 UITabBarController，同样遵循上面的规则。
class PresentAndPushViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "基础", rowItems: [
                ListRowItem(title: "一次dismiss多个视图控制器", tapAction: { [weak self] in
                    let viewController = PresentViewController()
                    viewController.content = "1111"
                    self?.present(viewController, animated: true) {
                        let sViewController = PresentViewController()
                        sViewController.content = "2222"
                        viewController.present(sViewController, animated: true) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if self?.presentedViewController != nil {
                                    self?.dismiss(animated: true)
                                }
                            }
                        }
                    }
                }),
                ListRowItem(title: "push-present-push", tapAction: { [weak self] in
                    let pushViewController = PushViewController()
                    let navigationController = UINavigationController(rootViewController: pushViewController)
                    let tabBarController = UITabBarController()
                    tabBarController.addChild(navigationController)
                    self?.navigationController?.pushViewController(tabBarController, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        print("whaley log -- present action")
                        let presentVC = PresentViewController()
                        presentVC.content = "presentVC"
                        pushViewController.present(presentVC, animated: true)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            print("pushViewController.tabBarController:", pushViewController.tabBarController)
                            print("pushViewController.navigationController:", pushViewController.navigationController)
                            print("self.navigationController:", self?.navigationController)
                            print("pushViewController:", pushViewController)
                            print("presentVC:", presentVC)
                            print("presentVC.presentingViewController:", presentVC.presentingViewController)
                            print("presentVC.presentationController:", presentVC.presentationController)
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        print("whaley log -- push action")
                        let pushViewController1 = PushViewController()
                        pushViewController.navigationController?.pushViewController(pushViewController1, animated: true)
                    }
                }),
                ListRowItem(title: "push-present-pop", tapAction: { [weak self] in
                    let pushViewController = PushViewController()
                    self?.navigationController?.pushViewController(pushViewController, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        print("whaley log -- present action")
                        let presentVC = PresentViewController()
                        presentVC.content = "presentVC"
                        pushViewController.present(presentVC, animated: true)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        print("whaley log -- pop action")
                        pushViewController.navigationController?.popViewController(animated: true)
                    }
                }),
                ListRowItem(title: "push-present-pop&dismiss", tapAction: { [weak self] in
                    let pushViewController = PushViewController()
                    self?.navigationController?.pushViewController(pushViewController, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        print("whaley log -- present action")
                        let presentVC = PresentViewController()
                        presentVC.content = "presentVC"
                        pushViewController.present(presentVC, animated: true)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        print("whaley log -- pop action")
                        pushViewController.navigationController?.popViewController(animated: true)
                        pushViewController.navigationController?.dismiss(animated: true)
                    }
                }),
                ListRowItem(title: "push-present-present-pop&dismiss", tapAction: { [weak self] in
                    let pushViewController = PushViewController()
                    self?.navigationController?.pushViewController(pushViewController, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        print("whaley log -- present action")
                        let presentVC = PresentViewController()
                        presentVC.content = "presentVC"
                        pushViewController.present(presentVC, animated: true)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            print("whaley log -- present1 action")
                            let present1VC = PresentViewController()
                            present1VC.content = "present1VC"
                            presentVC.present(present1VC, animated: true)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                print("presentVC:", presentVC)
                                print("present1VC:", present1VC)
                                print("presentVC.presentingViewController:", presentVC.presentingViewController)
                                print("present1VC.presentingViewController:", present1VC.presentingViewController)
                            }
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        print("whaley log -- pop action")
                        pushViewController.navigationController?.popViewController(animated: true)
                        pushViewController.navigationController?.dismiss(animated: true)
                    }
                })
            ])
        ]
    }

}
