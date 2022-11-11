//
//  RxSwiftDemo1ViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/17.
//

import UIKit
import RxSwift
import RxRelay

class RxSwiftDemo1ViewController: UIViewController {
    
    private let numberBehaviorRelay = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()
    
    private var timer: Timer?

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("RxSwiftDemo1ViewController viewDidLoad")

        setupUI()
        startTimer()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let button = UIButton()
        button.frame = CGRect(origin: CGPoint(x: view.center.x - 50.0, y: view.center.y - 20.0), size: CGSize(width: 100.0, height: 40.0))
        button.setTitle("跳转", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func didTapButton() {
        let viewController = RxSwiftDemo1SubViewController()
        viewController.upperViewController = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - method
    
    public func addListener(_ listener: @escaping (Int) -> Void) {
        let temp = numberBehaviorRelay.subscribe { event in
            listener(event)
        }
        temp.disposed(by: disposeBag)
    }
    
    // MARK: - timer
    
    private func startTimer() {
        if timer != nil {
            return
        }
        
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
    
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerAction() {
        let number = numberBehaviorRelay.value + 1
        print("计时器: \(number)")
        numberBehaviorRelay.accept(number)
    }

}
