//
//  SlotsNumberDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2025/7/23.
//

import UIKit

class SlotsNumberDemoViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(slotsNumberView)
        self.view.addSubview(startButton)
        
        slotsNumberView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(slotsNumberView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func didTapStart() {
        self.slotsNumberView.setNumber(899)
    }
    
    // MARK: - View
    
    private lazy var slotsNumberView: SlotsNumberView = {
        let imageResource = SlotsNumberImageResource(
            n0: UIImage(named: "scroll_number_num_0") ?? UIImage(),
            n1: UIImage(named: "scroll_number_num_1") ?? UIImage(),
            n2: UIImage(named: "scroll_number_num_2") ?? UIImage(),
            n3: UIImage(named: "scroll_number_num_3") ?? UIImage(),
            n4: UIImage(named: "scroll_number_num_4") ?? UIImage(),
            n5: UIImage(named: "scroll_number_num_5") ?? UIImage(),
            n6: UIImage(named: "scroll_number_num_6") ?? UIImage(),
            n7: UIImage(named: "scroll_number_num_7") ?? UIImage(),
            n8: UIImage(named: "scroll_number_num_8") ?? UIImage(),
            n9: UIImage(named: "scroll_number_num_9") ?? UIImage(),
            iconBackground: UIImage(named: "scroll_number_num_bg") ?? UIImage()
        )
        
        let view = SlotsNumberView(count: 8,
                                   itemSize: CGSize(width: 32, height: 38),
                                   numberSize: CGSize(width: 20, height: 25),
                                   itemSpacing: 3,
                                   imageResource: imageResource)
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("开始", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        return button
    }()
}
