//
//  ScrollStackViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit

class ScrollStackViewController: UIViewController {
    
    static let itemSize = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollStackView)
        scrollStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(Self.itemSize.height)
        }
        
        for i in 0..<100 {
            let itemView = UILabel()
            itemView.tag = i
            itemView.text = "\(i)"
            itemView.textColor = .red
            itemView.font = .systemFont(ofSize: 16, weight: .medium)
            itemView.textAlignment = .center
            itemView.backgroundColor = .blue
            scrollStackView.stackView.addArrangedSubview(itemView)
            itemView.snp.makeConstraints { make in
                make.size.equalTo(Self.itemSize)
            }
        }
    }
    
    // MARK: - View
    
    private lazy var scrollStackView: ScrollStackView = {
        let scrollStackView = ScrollStackView()
        scrollStackView.backgroundColor = .gray
        scrollStackView.scrollView.bounces = false
        scrollStackView.scrollView.alwaysBounceHorizontal = true
        scrollStackView.scrollView.alwaysBounceVertical = false
        scrollStackView.stackView.spacing = 5.0
        return scrollStackView
    }()

}
