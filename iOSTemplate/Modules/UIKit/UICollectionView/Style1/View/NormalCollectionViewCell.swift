//
//  NormalCollectionViewCell.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/1.
//

import UIKit
import FSPagerView

class NormalCollectionViewCell: FSPagerViewCell {
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - view
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = "16".font
        label.textColor = .black
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        backgroundColor = .gray
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
    }
}
