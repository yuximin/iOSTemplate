//
//  ImageWaterMarkViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/11/10.
//

import UIKit
import SnapKit
import SDWebImage

class ImageWaterMarkViewController: UIViewController {
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        print("time1:", Date().timeIntervalSince1970)
        let avatarURLString = "https://test-image.ohlatech.com/photo/3a43ce9381402cc961334b75a6e11fef_w400_h400.jpeg"
        SDWebImageManager.shared.loadImage(with: URL(string: avatarURLString), progress: nil) { [weak self] image, data, error, _, finished, _ in
            guard finished, error == nil, let image = image else { return }
            
            print("time2:", Date().timeIntervalSince1970)
            self?.imageView.image = self?.createBirthCard(avatar: image, name: "Kerry")
        }
        
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func createBirthCard(avatar: UIImage, name: String) -> UIImage? {
        guard let contentImage = UIImage(named: "image_water_mark_bg") else { return nil }
        let contentSize = contentImage.size
        
        // 开启图片类型的图形上下文
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let contentView = UIImageView()
        contentView.frame = CGRect(origin: .zero, size: contentSize)
        contentView.image = contentImage
        
        let avatarWidth: CGFloat = 72
        let avatarTopInset: CGFloat = 46
        let avatarImageView = UIImageView()
        avatarImageView.frame = CGRect(x: (contentSize.width - avatarWidth) * 0.5, y: avatarTopInset, width: avatarWidth, height: avatarWidth)
        avatarImageView.image = avatar
        avatarImageView.layer.borderColor = "#FFFFFF".color.cgColor
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = avatarWidth * 0.5
        avatarImageView.layer.masksToBounds = true
        contentView.addSubview(avatarImageView)
        
        let nameView = UIView()
        nameView.frame = CGRect(x: 71, y: avatarImageView.frame.maxY + 10, width: 109, height: 32)
        nameView.layer.borderColor = "#FFFFFF".color.withAlphaComponent(0.5).cgColor
        nameView.layer.borderWidth = 2
        nameView.layer.cornerRadius = 16
        nameView.layer.masksToBounds = true
        nameView.backgroundColor = "#000000".color.withAlphaComponent(0.5)
        contentView.addSubview(nameView)
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 16, y: 0, width: nameView.bounds.width - 16 * 2, height: nameView.bounds.height)
        nameLabel.text = name
        nameLabel.textColor = "#FFFFFF".color
        nameLabel.font = "18".font(weight: .medium)
        nameLabel.textAlignment = .center
        nameView.addSubview(nameLabel)
        
        let describeFont = "16".font(weight: .medium)
        let describeLabel = UILabel()
        describeLabel.frame = CGRect(x: 15, y: nameView.frame.maxY + 40, width: contentView.bounds.width - 15 * 2, height: describeFont.lineHeight)
        describeLabel.text = "You were born."
        describeLabel.textColor = "#FFFFFF".color
        describeLabel.font = describeFont
        describeLabel.textAlignment = .center
        contentView.addSubview(describeLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        let dateFont = "12".font
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 15, y: describeLabel.frame.maxY, width: contentView.bounds.width - 15 * 2, height: dateFont.lineHeight)
        dateLabel.text = dateString
        dateLabel.textColor = "#FFFFFF".color
        dateLabel.font = dateFont
        dateLabel.textAlignment = .center
        contentView.addSubview(dateLabel)
        
        contentView.layer.render(in: context)
        
        let birthCardImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return birthCardImage
    }
    
    // MARK: - Lazy View
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

}
