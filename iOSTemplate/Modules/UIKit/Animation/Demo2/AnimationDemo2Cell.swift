//
//  AnimationDemo2Cell.swift
//  iOSTemplate
//
//  Created by apple on 2023/3/10.
//

import UIKit

class AnimationDemo2Cell: UICollectionViewCell {
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("AnimationDemo2Cell init")
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("AnimationDemo2Cell deinit")
    }
    
    // MARK: - ui
    private func setupUI() {
        contentView.addSubview(rotationView)
        rotationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
    }
    
    // MARK: - view
    
    private(set) lazy var rotationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        let rotationAnimation = CustomBasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
//        rotationAnimation.delegate = self
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        if let animationKeys = view.layer.animationKeys() {
            print("addAnimation AnimationKeys:", animationKeys.joined(separator: ","))
        } else {
            print("addAnimation AnimationKeys: nil")
        }
        return view
    }()
}

// MARK: - CAAnimationDelegate
extension AnimationDemo2Cell: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        if let animationKeys = rotationView.layer.animationKeys() {
            print("animationDidStart AnimationKeys:", animationKeys.joined(separator: ","))
        } else {
            print("animationDidStart AnimationKeys: nil")
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationKeys = rotationView.layer.animationKeys() {
            print("animationDidStop AnimationKeys:", animationKeys.joined(separator: ","))
        } else {
            print("animationDidStop AnimationKeys: nil")
        }
        rotationView.layer.removeAnimation(forKey: "rotationAnimation")
    }
}

class CustomBasicAnimation: CABasicAnimation {
    
    deinit {
        print("CustomBasicAnimation deinit")
    }
}
