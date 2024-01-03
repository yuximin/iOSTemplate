//
//  BottomBarModule.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import UIKit

class BottomBarModule: UIBottomBarModule {
    
    weak var moduleManager: UIModuleManager?
    weak var containerView: UIView?
    
    static var moduleType: UIModuleType = .bottomBar
    
    required init(moduleManager: UIModuleManager, containerView: UIView?) {
        self.moduleManager = moduleManager
        self.containerView = containerView
    }
}
