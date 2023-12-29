//
//  PAGListTestCell.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/27.
//

import UIKit
import SnapKit

class PAGListTestCell: UITableViewCell, Reusable {
    
    var level: Int = 0 {
        didSet {
            if level == 0 {
                levelView.isHidden = true
                levelImageView.isHidden = true
            } else {
                levelView.isHidden = false
                levelView.playLevelTag(level)
                
                levelImageView.isHidden = false
                levelImageView.playLevelTag(level)
            }
        }
    }
    
    var avatarResourceURL: String? {
        didSet {
            avatarFrameView.playRemoteFileWithURLString(avatarResourceURL ?? "")
        }
    }
    
    var vipLevel: Int = 0 {
        didSet {
            if vipLevel == 0 {
                vipLevelView.isHidden = true
            } else {
                vipLevelView.isHidden = false
                vipLevelView.playVIPLabel(level: vipLevel)
            }
        }
    }
    
    var row: Int = 0
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("whaley log -- PAGListTestCell deinit", row)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(avatarFrameView)
        contentView.addSubview(vipLevelView)
        contentView.addSubview(levelView)
        contentView.addSubview(levelImageView)
        
        avatarFrameView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        vipLevelView.snp.makeConstraints { make in
            make.leading.equalTo(avatarFrameView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(levelView.snp.height).multipliedBy(156.0/60.0)
        }
        
        levelView.snp.makeConstraints { make in
            make.leading.equalTo(vipLevelView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(levelView.snp.height).multipliedBy(156.0/60.0)
        }
        
        levelImageView.snp.makeConstraints { make in
            make.leading.equalTo(levelView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(levelView.snp.height).multipliedBy(156.0/60.0)
        }
    }
    
    // MARK: - View
    
    private lazy var avatarFrameView: PagPlayerImageView = {
        let view = PagPlayerImageView()
        view.repeatCount = 0
        view.isRemoveOnAnimationEnd = true
        return view
    }()
    
    private lazy var vipLevelView: PagPlayerImageView = {
        let view = PagPlayerImageView()
        view.repeatCount = 0
        return view
    }()
    
    private(set) lazy var levelView: PagPlayerView = {
        let view = PagPlayerView()
        view.repeatCount = 0
        return view
    }()
    
    private(set) lazy var levelImageView: PagPlayerImageView = {
        let view = PagPlayerImageView()
        view.repeatCount = 0
        return view
    }()
}
