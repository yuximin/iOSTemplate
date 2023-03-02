//
//  PKProgressViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/23.
//

import UIKit

class PKProgressViewController: UIViewController {
    
    private var progress: Double = 0.5 {
        didSet {
            progressView.progress = progress
        }
    }

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(progressView)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(redAddButton)
        buttonsStackView.addArrangedSubview(blueAddButton)
        
        progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 332.0, height: 18.0))
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(15.0)
            make.centerX.equalToSuperview()
        }
        
        redAddButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120.0, height: 30.0))
        }
        
        blueAddButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120.0, height: 30.0))
        }
    }
    
    // MARK: - action
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        var value = progress
        if sender.tag == 0 {
            value -= 0.3
        } else if sender.tag == 1 {
            value += 0.3
        }
        progress = max(0.0, min(value, 1.0))
    }
    
    // MARK: - view
    
    private lazy var progressView: PKProgressView = {
        let view = PKProgressView()
        view.progress = progress
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var redAddButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.backgroundColor = .gray
        button.setTitle("红方加经验", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var blueAddButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.backgroundColor = .gray
        button.setTitle("红方加经验", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        return button
    }()

}
