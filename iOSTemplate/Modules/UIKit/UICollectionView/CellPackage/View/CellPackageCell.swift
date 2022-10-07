//
//  CellPackageCell.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/6.
//

import UIKit

protocol CellPackageCellDataSource: AnyObject {
    var nameText: String { get }
    var ageNumber: Int { get }
    var introductionText: String { get }
}

class CellPackageCell: UICollectionViewCell {
    
    var item: CellPackageItem? {
        didSet {
            if let item = item {
                dataSource = item
            }
        }
    }
    
    weak var dataSource: CellPackageCellDataSource? {
        didSet {
            refreshUI()
        }
    }
    
    // MARK: - view
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    private lazy var introductionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12.0)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ui
    
    private func setupUI() {
        backgroundColor = .gray
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(introductionLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15.0)
            make.trailing.lessThanOrEqualToSuperview().offset(-15.0)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().inset(15.0)
            make.trailing.lessThanOrEqualToSuperview().offset(-15.0)
        }
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().inset(15.0)
            make.trailing.lessThanOrEqualToSuperview().offset(-15.0)
        }
    }
    
    private func refreshUI() {
        nameLabel.text = "姓名：\(dataSource?.nameText ?? "")"
        ageLabel.text = "年龄：\(dataSource?.ageNumber ?? 0)"
        introductionLabel.text = "介绍：\(dataSource?.introductionText ?? "")"
    }
}
