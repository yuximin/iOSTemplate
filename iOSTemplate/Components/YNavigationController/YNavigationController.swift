//
//  YNavigationController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/7.
//

import UIKit

public protocol YNavigationBarStyleProtocol: AnyObject {
    
    var isNavigationBarHidden: Bool { get }
    
    var fullScreenPopEnable: Bool { get }
    
    var fullScreenPopMaxAllowedInitialDistanceToLeftEdge: CGFloat { get }
}

extension YNavigationBarStyleProtocol {
    
    var isNavigationBarHidden: Bool { false }
    
    var fullScreenPopEnable: Bool { true }
    
    var fullScreenPopMaxAllowedInitialDistanceToLeftEdge: CGFloat { 0 }
}

class YNavigationController: UINavigationController {
    
    private lazy var fullScreenPopGestureRecognizer: UIPanGestureRecognizer = {
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.delegate = self
        return panGestureRecognizer
    }()
    
    private var currentInteractiveTransitioning: UIViewControllerInteractiveTransitioning?
    
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
        
        self.addFullScreenPopGestureRecognizer()
    }
    
    
    private func addFullScreenPopGestureRecognizer() {
        
        guard let interactivePopGestureRecognizer = self.interactivePopGestureRecognizer,
              let interactivePopGestureRecognizerView = interactivePopGestureRecognizer.view else { return }
        
        let hasContains = interactivePopGestureRecognizerView.gestureRecognizers?.contains(self.fullScreenPopGestureRecognizer) ?? false
        
        guard !hasContains,
              let internalTargets = interactivePopGestureRecognizer.value(forKey: "targets") as? [NSObject],
              let internalTarget = internalTargets.first?.value(forKey: "target") else { return }
        
        interactivePopGestureRecognizerView.addGestureRecognizer(self.fullScreenPopGestureRecognizer)
        let internalAction = NSSelectorFromString("handleNavigationTransition:")
        self.fullScreenPopGestureRecognizer.addTarget(internalTarget, action: internalAction)
        
        interactivePopGestureRecognizer.isEnabled = false
    }
}

// MARK: - 自定义 popGestureRecognizer
extension YNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.viewControllers.count <= 1 { return false }
        
        if let yNavigationBarStyle = self.topViewController as? YNavigationBarStyleProtocol {
            
            if !yNavigationBarStyle.fullScreenPopEnable { return false }
            
            let beginningLocation = gestureRecognizer.location(in: gestureRecognizer.view)
            let maxAllowedInitialDistance = yNavigationBarStyle.fullScreenPopMaxAllowedInitialDistanceToLeftEdge
            if maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance {
                return false
            }
        }
        
        let isTransitioning = self.value(forKey: "_isTransitioning") as? Bool ?? false
        if isTransitioning { return false }
        
        let translation = (gestureRecognizer as? UIPanGestureRecognizer)?.translation(in: gestureRecognizer.view) ?? .zero
        let isRTL =  UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        let multiplier: CGFloat = isRTL ? -1 : 1
        if translation.x * multiplier <= 0 { return false }
        
        return true
    }
}

// MARK: - UINavigationControllerDelegate
extension YNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        switch operation {
        case .push:
            if let yViewControllerAnimatedTransitioning = toVC as? YViewControllerAnimatedTransitioning {
                self.currentInteractiveTransitioning = yViewControllerAnimatedTransitioning.y_interactiveTransitioning
                return yViewControllerAnimatedTransitioning.y_pushAnimatedTransitioning
            }
            
            self.currentInteractiveTransitioning = nil
            return nil
        case .pop:
            if let yViewControllerAnimatedTransitioning = fromVC as? YViewControllerAnimatedTransitioning {
                self.currentInteractiveTransitioning = yViewControllerAnimatedTransitioning.y_interactiveTransitioning
                return yViewControllerAnimatedTransitioning.y_popAnimatedTransitioning
            }
            
            self.currentInteractiveTransitioning = nil
            return nil
        default:
            self.currentInteractiveTransitioning = nil
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        return self.currentInteractiveTransitioning
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let viewController = viewController as? UIViewController & YNavigationBarStyleProtocol {
            viewController.navigationController?.navigationBar.isHidden = viewController.isNavigationBarHidden
        } else {
            viewController.navigationController?.navigationBar.isHidden = false
        }
    }
}

protocol YViewControllerAnimatedTransitioning {
    
    var y_interactiveTransitioning: UIPercentDrivenInteractiveTransition? { get }
    
    var y_pushAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { get }
    
    var y_popAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { get }
    
    var y_presentAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { get }
    
    var y_dismissAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { get }
}

extension YViewControllerAnimatedTransitioning {
    
    var y_interactiveTransitioning: UIPercentDrivenInteractiveTransition? { nil }
    
    var y_pushAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { nil }
    
    var y_popAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { nil }
    
    var y_presentAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { nil }
    
    var y_dismissAnimatedTransitioning: UIViewControllerAnimatedTransitioning? { nil }
}
