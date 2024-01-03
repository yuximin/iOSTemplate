//
//  InfoBarModule.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import UIKit

class InfoBarModule: UIOperateBarModule {
    
    weak var moduleManager: UIModuleManager?
    weak var containerView: UIView?
    
    static var moduleType: UIModuleType = .infoBar
    
    required init(moduleManager: UIModuleManager, containerView: UIView?) {
        self.moduleManager = moduleManager
        self.containerView = containerView
    }
}
