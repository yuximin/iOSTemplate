//
//  GradientViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/7/20.
//

import UIKit

class GradientViewController: UIViewController {

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.view.addSubview(shinyLabel)
        shinyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10.0)
            make.trailing.lessThanOrEqualToSuperview().offset(-10.0)
        }
        
        self.view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(shinyLabel.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - action
    
    @objc private func didTapAction() {
        if shinyLabel.isAnimating {
//            shinyLabel.stopAnimation()
            shinyLabel.text = "雪中悍刀行😄雪中悍刀行😄雪中悍刀行😄雪中悍刀行😄"
        } else {
            shinyLabel.startAnimation(textColor: UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0), shinyColor: UIColor(red: 56.0/255.0, green: 158.0/255.0, blue: 40.0/255.0, alpha: 1.0))
        }
    }
    
    // MARK: - view
    
    private lazy var shinyLabel: ShinyLabel = {
        let label = ShinyLabel()
        label.text = "雪中悍刀行😄"
        label.textColor = .black
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("开始/停止动效", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        return button
    }()
}
