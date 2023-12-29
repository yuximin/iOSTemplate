//
//  PagPlayerImageView.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/27.
//

import UIKit
import libpag
import SDWebImage
    
@objc public protocol PagPlayerImageViewDelegate: AnyObject {
    @objc optional func pagPlayerImageViewOnAnimationStart(_ view: PagPlayerImageView)
    @objc optional func pagPlayerImageViewOnAnimationEnd(_ view: PagPlayerImageView)
    @objc optional func pagPlayerImageViewOnAnimationCancel(_ view: PagPlayerImageView)
    @objc optional func pagPlayerImageViewOnAnimationRepeat(_ view: PagPlayerImageView)
    @objc optional func pagPlayerImageViewOnAnimationUpdate(_ view: PagPlayerImageView)
}

public class PagPlayerImageView: UIControl {
    
    private static let vipResources = [
        "https://client.karawangroup.com/vip/vip_label_1.pag",
        "https://client.karawangroup.com/vip/vip_label_2.pag",
        "https://client.karawangroup.com/vip/vip_label_3.pag",
        "https://client.karawangroup.com/vip/vip_label_4.pag",
        "https://client.karawangroup.com/vip/vip_label_5.pag",
        "https://client.karawangroup.com/vip/vip_label_6.pag",
        "https://client.karawangroup.com/vip/vip_label_7.pag",
        "https://client.karawangroup.com/vip/vip_label_8.pag",
        "https://client.karawangroup.com/vip/vip_label_9.pag",
        "https://client.karawangroup.com/vip/vip_label_10.pag",
        "https://client.karawangroup.com/vip/vip_label_11.pag",
        "https://client.karawangroup.com/vip/vip_label_12.pag",
        "https://client.karawangroup.com/vip/vip_label_13.pag",
        "https://client.karawangroup.com/vip/vip_label_14.pag",
        "https://client.karawangroup.com/vip/vip_label_15.pag"
    ]
    
    public var repeatCount: Int32 = 1 {
        didSet {
            pagImageView?.setRepeatCount(repeatCount)
        }
    }
    
    public var isPlaying: Bool {
        pagImageView?.isPlaying() ?? false
    }
    
    public var isRemoveOnAnimationEnd: Bool = false
    
    public weak var delegate: PagPlayerImageViewDelegate?
    
    private(set) var currentRemoteURLString: String?
    
    private(set) var pagImageView: PAGImageView?
    private var pagFile: PAGFile?
    
    // MARK: - life cycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.pagImageView?.frame != self.bounds {
            self.pagImageView?.frame = self.bounds
        }
    }
}

// MARK: - 图层替换
extension PagPlayerImageView {
    /// 图层占位替换
    public func replacePlaceholderLayers(_ items: [PAGPlaceholderItem]) {
        guard let pagFile = pagFile, !items.isEmpty else { return }
        
        for item in items {
            switch item.content {
            case let .localImage(image, scaleMode):
                guard let imageLayer = pagFile.getLayersByName(item.placeholder).first as? PAGImageLayer,
                      let cgImage = (image ?? UIImage(color: .clear))?.cgImage,
                      let pagImage = PAGImage.fromCGImage(cgImage) else { break }
                
                if let scaleMode = scaleMode {
                    pagImage.setScaleMode(scaleMode.mode)
                }
                imageLayer.setImage(pagImage)
            case let .remoteImage(urlString, scaleMode):
                guard let imageLayer = pagFile.getLayersByName(item.placeholder).first as? PAGImageLayer else { break }
                
                if let urlString = urlString, !urlString.isEmpty,
                   let URL = URL(string: urlString) {
                    SDWebImageManager.shared.loadImage(with: URL, progress: nil) { [weak self] image, _, error, _, _, _ in
                        guard error == nil,
                              let sSelf = self,
                              let cgImage = image?.cgImage,
                              let pagImage = PAGImage.fromCGImage(cgImage) else { return }
                        
                        if let scaleMode = scaleMode {
                            pagImage.setScaleMode(scaleMode.mode)
                        }
                        imageLayer.setImage(pagImage)
//                        sSelf.flush()
                    }
                } else if let cgImage = UIImage(color: .clear)?.cgImage,
                          let pagImage = PAGImage.fromCGImage(cgImage) {
                    imageLayer.setImage(pagImage)
                }
            case .text(content: let content):
                guard let layers = pagFile.getLayersByName(item.placeholder) else { break }
                
                for layer in layers {
                    if let textLayer = layer as? PAGTextLayer {
                        textLayer.setText(content)
                    }
                }
            }
        }
//        self.flush()
    }
}

