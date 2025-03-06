//
//  MimicDYProfileViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/1.
//

import UIKit

class MimicDYProfileViewController: UIViewController, YViewControllerAnimatedTransitioning {
    
    var y_interactiveTransitioning: UIPercentDrivenInteractiveTransition? = UIPercentDrivenInteractiveTransition()
    
    var y_pushAnimatedTransitioning: (any UIViewControllerAnimatedTransitioning)? = MimicDYPanPushAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .gray
        
        self.navigationItem.title = "个人主页"
        
        self.view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        self.view.addSubview(orangeView)
        orangeView.snp.makeConstraints { make in
            make.top.equalTo(redView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    @objc private func didTapRedView(_ sender: UIView) {
        let videoVC = MiMicDYVideoViewController()
        videoVC.view.backgroundColor = .red
        videoVC.fromView = sender
        self.navigationController?.pushViewController(videoVC, animated: true)
    }
    
    @objc private func didTapOrangeView(_ sender: UIView) {
        let videoVC = MiMicDYVideoViewController()
        videoVC.modalPresentationStyle = .fullScreen
        videoVC.view.backgroundColor = .orange
        videoVC.fromView = sender
        self.present(videoVC, animated: true)
    }
    
    private lazy var redView: UIControl = {
        let view = UIControl()
        view.backgroundColor = .red
        view.addTarget(self, action: #selector(didTapRedView(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var orangeView: UIControl = {
        let view = UIControl()
        view.backgroundColor = .orange
        view.addTarget(self, action: #selector(didTapOrangeView(_:)), for: .touchUpInside)
        return view
    }()
}
