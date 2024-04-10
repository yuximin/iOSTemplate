//
//  HeroDemoSubViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/4/10.
//

import UIKit
import Hero

class HeroDemoSubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.dismiss(animated: true)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(redView)
        self.view.addSubview(blackView)
        
        blackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.3)
            make.size.equalTo(CGSize(width: 280, height: 60))
        }
        
        redView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.hero.id = "batMan"
        return view
    }()
    
    private lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.hero.id = "ironMan"
        return view
    }()

}
