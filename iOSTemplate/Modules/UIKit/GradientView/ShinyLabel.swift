//
//  ShinyLabel.swift
//  iOSTemplate
//
//  Created by apple on 2023/7/22.
//

import UIKit

public class ShinyLabel: UIView {
    
    public var text: String? {
        didSet {
            self.contentLabel.text = text
            self.shinyLabel?.text = text
        }
    }
    
    public var attributedText: NSAttributedString? {
        didSet {
            self.contentLabel.attributedText = attributedText
            self.shinyLabel?.attributedText = attributedText
        }
    }
    
    public var textColor: UIColor = UIColor.black {
        didSet {
            self.contentLabel.textColor = textColor
        }
    }

    public var font: UIFont = UIFont.systemFont(ofSize: 16.0) {
        didSet {
            self.contentLabel.font = font
            self.shinyLabel?.font = font
        }
    }

    public var textAlignment: NSTextAlignment = .natural {
        didSet {
            self.contentLabel.textAlignment = textAlignment
            self.shinyLabel?.textAlignment = textAlignment
        }
    }

    public var adjustsFontSizeToFitWidth: Bool = false {
        didSet {
            self.contentLabel.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            self.shinyLabel?.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }
    }

    private(set) var isAnimating: Bool = false
    
    private let animationKey = "animation.key.shiny"
    
    private var shinyLabel: UILabel?
    private var shinyMaskLayer: CAGradientLayer?

    // MARK: - lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    public override func layoutSubviews() {
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
        if let attributedText = self.attributedText {
            label.attributedText = self.attributedText
        } else {
            label.text = self.text
        }
        label.textColor = self.textColor
        label.font = self.font
        label.textAlignment = self.textAlignment
        label.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
        return label
    }()
}

// MARK: - interface
extension ShinyLabel {
    public func startAnimation(textColor: UIColor, shinyColor: UIColor) {
        if self.isAnimating {
            self.contentLabel.textColor = textColor
            self.shinyLabel?.textColor = shinyColor
            return
        }
        self.isAnimating = true
        
        self.contentLabel.textColor = textColor
        
        let shinyLabel = UILabel()
        if let attributedText = self.attributedText {
            shinyLabel.attributedText = attributedText
        } else {
            shinyLabel.text = self.text
        }
        shinyLabel.textColor = shinyColor
        shinyLabel.font = self.font
        shinyLabel.textAlignment = self.textAlignment
        shinyLabel.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
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
    
    public func stopAnimation() {
        guard self.isAnimating else {
            return
        }
        self.isAnimating = false
        
        self.contentLabel.textColor = self.textColor
        self.shinyLabel?.removeFromSuperview()
        self.shinyLabel = nil
        self.shinyMaskLayer?.removeAnimation(forKey: self.animationKey)
        self.shinyMaskLayer?.removeFromSuperlayer()
        self.shinyMaskLayer = nil
    }
    
    private func updateAnimation() {
        if self.contentLabel.frame == .zero {
            return
        }
        
        let contentFrame = self.contentLabel.frame
        self.shinyLabel?.frame = contentFrame
        let shinyMaskLayerWidth = contentFrame.size.height
        self.shinyMaskLayer?.frame = CGRect(origin: .zero, size: CGSize(width: shinyMaskLayerWidth, height: contentFrame.size.height))
        self.shinyMaskLayer?.removeAnimation(forKey: self.animationKey)
        if let shinyMaskLayer = self.shinyMaskLayer {
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = max(3.0, (contentFrame.size.width + shinyMaskLayerWidth) / 70.0)
            animation.repeatCount = .infinity
            animation.fromValue = -shinyMaskLayerWidth
            animation.toValue = contentFrame.size.width
            animation.isRemovedOnCompletion = false
            shinyMaskLayer.add(animation, forKey: self.animationKey)
        }
    }
}
