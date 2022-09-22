//
//  UIStackViewDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/22.
//

import UIKit

class UIStackViewDemoViewController: UIViewController {
    
    // MARK: - view
    
    weak var showView1: UIView?
    weak var showView2: UIView?
    
    private lazy var show1Button: UIButton = {
        let button = UIButton()
        button.setTitle("添加1视图", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapShow1(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var hide1Button: UIButton = {
        let button = UIButton()
        button.setTitle("删除1视图", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapHide1(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var show2Button: UIButton = {
        let button = UIButton()
        button.setTitle("添加2视图", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapShow2(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var hide2Button: UIButton = {
        let button = UIButton()
        button.setTitle("删除2视图", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapHide2(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 15.0
        stackView.backgroundColor = .red.withAlphaComponent(0.5)
        return stackView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(show1Button)
        view.addSubview(hide1Button)
        view.addSubview(show2Button)
        view.addSubview(hide2Button)
        
        show1Button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80.0)
            make.leading.equalToSuperview().offset(10.0)
        }
        
        hide1Button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80.0)
            make.leading.equalTo(show1Button.snp.trailing).offset(10.0)
        }
        
        show2Button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80.0)
            make.leading.equalTo(hide1Button.snp.trailing).offset(10.0)
        }
        
        hide2Button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80.0)
            make.leading.equalTo(show2Button.snp.trailing).offset(10.0)
        }
    }
    
    // MARK: - action
    
    @objc private func didTapShow1(_ sender: UIButton) {
        guard showView1 == nil else {
            return
        }
        
        let showView = UIStackViewDemoView()
        showView.backgroundColor = .red
        stackView.addArrangedSubview(showView)
        showView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30.0, height: 30.0))
        }
        self.showView1 = showView
    }
    
    @objc private func didTapShow2(_ sender: UIButton) {
        guard showView2 == nil else {
            return
        }
        
        let showView = UIStackViewDemoView()
        showView.backgroundColor = .black
        stackView.addArrangedSubview(showView)
        showView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        self.showView2 = showView
    }
    
    @objc private func didTapHide1(_ sender: UIButton) {
        guard let showView = showView1 else {
            return
        }
        
        showView.removeFromSuperview()
    }
    
    @objc private func didTapHide2(_ sender: UIButton) {
        guard let showView = showView2 else {
            return
        }
        
        showView.removeFromSuperview()
    }

}
