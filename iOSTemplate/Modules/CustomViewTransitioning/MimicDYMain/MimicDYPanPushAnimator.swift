//
//  MimicDYPanPushAnimator.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/1.
//

import UIKit

// 自定义过渡动画类 - Push 动画
class MimicDYPanPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey:.to) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        toViewController.view.frame = finalFrame.offsetBy(dx: containerView.bounds.width, dy: 0)
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
