//
//  AnimationDemo1ViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/24.
//

import UIKit

class AnimationDemo1ViewController: UIViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let targetView = UIImageView()
        targetView.image = UIImage(named: "turntable")
        view.addSubview(targetView)
        targetView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        targetView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

}
