//
//  MiMicDYVideoViewControllerTransitionAnimator.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/4.
//

import UIKit

class MiMicDYVideoViewControllerTransitionPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        let fromView = (toViewController as? MiMicDYVideoViewController)?.fromView
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let initialFrame: CGRect
        if let fromView = (toViewController as? MiMicDYVideoViewController)?.fromView,
           let frame = fromView.superview?.convert(fromView.frame, to: toViewController.view) {
            initialFrame = frame
        } else {
            initialFrame = CGRect(x: finalFrame.size.width / 2.0, y: finalFrame.size.height / 2.0, width: 0, height: 0)
        }
        
        toViewController.view.center = CGPoint(x: initialFrame.origin.x + initialFrame.size.width / 2.0,
                                               y: initialFrame.origin.y + initialFrame.size.height / 2.0)
        toViewController.view.transform = CGAffineTransformMakeScale(initialFrame.size.width / finalFrame.size.width,
                                                                     initialFrame.size.height / finalFrame.size.height)
        toViewController.view.alpha = 0
        fromView?.alpha = 1
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            toViewController.view.center = CGPoint(x: finalFrame.origin.x + finalFrame.size.width / 2.0,
                                                   y: finalFrame.origin.y + finalFrame.size.height / 2.0)
            toViewController.view.transform = .identity
            toViewController.view.alpha = 1
            fromView?.alpha = 0
        } completion: { _ in
            
            DispatchQueue.main.async {
                containerView.insertSubview(fromViewController.view, belowSubview: toViewController.view)
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

class MiMicDYVideoViewControllerTransitionPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        let fromView = (fromViewController as? MiMicDYVideoViewController)?.fromView
        
        let initialFrame = transitionContext.finalFrame(for: toViewController)
        let finalFrame: CGRect
        if let fromView,
           let frame = fromView.superview?.convert(fromView.frame, to: toViewController.view) {
            finalFrame = frame
        } else {
            finalFrame = CGRect(x: initialFrame.size.width / 2.0, y: initialFrame.size.height / 2.0, width: 1, height: 1)
        }
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        fromViewController.view.alpha = 1
        fromView?.alpha = 0
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            fromViewController.view.center = CGPoint(x: finalFrame.origin.x + finalFrame.size.width / 2.0,
                                                   y: finalFrame.origin.y + finalFrame.size.height / 2.0)
            fromViewController.view.transform = CGAffineTransformMakeScale(finalFrame.size.width / initialFrame.size.width,
                                                                           finalFrame.size.height / initialFrame.size.height)
            fromViewController.view.alpha = 1
            fromView?.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
