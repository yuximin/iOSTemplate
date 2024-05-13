//
//  PopViewDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/4/10.
//

import UIKit

protocol TipPopView: AppPopViewProtocol { }

extension TipPopView {
    var priority: AppPopViewPriority { .normal }
}

class PopViewDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let redView = AppPopView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        redView.priority = .low
        redView.backgroundColor = .red
        
        let blueView = AppPopView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        blueView.backgroundColor = .blue
        
        let yellowView = AppPopView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        yellowView.priority = .high
        yellowView.backgroundColor = .yellow
        
        yellowView.show()
        redView.show()
        blueView.show()
        
        let bView = BView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        bView.backgroundColor = .gray
        bView.show()
        print("bView:", bView.priority.rawValue)
    }

}

class BView: UIView, TipPopView { }

class AppPopView: UIView, AppPopViewProtocol {
    
    var priority: AppPopViewPriority = .normal
    
}
