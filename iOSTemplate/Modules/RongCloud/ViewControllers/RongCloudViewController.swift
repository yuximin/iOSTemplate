//
//  RongCloudViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/23.
//

import UIKit
import RongIMKit

class RongCloudViewController: UIViewController {
    
    private let buttonTitles: [String] = ["登录账号1", "登录账号2", "1发送消息给2", "2发送消息给1", "进入消息列表"]
    
    private let viewModel = RongCloudViewModel()
    
    // MARK: - view
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10.0
        return stackView
    }()
    
    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20.0)
            make.centerX.equalToSuperview()
        }
        
        for (index, buttonTitle) in buttonTitles.enumerated() {
            let button = createButton(tag: index, title: buttonTitle)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(tag: Int, title: String) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 120.0, height: 30.0)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - action
    
    @objc private func didTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            loginUser1()
        case 1:
            loginUser2()
        case 2:
            sendMessageToUser2()
        case 3:
            sendMessageToUser1()
        case 4:
            pushToConversationList()
        default:
            break
        }
    }
    
    // MARK: - method
    
    private func loginUser1() {
        viewModel.connectUser1 { _ in
            
        } completion: { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case let .success(userId):
                DispatchQueue.main.async { [weak sSelf] in
                    sSelf?.tipsLabel.text = "当前登录账号 \(userId ?? "")"
                }
            case .failure:
                break
            }
        }

    }
    
    private func loginUser2() {
        viewModel.connectUser2  { _ in
            
        } completion: { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case let .success(userId):
                DispatchQueue.main.async { [weak sSelf] in
                    sSelf?.tipsLabel.text = "当前登录账号 \(userId ?? "")"
                }
            case .failure:
                break
            }
        }
    }
    
    private func sendMessageToUser2() {
        viewModel.sendMessage(content: "你好呀", toUser: "10000002")
    }
    
    private func sendMessageToUser1() {
        viewModel.sendMessage(content: "你好", toUser: "10000001")
    }
    
    private func pushToConversationList() {
        let displayConversationTypeArray = [RCConversationType.ConversationType_PRIVATE.rawValue]
        guard let conversationListVC = RCConversationListViewController(displayConversationTypes: displayConversationTypeArray,
                                                                        collectionConversationType: nil) else {
            return
        }
        
        navigationController?.pushViewController(conversationListVC, animated: true)
    }

}
