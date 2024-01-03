//
//  UIModule.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import Foundation
import UIKit

protocol UIModule {
    static var moduleType: UIModuleType { get }
    
    init(moduleManager: UIModuleManager, containerView: UIView?)
    
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewIsAppearing(_ animated: Bool)
    func viewWillLayoutSubviews()
    func viewDidLayoutSubviews()
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

extension UIModule {
    func viewDidLoad() {}
    func viewWillAppear(_ animated: Bool) {}
    func viewIsAppearing(_ animated: Bool) {}
    func viewWillLayoutSubviews() {}
    func viewDidLayoutSubviews() {}
    func viewDidAppear(_ animated: Bool) {}
    func viewWillDisappear(_ animated: Bool) {}
    func viewDidDisappear(_ animated: Bool) {}
}
