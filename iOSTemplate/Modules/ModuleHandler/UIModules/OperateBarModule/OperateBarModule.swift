//
//  OperateBarModule.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import UIKit
import SnapKit

class OperateBarModule: UIOperateBarModule {
    
    weak var moduleManager: UIModuleManager?
    weak var containerView: UIView?
    
    static var moduleType: UIModuleType = .operateBar
    
    required init(moduleManager: UIModuleManager, containerView: UIView?) {
        self.moduleManager = moduleManager
        self.containerView = containerView
    }
    
    func viewDidLoad() {
        self.setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        guard let containerView = self.containerView else { return }
        
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(commentButton)
        stackView.addArrangedSubview(shareButton)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        commentButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        shareButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapCommentButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapShareButton(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - Action
extension OperateBarModule {
    @objc private func didTapCommentButton(_ sender: UIButton) {
        print("点击评论")
    }
    
    @objc private func didTapShareButton(_ sender: UIButton) {
        print("点击分享")
    }
}
