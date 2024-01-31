//
//  ModuleViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import UIKit
import SnapKit
import Kingfisher

class ModuleViewController: UIViewController {
    
    private let uiModuleManager = UIModuleManager()
    
    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.uiModuleManager.rootViewController = self
        registerModules()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ModuleViewController"
        self.setupUI()
        self.uiModuleManager.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.uiModuleManager.viewWillAppear(animated)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            super.viewIsAppearing(animated)
            self.uiModuleManager.viewIsAppearing(animated)
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.uiModuleManager.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.uiModuleManager.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.uiModuleManager.viewDidAppear(animated)
        
        let viewController = UIViewController()
        viewController.title = "Demo"
        viewController.view.backgroundColor = .gray
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        viewController.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTapView() {
        print("TopViewController:", UIApplication.shared.topViewController()?.title ?? "nil")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.uiModuleManager.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.uiModuleManager.viewDidDisappear(animated)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(playerView)
        view.addSubview(infoBarView)
        view.addSubview(operateBarView)
        view.addSubview(bottomBarView)
        
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(operateBarView.snp.leading)
            make.bottom.equalTo(bottomBarView.snp.top)
            make.height.equalTo(44)
        }
        
        operateBarView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomBarView.snp.top)
        }
        
        bottomBarView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Modules
    
    func registerModules() {
        self.uiModuleManager.register(module: PlayerModule.self, containerView: self.playerView)
        self.uiModuleManager.register(module: InfoBarModule.self, containerView: self.infoBarView)
        self.uiModuleManager.register(module: OperateBarModule.self, containerView: self.operateBarView)
        self.uiModuleManager.register(module: BottomBarModule.self, containerView: self.bottomBarView)
    }
    
    // MARK: - Lazy View
    
    private lazy var playerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private lazy var infoBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var operateBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
}

public extension UIApplication {
    
    func topViewController(isNeedRecurseChild: Bool = true, controller: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = controller as? UINavigationController {
            return topViewController(isNeedRecurseChild: isNeedRecurseChild, controller: nav.topViewController)
        } else if let tabBar = controller as? UITabBarController {
            return topViewController(isNeedRecurseChild: isNeedRecurseChild, controller: tabBar.selectedViewController)
        } else if let presented = controller?.presentedViewController {
            return topViewController(isNeedRecurseChild: isNeedRecurseChild, controller: presented)
        } else {
            if isNeedRecurseChild {
                let children = controller?.children ?? []
                if children.isEmpty {
                    return controller
                } else {
                    if let visibleChild = children.first(where: { $0.view.window != nil}) {
                        return topViewController(isNeedRecurseChild: isNeedRecurseChild, controller: visibleChild)
                    } else {
                        return controller
                    }
                }
            } else {
                return controller
            }
        }
    }
}
