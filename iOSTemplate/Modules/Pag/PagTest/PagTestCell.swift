//
//  PagTestCell.swift
//  iOSTemplate
//
//  Created by apple on 2023/3/6.
//

import UIKit
import libpag
import SVGAPlayer

class PagTestCell: UICollectionViewCell {
    
    enum CellType {
        case pag
        case svga
    }
    
    var resourceString: String? {
        didSet {
            switch type {
            case .pag:
                playPag()
            case .svga:
                playSVGA()
            }
        }
    }
    
    var type: CellType = .svga
    
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
        backgroundColor = .black.withAlphaComponent(0.3)
        
        switch type {
        case .pag:
            contentView.addSubview(pagView)
            pagView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .svga:
            contentView.addSubview(svgaPlayer)
            svgaPlayer.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    // MARK: - view
    
    private lazy var pagView: PAGView = {
        let pagView = PAGView()
        pagView.setRepeatCount(0)
        return pagView
    }()
    
    private lazy var svgaPlayer: SVGAPlayer = {
        let svgaPlayer = SVGAPlayer()
        svgaPlayer.loops = -1
        return svgaPlayer
    }()
}

// MARK: - helper
extension PagTestCell {
    private func playPag() {
        guard let resourceString = resourceString, !resourceString.isEmpty else {
            pagView.freeCache()
            pagView.stop()
            return
        }
        
        guard let path = Bundle.main.path(forResource: resourceString, ofType: "pag") else {
            return
        }
        
        guard let pagFile = PAGFile.load(path) else {
            return
        }
        
        pagView.setComposition(pagFile)
        pagView.play()
    }
    
    private func playSVGA() {
        guard let resourceString = resourceString, !resourceString.isEmpty else {
            return
        }
        
        guard let url = URL(string: resourceString) else {
            return
        }
        
        let parser = SVGAParser()
        parser.parse(with: url) { [weak self] videoItem in
            guard let sSelf = self, let videoItem = videoItem else {
                return
            }
            
            sSelf.svgaPlayer.videoItem = videoItem
            sSelf.svgaPlayer.startAnimation()
        } failureBlock: { error in
            print("SVGA parse error: \(error?.localizedDescription ?? "nil")")
        }
    }
}
