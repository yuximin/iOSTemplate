//
//  MiMicDYMainViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/2/28.
//

import UIKit

class MiMicDYMainViewController: UIViewController, YViewControllerAnimatedTransitioning {
    
    var y_interactiveTransitioning: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "首页"
        
        let label = UILabel()
        label.text = "左滑进入主页"
        label.textColor = .black
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.addFullScreenPanGestureRecognizer()
    }
    
    private func addFullScreenPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
        let progress = max(0, -translation.x / UIScreen.main.bounds.size.width)
        
        switch gesture.state {
        case .began:
            guard let navigationController = self.navigationController else { return }
            
            let profileVC = MimicDYProfileViewController()
            navigationController.pushViewController(profileVC, animated: true)
            self.y_interactiveTransitioning = profileVC.y_interactiveTransitioning
        case .changed:
            self.y_interactiveTransitioning?.update(progress)
        case .cancelled, .ended:
            let velocity = gesture.velocity(in: gesture.view?.superview).x
            
            if velocity < -300 {
                self.y_interactiveTransitioning?.finish()
            } else if progress <= 0.5 {
                self.y_interactiveTransitioning?.cancel()
            } else {
                self.y_interactiveTransitioning?.finish()
            }
        default:
            self.y_interactiveTransitioning?.cancel()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MiMicDYMainViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let translation = (gestureRecognizer as? UIPanGestureRecognizer)?.translation(in: gestureRecognizer.view) ?? .zero
        let isRTL =  UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        let multiplier: CGFloat = isRTL ? -1 : 1
        if translation.x * multiplier >= 0 { return false }
        
        return true
    }
}
