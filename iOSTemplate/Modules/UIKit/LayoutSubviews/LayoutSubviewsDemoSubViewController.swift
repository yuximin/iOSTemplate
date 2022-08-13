//
//  LayoutSubviewsDemoSubViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/13.
//

import UIKit

class LayoutSubviewsDemoSubViewController: UIViewController {

    let isAutoLayout: Bool
    
    // MARK: - view
    
    private lazy var blackView: LayoutSubviewsDemoView = {
        let view = LayoutSubviewsDemoView()
        view.name = "黑色"
        view.backgroundColor = .black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var blueView: LayoutSubviewsDemoView = {
        let view = LayoutSubviewsDemoView()
        view.name = "蓝色"
        view.backgroundColor = .blue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var yellowView: LayoutSubviewsDemoView = {
        let view = LayoutSubviewsDemoView()
        view.name = "黄色"
        view.backgroundColor = .yellow
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var redView: LayoutSubviewsDemoView = {
        let view = LayoutSubviewsDemoView()
        view.name = "红色"
        view.backgroundColor = .red
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        return view
    }()

    // MARK: - life cycle
    
    init(isAutoLayout: Bool) {
        self.isAutoLayout = isAutoLayout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(blackView)
        blackView.addSubview(blueView)
        blackView.addSubview(yellowView)
        blueView.addSubview(redView)
        
        if isAutoLayout {
            blackView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.center.equalToSuperview()
                make.height.equalTo(blackView.snp.width)
            }
            
            blueView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(10)
                make.size.equalTo(CGSize(width: 150, height: 150))
            }
            
            yellowView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalTo(blueView.snp.trailing).offset(10)
                make.size.equalTo(CGSize(width: 100, height: 100))
            }
            
            redView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(10)
                make.size.equalTo(CGSize(width: 80, height: 80))
            }
        } else {
            blackView.frame = CGRect(x: 0, y: 100, width: 240, height: 240)
            blueView.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
            yellowView.frame = CGRect(x: 120, y: 10, width: 50, height: 50)
            redView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        }
        
    }
    
    // MARK: - action
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        guard let layoutSubviewsDemoView = sender.view as? LayoutSubviewsDemoView else {
            return
        }
        if isAutoLayout {
            switch layoutSubviewsDemoView.name {
            case "黑色":
                blackView.snp.remakeConstraints { make in
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.center.equalToSuperview()
                    make.height.equalTo(240)
                }
            case "蓝色":
                blueView.snp.remakeConstraints { make in
                    make.top.leading.equalToSuperview().inset(20)
                    make.size.equalTo(CGSize(width: 150, height: 150))
                }
            case "黄色":
                yellowView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().inset(10)
                    make.leading.equalTo(blueView.snp.trailing).offset(10)
                    make.size.equalTo(CGSize(width: 80, height: 80))
                }
            case "红色":
                redView.snp.remakeConstraints { make in
                    make.top.leading.equalToSuperview().inset(10)
                    make.size.equalTo(CGSize(width: 50, height: 50))
                }
            default:
                break
            }
        } else {
            switch layoutSubviewsDemoView.name {
            case "黑色":
                blackView.frame = CGRect(x: 0, y: 100, width: 250, height: 250)
            case "蓝色":
                blueView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
            case "黄色":
                yellowView.frame = CGRect(x: 120, y: 10, width: 100, height: 100)
            case "红色":
                redView.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
            default:
                break
            }
        }
    }

}
