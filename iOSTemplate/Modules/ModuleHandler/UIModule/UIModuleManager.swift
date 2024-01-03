//
//  UIModuleManager.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import UIKit

class UIModuleManager {
    
    var rootView: UIView? {
        self.rootViewController?.view
    }
    
    weak var rootViewController: UIViewController?
    
    private var moduleDict: [UIModuleType: UIModule] = [:]
    private var modules: [UIModule] = []
    
    // MARK: - Modules
    
    func register(module: UIModule.Type, containerView: UIView? = nil) {
        let moduleType = module.moduleType
        if moduleDict[moduleType] != nil {
#if DEBUG
            fatalError("[UIModuleManager] 重复注册: \(moduleType)")
#else
            return
#endif
        }
        
        let moduleInstance = module.init(moduleManager: self, containerView: containerView)
        self.moduleDict[moduleType] = moduleInstance
        self.modules.append(moduleInstance)
    }
    
    func unregister(module: UIModule.Type) {
        let moduleType = module.moduleType
        self.moduleDict[moduleType] = nil
        self.modules.removeAll { type(of: $0).moduleType == moduleType }
    }
    
    func module(of type: UIModuleType) -> UIModule? {
        return moduleDict[type]
    }
    
    // MARK: - View Lifecycle
    
    func viewDidLoad() {
        for module in modules {
            module.viewDidLoad()
        }
    }
    
    func viewWillAppear(_ animated: Bool) {
        for module in modules {
            module.viewWillAppear(animated)
        }
    }
    
    func viewIsAppearing(_ animated: Bool) {
        for module in modules {
            module.viewIsAppearing(animated)
        }
    }
    
    func viewWillLayoutSubviews() {
        for module in modules {
            module.viewWillLayoutSubviews()
        }
    }
    
    func viewDidLayoutSubviews() {
        for module in modules {
            module.viewDidLayoutSubviews()
        }
    }
    
    func viewDidAppear(_ animated: Bool) {
        for module in modules {
            module.viewDidAppear(animated)
        }
    }
    
    func viewWillDisappear(_ animated: Bool) {
        for module in modules {
            module.viewWillDisappear(animated)
        }
    }
    
    func viewDidDisappear(_ animated: Bool) {
        for module in modules {
            module.viewDidDisappear(animated)
        }
    }
}
