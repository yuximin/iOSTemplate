//
//  ShinyLabel.swift
//  iOSTemplate
//
//  Created by apple on 2023/7/22.
//

import UIKit

class ShinyLabel: UIView {
    
    var text: String? {
        didSet {
            contentLabel.text = text
            shinyLabel?.text = text
        }
    }

    var textColor: UIColor = .white {
        didSet {
            contentLabel.textColor = textColor
        }
    }

    var font: UIFont = .systemFont(ofSize: 17) {
        didSet {
            contentLabel.font = font
        }
    }

    private(set) var isAnimating: Bool = false
    
    private let animationKey = "animation.key.shiny"
    
    private weak var shinyLabel: UILabel?
    private weak var shinyMaskLayer: CAGradientLayer?

    // MARK: - lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateAnimation()
    }

    private func setupUI() {
        addSubview(contentLabel)
        
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(contentLabel.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - view

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = self.text
        label.textColor = self.textColor
        label.font = self.font
        return label
    }()
}

// MARK: - interface
extension ShinyLabel {
    func startAnimation(textColor: UIColor, shinyColor: UIColor) {
        if self.isAnimating {
            self.contentLabel.textColor = textColor
            self.shinyLabel?.textColor = shinyColor
            return
        }
        self.isAnimating = true
        
        self.contentLabel.textColor = textColor
        
        let shinyLabel = UILabel()
        shinyLabel.text = self.text
        shinyLabel.textColor = shinyColor
        shinyLabel.font = self.font
        self.addSubview(shinyLabel)
        self.shinyLabel = shinyLabel
        
        let shinyMaskLayer = CAGradientLayer()
        shinyMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        shinyMaskLayer.locations = [0.0, 0.5, 1.0]
        shinyMaskLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shinyMaskLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(shinyMaskLayer)
        self.shinyMaskLayer = shinyMaskLayer
        
        shinyLabel.layer.mask = shinyMaskLayer
        
        self.updateAnimation()
    }
    
    func stopAnimation() {
        guard self.isAnimating else {
            return
        }
        self.isAnimating = false
        
        self.contentLabel.textColor = self.textColor
        self.shinyLabel?.removeFromSuperview()
        self.shinyMaskLayer?.removeAnimation(forKey: self.animationKey)
        self.shinyMaskLayer?.removeFromSuperlayer()
    }
    
    private func updateAnimation() {
        if self.shinyLabel?.frame == self.bounds {
            return
        }
        
        self.shinyLabel?.frame = self.bounds
        self.shinyMaskLayer?.frame = CGRect(origin: .zero, size: CGSize(width: self.bounds.width * 0.2, height: self.bounds.height))
        self.shinyMaskLayer?.removeAnimation(forKey: self.animationKey)
        if let shinyMaskLayer = self.shinyMaskLayer {
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = (self.bounds.width * 1.2) / 70.0
            animation.repeatCount = .infinity
            animation.fromValue = -self.bounds.width * 0.2
            animation.toValue = self.bounds.width
            animation.isRemovedOnCompletion = false
            shinyMaskLayer.add(animation, forKey: self.animationKey)
        }
    }
}
