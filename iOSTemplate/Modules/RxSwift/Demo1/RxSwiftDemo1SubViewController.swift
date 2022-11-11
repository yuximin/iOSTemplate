//
//  RxSwiftDemo1SubViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/17.
//

import UIKit

class RxSwiftDemo1SubViewController: UIViewController {
    
    weak var upperViewController: RxSwiftDemo1ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        if let upperViewController = upperViewController {
            upperViewController.addListener { number in
                print("RxSwiftDemo1SubViewController number listener: \(number)")
            }
        }
    }
    
    deinit {
        print("RxSwiftDemo1SubViewController deinit")
    }

}
