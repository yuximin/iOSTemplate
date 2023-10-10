//
//  TBCustomButton.swift
//  iOSTemplate
//
//  Created by apple on 2023/10/9.
//

import UIKit
import libpag

class TBCustomButton: UIControl {
    
    static private let textNormalColor: UIColor = UIColor(red: 191.0/255.0, green: 196.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    static private let textSelectedColor: UIColor = UIColor(red: 0.0/255.0, green: 215.0/255.0, blue: 130.0/255.0, alpha: 1.0)
    
    var item: TBCustomTabBarItem? {
        didSet {
            updateItem()
        }
    }
    
    /// 红点标识是否隐藏
    var isBadgeHidden: Bool = true {
        didSet {
            self.badgeView.isHidden = isBadgeHidden
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectState()
        }
    }
    
    private var pagFile: PAGFile?
    
    // MARK: - lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: (self.bounds.width - 28.0) / 2, y: 3.0, width: 28.0, height: 28.0)
        animationView.frame = CGRect(x: (self.bounds.width - 50.0) / 2, y: -13.0, width: 50.0, height: 50.0)
        textLabel.frame = CGRect(x: 0.0, y: imageView.frame.maxY, width: self.bounds.width, height: self.bounds.height - imageView.frame.maxY)
        updateBadgeFrame()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        self.addSubview(imageView)
        self.addSubview(animationView)
        self.addSubview(textLabel)
        self.addSubview(badgeView)
    }
    
    private func updateItem() {
        self.pagFile = nil // 重置pagFile
        imageView.image = item?.image
        textLabel.text = item?.title
        self.updateSelectState()
    }
    
    private func updateSelectState() {
        if self.isSelected {
            imageView.isHidden = true
            textLabel.textColor = TBCustomButton.textSelectedColor
            playAnimation()
        } else {
            imageView.isHidden = false
            textLabel.textColor = TBCustomButton.textNormalColor
            stopAnimation()
        }
        updateBadgeFrame()
    }
    
    private func updateBadgeFrame() {
        let isRTL = UIView.userInterfaceLayoutDirection(for: UIView.appearance().semanticContentAttribute) == .rightToLeft
        if isSelected {
            let frameX = isRTL ? (animationView.frame.minX - 8.0) : animationView.frame.maxX
            badgeView.frame = CGRect(x: frameX, y: animationView.frame.minY, width: 8.0, height: 8.0)
        } else {
            let frameX = isRTL ? (imageView.frame.minX - 8.0) : imageView.frame.maxX
            badgeView.frame = CGRect(x: frameX, y: imageView.frame.minY, width: 8.0, height: 8.0)
        }
    }
    
    private func loadAnimationFile() {
        guard let fileName = self.item?.animationFile,
              let path = Bundle.main.path(forResource: fileName, ofType: "pag"),
              let pagFile = PAGFile.load(path) else {
            return
        }
        
        self.pagFile = pagFile
        self.animationView.setComposition(pagFile)
    }
    
    private func playAnimation() {
        if self.pagFile == nil {
            self.loadAnimationFile()
        }
        
        self.animationView.isHidden = false
        self.animationView.play()
    }
    
    private func stopAnimation() {
        if self.animationView.isPlaying() {
            self.animationView.stop()
        }
        self.animationView.isHidden = true
    }
    
    // MARK: - view
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var animationView: PAGView = {
        let pagView = PAGView()
        pagView.isHidden = true
        pagView.isUserInteractionEnabled = false
        return pagView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = TBCustomButton.textNormalColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        return label
    }()
    
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 4.0
        view.isHidden = self.isBadgeHidden
        return view
    }()
}
