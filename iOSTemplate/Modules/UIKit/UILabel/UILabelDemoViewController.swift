//
//  UILabelDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/25.
//

import UIKit

class UILabelDemoViewController: UIViewController {
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.backgroundColor = .red.withAlphaComponent(0.8)
        return label
    }()
    
    private lazy var colorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .black
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(contentLabel)
        
        let content = "تمت إعادة بعض الطلبات بنجاح ويمكن عرضها في المحفظة"
        let attributedString = NSAttributedString(string: content, attributes: [.font: UIFont.systemFont(ofSize: 12)])
        let boundingRect = attributedString.boundingRect(with: CGSize(width: CGFloat.infinity, height: 15), options: [], context: nil)
        contentLabel.text = content
        contentLabel.frame = CGRect(x: (UIScreen.main.bounds.width - boundingRect.width) / 2,
                                    y: (UIScreen.main.bounds.height - boundingRect.height) / 2,
                                    width: boundingRect.width,
                                    height: boundingRect.height)
        
        view.addSubview(colorsLabel)
        colorsLabel.text = "我哦卫计委阿胶粉i哦我饿叫哦😁if金额我ij😁sdfasdfasdfasdfasdfasdfasdfsa"
        colorsLabel.frame = CGRect(x: 30.0, y: contentLabel.frame.maxY + 10.0, width: 200.0, height: 50.0)
        
        if let image = UIImage.imageWith(colors: [UIColor.red, UIColor.blue], size: CGSize(width: 100.0, height: 50.0), gradientType: .horizontal) {
            let color = UIColor(patternImage: image)
            colorsLabel.textColor = color
        } else {
            colorsLabel.textColor = .red
        }
        
        let strokeLabel = UILabel()
        strokeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        strokeLabel.attributedText = NSAttributedString(string: "测试测试测试",
                                                        attributes: [
                                                            .foregroundColor: UIColor.black,
                                                            .strokeColor: UIColor.red,
                                                            .strokeWidth: 4
                                                        ])
        view.addSubview(strokeLabel)
        strokeLabel.snp.makeConstraints { make in
            make.top.equalTo(colorsLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        let stroke2Label = UILabel()
        stroke2Label.font = .systemFont(ofSize: 18, weight: .bold)
        stroke2Label.attributedText = NSAttributedString(string: "测试测试测试",
                                                         attributes: [
                                                            .foregroundColor: UIColor.black,
                                                            .strokeColor: UIColor.red,
                                                            .strokeWidth: -4
                                                         ])
        view.addSubview(stroke2Label)
        stroke2Label.snp.makeConstraints { make in
            make.top.equalTo(strokeLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

}

extension UIImage {

    public enum GradientType3 {
        /// 水平
        case horizontal
        /// 竖直
        case vertical
        /// 斜向上
        case obliqueUpward
        /// 斜向下
        case obliqueDownward
    }
    /// 生成渐变色图片
    public static func imageWith(colors: [UIColor], size: CGSize, gradientType: GradientType3 = .vertical, cornerRadius: CGFloat = 0, corners: UIRectCorner = .allCorners, isOpaque: Bool = false) -> UIImage? {
        var colors = colors
        if colors.isEmpty {
            colors = [.white, .white]
        } else if colors.count == 1 {
            colors = [colors.first!, colors.first!]
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.isOpaque = isOpaque
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        switch gradientType {
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .obliqueUpward:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case .obliqueDownward:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }

        if cornerRadius != 0 {
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = CGRect(origin: .zero, size: size)
            shapeLayer.path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            gradientLayer.mask = shapeLayer
        }
        gradientLayer.colors = colors.map({ $0.cgColor })
        UIGraphicsBeginImageContextWithOptions(size, gradientLayer.isOpaque, 0)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
