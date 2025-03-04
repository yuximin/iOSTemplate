//
//  MimicDYInteractiveTransition.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/1.
//

import UIKit

class MimicDYInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    static let shared = MimicDYInteractiveTransition()
    
    weak var navigationController: UINavigationController?
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
        let progress = max(0, -translation.x / UIScreen.main.bounds.size.width)
        
        switch gesture.state {
        case .began:
            guard let navigationController = self.navigationController else { return }
            
            let profileVC = MimicDYProfileViewController()
            navigationController.pushViewController(profileVC, animated: true)
        case .changed:
            update(progress)
        case .cancelled, .ended:
            let velocity = gesture.velocity(in: gesture.view?.superview).x
            
            if velocity < -300 {
                finish()
            } else if progress <= 0.5 {
                cancel()
            } else {
                finish()
            }
        default:
            cancel()
        }
    }
}
