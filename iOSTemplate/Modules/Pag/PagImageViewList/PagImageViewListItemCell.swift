//
//  PagImageViewListItemCell.swift
//  iOSTemplate
//
//  Created by apple on 2023/5/10.
//

import UIKit
import libpag

class PagImageViewListItemCell: UITableViewCell {
    
    // MARK: - life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ui
    
    private func setupUI() {
        backgroundColor = .black
        selectionStyle = .none
        
//        contentView.addSubview(pagImageView)
//        pagImageView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(CGSize(width: 80.0, height: 80.0))
//        }
    }
    
    // MARK: - view
    
//    private lazy var pagImageView: PAGImageView = {
//        let pagImageView = PAGImageView()
//        pagImageView.setRepeatCount(0)
//        return pagImageView
//    }()
    private var pagImagView: PAGImageView?
}

// MARK: - interface
extension PagImageViewListItemCell {
    func playFileWithPath(_ path: String) {
        self.pagImagView?.removeFromSuperview()
        
        let pagImageView = PAGImageView()
        pagImageView.setRepeatCount(0)
        contentView.addSubview(pagImageView)
        self.pagImagView = pagImageView
        pagImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80.0, height: 80.0))
        }
        
        guard pagImageView.setPath(path) else { return }
        
        pagImageView.play()
    }
}
