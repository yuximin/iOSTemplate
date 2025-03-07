//
//  MimicDYCommentDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/7.
//

import UIKit

class MimicDYCommentDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let button = UIButton()
        button.setTitle("打开评论区", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapCommentButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func didTapCommentButton(_ sender: UIButton) {
        let view = MimicDYCommentView()
        view.show(at: self.view)
    }

}