// MARK: - interface
extension PagPlayerImageView {
    /// 播放远程资源文件
    public func playRemoteFileWithURLString(_ urlString: String, placeholderItems: [PAGPlaceholderItem] = [], completion: ((Result<Void, Error>) -> Void)? = nil) {
        if urlString.isEmpty || !urlString.hasSuffix(".pag") {
            let error = NSError(domain: "PagPlayer.PagPlayerImageView",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "playRemoteFileWithURLString urlString format error: \(urlString)"])
            handlePlayError(error)
            completion?(.failure(error))
            return
        }
        
        self.currentRemoteURLString = urlString
        ResourceDownloadManager.shared.download(urlString) { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case .success(let path):
                if urlString != sSelf.currentRemoteURLString {
                    return
                }
                
                sSelf.playLocalFileWithPath(path, placeholderItems: placeholderItems, completion: completion)
            case .failure(let error):
                let logError = NSError(domain: "PagPlayer.PagPlayerImageView",
                                       code: 0,
                                       userInfo: [NSLocalizedDescriptionKey: "playRemoteFileWithURLString download failure: \(urlString), error: \(error.localizedDescription)"])
                sSelf.handlePlayError(logError)
                completion?(.failure(logError))
            }
        }
    }
    
    /// 播放本地文件
    public func playLocalFileWithPath(_ path: String, placeholderItems: [PAGPlaceholderItem] = [], completion: ((Result<Void, Error>) -> Void)? = nil) {
        if path.isEmpty || !path.hasSuffix(".pag") {
            let error = NSError(domain: "PagPlayer.PagPlayerImageView",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "playLocalFileWithPath path format error"])
            handlePlayError(error)
            completion?(.failure(error))
            return
        }
        
        let playingPath = self.pagImageView?.getPath()
        if self.isPlaying && playingPath == path {
            // 当前正在播放，并且资源路径相同，不需要重复播放
            completion?(.success(()))
            return
        }
        
        Thread.safeMainThreadAsync {
            guard let pagFile = PAGFile.load(path) else {
                let error = NSError(domain: "PagPlayer.PagPlayerImageView",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey:"playLocalFileWithPath setPath failure: \(path)"])
                self.handlePlayError(error)
                completion?(.failure(error))
                return
            }
            
            self.pagFile = pagFile
            self.replacePlaceholderLayers(placeholderItems)
            
            let pagImageView = PAGImageView()
            pagImageView.setComposition(pagFile)
            self.addSubview(pagImageView)
            pagImageView.frame = self.bounds
            pagImageView.setCurrentFrame(0)
            pagImageView.setRepeatCount(self.repeatCount)
            pagImageView.add(self)
            pagImageView.play()
            self.pagImageView?.removeFromSuperview()
            self.pagImageView = pagImageView
            completion?(.success(()))
        }
    }
    
    public func play() {
        pagImageView?.play()
    }
    
    public func pause() {
        pagImageView?.pause()
    }
    
    public func flush() {
        if self.isPlaying { return }
        self.pagImageView?.flush()
    }
}

// MARK: - private
extension PagPlayerImageView {
    /// 发送错误日志
    private func handlePlayError(_ error: Error) {
        self.currentRemoteURLString = nil
        self.pagFile = nil
        self.pause()
    }
}

// MARK: - VIP
extension PagPlayerImageView {
    /// VIP标签
    public func playVIPLabel(level: Int) {
        let index = level - 1
        if index >= Self.vipResources.count || index < 0 { return }
        
        self.playRemoteFileWithURLString(Self.vipResources[index])
    }
    
    /// 等级标签
    public func playLevelTag(_ level: Int) {
        guard let item = LevelConfigModel.demoItems.first(where: { $0.inRange(level) }) else { return }
        
        self.playRemoteFileWithURLString(item.url, placeholderItems: [.init(placeholder: "rank_num", content: .text(content: "\(level)"))])
    }
}

// MARK: - PAGImageViewListener
extension PagPlayerImageView: PAGImageViewListener {
    public func onAnimationStart(_ pagView: PAGImageView) {
        delegate?.pagPlayerImageViewOnAnimationStart?(self)
    }
    
    public func onAnimationEnd(_ pagView: PAGImageView) {
        if self.isRemoveOnAnimationEnd {
            Thread.safeMainThreadAsync {
                self.pagImageView?.removeFromSuperview()
            }
        }
        delegate?.pagPlayerImageViewOnAnimationEnd?(self)
    }
    
    public func onAnimationCancel(_ pagView: PAGImageView) {
        if self.isRemoveOnAnimationEnd {
            Thread.safeMainThreadAsync {
                self.pagImageView?.removeFromSuperview()
            }
        }
        delegate?.pagPlayerImageViewOnAnimationCancel?(self)
    }
    
    public func onAnimationRepeat(_ pagView: PAGImageView) {
        delegate?.pagPlayerImageViewOnAnimationRepeat?(self)
    }
    
    public func onAnimationUpdate(_ pagView: PAGImageView) {
        delegate?.pagPlayerImageViewOnAnimationUpdate?(self)
    }
}

