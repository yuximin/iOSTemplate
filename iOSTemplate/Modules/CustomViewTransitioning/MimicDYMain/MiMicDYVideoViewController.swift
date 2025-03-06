//
//  MiMicDYVideoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/4.
//

import UIKit

class MiMicDYVideoViewController: UIViewController, YViewControllerAnimatedTransitioning {
    
    var y_pushAnimatedTransitioning: UIViewControllerAnimatedTransitioning? = MiMicDYVideoViewControllerTransitionPushAnimator()
    
    var y_popAnimatedTransitioning: (any UIViewControllerAnimatedTransitioning)? = MiMicDYVideoViewControllerTransitionPopAnimator()
    
    
    private var panStartPoint: CGPoint = .zero
    var fromView: UIView?
    
    var viewFrame: CGRect = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        self.addPanGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewFrame = self.view.frame
    }
    
    private func addPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            let progressX = abs(translation.x / UIScreen.main.bounds.size.width)
            let progressY = abs(translation.y / UIScreen.main.bounds.size.height)
            let progress = max(progressX, progressY)
            let ratio = 1.0 - progress * 0.5
            gestureRecognizer.view?.transform = CGAffineTransformMakeScale(ratio, ratio)
            
            if var frame = gestureRecognizer.view?.frame {
                frame.origin.x = self.panStartPoint.x + translation.x - ratio * self.panStartPoint.x
                frame.origin.y = self.panStartPoint.y + translation.y - ratio * self.panStartPoint.y
                gestureRecognizer.view?.frame = frame
            }
//            gestureRecognizer.view?.frame = CGRect(x: self.panStartPoint.x + translation.x - ratio * self.panStartPoint.x,
//                                                   y: self.panStartPoint.y + translation.y - ratio * self.panStartPoint.y,
//                                                   width: self.viewFrame.size.width,
//                                                   height: self.viewFrame.size.height)
        case .ended, .cancelled:
            let progress = translation.x / UIScreen.main.bounds.size.width
            let velocity = gestureRecognizer.velocity(in: gestureRecognizer.view).x
            
            if velocity < -300 {
                self.cancelPop()
            } else if velocity > 300 {
                self.popViewController()
            } else if progress > 0.25 {
                self.popViewController()
            } else {
                self.cancelPop()
            }
        default:
            break
        }
    }
    
    private func cancelPop() {
        UIView.animate(withDuration: 0.3) {
            self.view.frame = self.viewFrame
            self.view.transform = .identity
        }
    }
    
    private func popViewController() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MiMicDYVideoViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        
        self.panStartPoint = gestureRecognizer.location(in: gestureRecognizer.view)
        
        let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view)
        if translation.x <= 0 {
            return false
        }
        
        return true
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension MiMicDYVideoViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        let animator = MiMicDYVideoViewControllerTransitionPushAnimator()
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        let animator = MiMicDYVideoViewControllerTransitionPopAnimator()
        return animator
    }
}
