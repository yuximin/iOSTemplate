//
//  ScrollableStackViewController.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit
import SnapKit
import XMKit

class ScrollableStackViewController: UIViewController {
    
    static let itemSize = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(horizontalScrollableStackView)
        view.addSubview(verticalScrollableStackView)
        
        horizontalScrollableStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        verticalScrollableStackView.snp.makeConstraints { make in
            make.top.equalTo(horizontalScrollableStackView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
        }
        
        self.setItemViews(for: horizontalScrollableStackView, count: 10)
        self.setItemViews(for: verticalScrollableStackView, count: 10)
    }
    
    private func setItemViews(for scrollableStackView: ScrollableStackView, count: Int) {
        scrollableStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in 0..<count {
            let itemView = UILabel()
            itemView.tag = i
            itemView.text = "\(i)"
            itemView.textColor = .red
            itemView.font = .systemFont(ofSize: 16, weight: .medium)
            itemView.textAlignment = .center
            itemView.backgroundColor = .blue
            itemView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapItemView(_:)))
            itemView.addGestureRecognizer(tap)
            scrollableStackView.addArrangedSubview(itemView)
            
            var itemSize = Self.itemSize
            if i == 1 {
                itemSize.width += 10
                itemSize.height += 10
            }
            itemView.snp.makeConstraints { make in
                make.size.equalTo(itemSize)
            }
        }
    }
    
    @objc private func didTapItemView(_ sender: UITapGestureRecognizer) {
        guard let itemView = sender.view else { return }
        print("didTapItemView:", itemView.tag)
    }
    
    // MARK: - View
    
    private var horizontalScrollableStackView: ScrollableStackView = {
        let scrollableStackView = ScrollableStackView(axis: .horizontal)
        scrollableStackView.backgroundColor = .gray
        scrollableStackView.alignment = .center
        scrollableStackView.spacing = 5.0
        return scrollableStackView
    }()
    
    private var verticalScrollableStackView: ScrollableStackView = {
        let scrollableStackView = ScrollableStackView(axis: .vertical)
        scrollableStackView.backgroundColor = .gray
        scrollableStackView.alignment = .center
        scrollableStackView.spacing = 5.0
        return scrollableStackView
    }()
}
