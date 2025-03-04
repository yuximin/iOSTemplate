//
//  MiMicDYMainViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/2/28.
//

import UIKit

class MiMicDYMainViewController: UIViewController {
    
    private var navigationDelegateHandler: MimicDYNavigationDelegateHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let panGesture = UIPanGestureRecognizer(target: MimicDYInteractiveTransition.shared, action: #selector(MimicDYInteractiveTransition.handlePanGesture(_:)))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
        
        MimicDYInteractiveTransition.shared.navigationController = self.navigationController
        
        if let navigationController = self.navigationController {
            self.navigationDelegateHandler = MimicDYNavigationDelegateHandler()
            navigationController.delegate = self.navigationDelegateHandler
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
