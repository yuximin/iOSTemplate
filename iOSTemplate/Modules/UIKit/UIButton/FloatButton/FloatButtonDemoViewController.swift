//
//  FloatButtonDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/3/12.
//

import UIKit

class FloatButtonDemoViewController: UIViewController {
    
    private var isDraging: Bool = false
    private var dragPoint: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    @objc private func handleTapGesture(_ tapGesture: UITapGestureRecognizer) {
        print("whaley log -- handleTapGesture")
    }
    
    @objc private func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        print("whaley log -- handlePanGesture:", panGesture.state.rawValue)
        guard let targetView = panGesture.view,
              targetView == self.button else { return }
        
        switch panGesture.state {
        case .began:
            print("whaley log -- handlePanGesture - began")
            let currentPoint = panGesture.translation(in: self.view)
            self.dragPoint = currentPoint
        case .changed:
            print("whaley log -- handlePanGesture - changed")
            guard let dragPoint = self.dragPoint else { break }
            let currentPoint = panGesture.translation(in: self.view)
            let targetPoint = panGesture.translation(in: panGesture.view)
            
            let halfWidth = targetView.bounds.width / 2.0
            let halfHeight = targetView.bounds.height / 2.0
            print("whaley log -- currentPoint:", currentPoint, halfWidth, halfHeight, self.view.bounds)
            print("whaley log -- targetPoint:", targetPoint)
            guard currentPoint.x >= halfWidth,
                  currentPoint.x <= self.view.bounds.width - halfWidth,
                  currentPoint.y >= halfHeight,
                  currentPoint.y <= self.view.bounds.height - halfHeight else {
                break
            }
            
            self.button.center = currentPoint
        case .ended, .cancelled, .failed:
            print("whaley log -- handlePanGesture - ended")
            self.dragPoint = nil
        default:
            break
        }
        
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        button.addGestureRecognizer(tap)
        pan.require(toFail: tap)
        button.addGestureRecognizer(pan)
        return button
    }()
}
