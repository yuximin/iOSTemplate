//
//  UIImageOrientationItemCell.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/4.
//

import UIKit

class UIImageOrientationItemCell: UICollectionViewCell {
    
    var operation: UIImage.Orientation = .up {
        didSet {
            imageView.image = UIImage(named: "Jenkins")?.orientationImage(operation)
            let content: String
            switch operation {
            case .up:
                content = "up"
            case .down:
                content = "down"
            case .left:
                content = "left"
            case .right:
                content = "right"
            case .upMirrored:
                content = "upMirrored"
            case .downMirrored:
                content = "downMirrored"
            case .leftMirrored:
                content = "leftMirrored"
            case .rightMirrored:
                content = "rightMirrored"
            @unknown default:
                content = "unknow"
            }
            contentLabel.text = content
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Jenkins")?.orientationImage(operation)
        return imageView
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = "14".font
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .gray
        
        contentView.addSubview(imageView)
        contentView.addSubview(contentLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
