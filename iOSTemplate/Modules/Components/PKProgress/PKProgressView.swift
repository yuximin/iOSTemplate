//
//  PKProgressView.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/23.
//

import UIKit

class PKProgressView: UIView {
    
    var progress: Double = 0.5 {
        didSet {
            updateProgress()
        }
    }
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fillLayer.frame = bounds
        fillLayer.cornerRadius = bounds.height / 2.0
        fireImageView.center = CGPoint(x: bounds.width * progress, y: bounds.height / 2.0)
    }
    
    // MARK: - ui
    
    private func setupUI() {
        layer.addSublayer(fillLayer)
        addSubview(fireImageView)
    }
    
    private func updateProgress() {
        UIView.animate(withDuration: 0.2) {
            let value = NSNumber(value: self.progress)
            self.fillLayer.locations = [0.0, value, value, 1.0]
            self.fireImageView.center = CGPoint(x: self.bounds.width * self.progress, y: self.bounds.height / 2.0)
        }
    }

    // MARK: - view
    
    private lazy var fillLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.locations = [0.0, NSNumber(value: progress), NSNumber(value: progress), 1.0]
        layer.colors = ["#FE3B68".color.cgColor, "#FF5BBD".color.cgColor, "#36D6FF".color.cgColor, "#0094FF".color.cgColor]
        return layer
    }()
    
    private lazy var fireImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 22.0, height: 22.0)))
        imageView.image = UIImage(named: "components_pkProgress_fire")
        return imageView
    }()

}
