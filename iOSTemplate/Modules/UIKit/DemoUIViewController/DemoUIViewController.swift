//
//  DemoUIViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/2.
//

import UIKit

class DemoUIViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DemoUIViewController viewDidLoad.")
        view.backgroundColor = .white
        addRightButton()
        setupUI()
        
        print("self.centerView.frame:", self.centerView.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DemoUIViewController viewWillAppear.")
        print("self.centerView.frame:", self.centerView.frame)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            super.viewIsAppearing(animated)
            
            print("DemoUIViewController viewIsAppearing.")
            print("self.centerView.frame:", self.centerView.frame)
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("DemoUIViewController viewWillLayoutSubviews.")
        print("self.centerView.frame:", self.centerView.frame)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("DemoUIViewController viewDidLayoutSubviews.")
        print("self.centerView.frame:", self.centerView.frame)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("DemoUIViewController viewDidAppear.")
        print("self.centerView.frame:", self.centerView.frame)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("DemoUIViewController viewWillDisappear.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("DemoUIViewController viewDidDisappear.")
    }
    
    // MARK: - Private
    
    private func addRightButton() {
        let button = UIButton()
        button.setTitle("下一页", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapRightButton(_:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func didTapRightButton(_ sender: UIButton) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var centerView: UIView = {
        let centerView = UIView()
        centerView.backgroundColor = .green
        return centerView
    }()
}
