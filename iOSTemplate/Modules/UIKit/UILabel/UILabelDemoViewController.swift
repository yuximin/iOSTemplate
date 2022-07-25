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
    }

}
