//
//  PagPlayerView.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/27.
//

import UIKit
import libpag
import SDWebImage

@objc public protocol PagPlayerDelegate: AnyObject {
    @objc optional func pagPlayerDidAnimationStart(_ playerView: PagPlayerView)
    @objc optional func pagPlayerDidAnimationEnd(_ playerView: PagPlayerView)
    @objc optional func pagPlayerDidAnimationCancel(_ playerView: PagPlayerView)
    @objc optional func pagPlayerDidAnimationRepeat(_ playerView: PagPlayerView)
    @objc optional func pagPlayerDidAnimationUpdate(_ playerView: PagPlayerView)
    @objc optional func pagPlayer(_ playerView: PagPlayerView, didLoadError error: Error?)
}

public enum PagPlayerScaleMode {
    case none
    case stretch
    case letterBox
    case zoom
    
    public var mode: PAGScaleMode {
        switch self {
        case .none:
            return PAGScaleModeNone
        case .stretch:
            return PAGScaleModeStretch
        case .letterBox:
            return PAGScaleModeLetterBox
        case .zoom:
            return PAGScaleModeZoom
        }
    }
}

public struct PAGPlaceholderItem {
    public enum ContentType {
        case localImage(image: UIImage?, scaleMode: PagPlayerScaleMode? = nil)
        case remoteImage(urlString: String?, scaleMode: PagPlayerScaleMode? = nil)
        case text(content: String)
    }
    
    public var placeholder: String
    public var content: ContentType
    
    public init(placeholder: String, content: ContentType) {
        self.placeholder = placeholder
        self.content = content
    }
}

public class PagPlayerView: UIControl {
    
    public weak var delegate: PagPlayerDelegate?
    
    /// 重复播放次数
    ///
    /// 默认为1
    /// 循环播放设为值为0
    public var repeatCount: Int32 = 1 {
        didSet {
            pagView.setRepeatCount(max(0, repeatCount))
        }
    }
    
    public var progress: Double {
        get {
            pagView.getProgress()
        }
        set {
            pagView.setProgress(max(0.0, min(newValue, 1.0)))
        }
    }
    
    public var duration: TimeInterval {
        
        return TimeInterval(pagView.duration())/1000000.0
    }
    
    /// 播放完成后是否隐藏视图
    public var isHideOnAnimationEnd: Bool = true
    
    /// 是否根据pag文件尺寸自动调整pagView视图布局
    public var isAutoResize: Bool = false
    
    /// 视图适配方式
    public var scaleMode: PagPlayerScaleMode = .letterBox {
        didSet {
            pagView.setScaleMode(scaleMode.mode)
        }
    }
    
    /// 是否正在播放
    public var isPlaying: Bool {
        pagView.isPlaying()
    }
    
    /// 资源是否加载完成
    public var isLoaded: Bool {
        pagFile != nil
    }
    
    /// 当前特效Url地址
    public private(set) var currentResourceUrl: String = ""
    
    private(set) var pagFile: PAGFile?
    
    // MARK: - view
    
    public private(set) lazy var pagView: PAGView = {
        let view = PAGView()
        view.isUserInteractionEnabled = false
        view.setRepeatCount(max(0, repeatCount))
        view.setScaleMode(scaleMode.mode)
        view.add(self)
        return view
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
    
    deinit {
//        self.pagView.freeCache()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        addSubview(pagView)
    }
    
    // MARK: - 播放 & 暂停
    
    public func play() {
        self.pagView.isHidden = false
        self.pagView.play()
    }
    
    public func stop() {
        self.pagView.stop()
    }
    
    /// 刷新显示
    public func flush() {
        if !self.isPlaying {
            self.pagView.flush()
        }
    }
    
    private func clear() {
        if self.isPlaying {
            self.pagView.stop()
        }
        self.pagFile = nil
        currentResourceUrl = ""
    }
    
}

// MARK: - 图层替换
extension PagPlayerView {
    /// 图层占位替换
    public func replacePlaceholderLayers(_ items: [PAGPlaceholderItem]) {
        guard let pagFile = pagFile else { return }
        
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
                        sSelf.flush()
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
        
        self.flush()
    }
}

// MARK: - 资源加载
extension PagPlayerView {
    
    /// 加载远程资源
    public func loadRemoteFileWithURLString(_ urlString: String, completion: ((Result<PAGFile, Error>) -> Void)? = nil) {
        self.currentResourceUrl = urlString
        
        if urlString.isEmpty {
            let error = NSError(domain: "com.ohla.PagPlayerView",
                                code: 4,
                                userInfo: [NSLocalizedDescriptionKey: "PagPlayerView load, urlString is empty."])
            handleLoadError(error)
            completion?(.failure(error))
            return
        }
        
        if (urlString as NSString).pathExtension != "pag" {
            let error = NSError(domain: "com.ohla.PagPlayerView",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "PagPlayerView load, unsupport urlString: \(urlString)"])
            handleLoadError(error)
            completion?(.failure(error))
            return
        }
        
        ResourceDownloadManager.shared.download(urlString) { [weak self] result in
            guard let sSelf = self else { return }
            
            if urlString != sSelf.currentResourceUrl {
                // 下载完成的资源链接不是当前播放的资源链接，不做处理
                return
            }
            
            switch result {
            case let .success(path):
                guard let pagFile = PAGFile.load(path) else {
                    let error = NSError(domain: "com.ohla.PagPlayerView",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "PagPlayerView load, PAGFile load error: \(urlString)"])
                    sSelf.handleLoadError(error)
                    completion?(.failure(error))
                    return
                }

                Thread.safeMainThreadAsync {
                    // isAutoResize会根据资源尺寸设置布局，这里在资源加载完成后再对pagView设置布局，防止画面抖动
                    if sSelf.isAutoResize {
                        sSelf.pagView.snp.remakeConstraints { make in
                            make.leading.bottom.trailing.equalToSuperview()
                            make.height.equalTo(sSelf.pagView.snp.width).multipliedBy(CGFloat(pagFile.height()) / CGFloat(pagFile.width()))
                        }
                    } else {
                        sSelf.pagView.snp.remakeConstraints { make in
                            make.edges.equalToSuperview()
                        }
                    }

                    sSelf.pagView.setComposition(pagFile)
                    sSelf.pagFile = pagFile
                    completion?(.success(pagFile))
                }
            case let .failure(error):
                let loadError = NSError(domain: "com.ohla.PagPlayerView",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "PagPlayerView load, download fail: \(urlString), error: \(error.localizedDescription)"])
                sSelf.handleLoadError(error)
                completion?(.failure(loadError))
            }
        }
    }
    
    /// 加载本地资源
    public func loadLocalFileWithPath(_ filePath: String, completion: ((Result<PAGFile, Error>) -> Void)? = nil) {
        if filePath.isEmpty {
            let error = NSError(domain: "com.ohla.PagPlayerView",
                                code: 4,
                                userInfo: [NSLocalizedDescriptionKey:"PagPlayerView loadFile, filePath is empty."])
            handleLoadError(error)
            completion?(.failure(error))
            return
        }
        
        if (filePath as NSString).pathExtension != "pag" {
            let error = NSError(domain: "com.ohla.PagPlayerView",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey:"PagPlayerView loadFile, unsupport filePath: \(filePath)"])
            handleLoadError(error)
            completion?(.failure(error))
            return
        }
        
        guard let pagFile = PAGFile.load(filePath) else {
            let error = NSError(domain: "com.ohla.PagPlayerView",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey:"PagPlayerView loadFile, PAGFile load error: \(filePath)"])
            handleLoadError(error)
            completion?(.failure(error))
            return
        }
        
        Thread.safeMainThreadAsync {
            // isAutoResize会根据资源尺寸设置布局，这里在资源加载完成后再对pagView设置布局，防止画面抖动
            if self.isAutoResize {
                self.pagView.snp.remakeConstraints { make in
                    make.leading.bottom.trailing.equalToSuperview()
                    make.height.equalTo(self.pagView.snp.width).multipliedBy(CGFloat(pagFile.height()) / CGFloat(pagFile.width()))
                }
            } else {
                self.pagView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
            
            self.pagView.setComposition(pagFile)
            self.pagFile = pagFile
            completion?(.success(pagFile))
        }
    }
    
    private func handleLoadError(_ error: Error) {
        if (error as NSError).code == 4 {
            print("PagPlayerView load error:\(error.localizedDescription)")
            
            // 资源链接为空时，清空当前播放
            self.clear()
        } else {
            print("PagPlayerView load error:\(error.localizedDescription)")
        }
        
        Thread.safeMainThreadAsync {
            self.delegate?.pagPlayer?(self, didLoadError: error)
        }
    }
}

// MARK: - convenient play
extension PagPlayerView {
    /// 播放远程动效文件，支持图层替换
    public func playRemoteFileWithURLString(_ urlString: String, placeholderItems: [PAGPlaceholderItem]) {
        self.playRemoteFileWithURLString(urlString) { [weak self] _ in
            self?.replacePlaceholderLayers(placeholderItems)
        }
    }
    
    /// 播放本地动效文件，支持图层替换
    public func playLocalFileWithPath(_ path: String, placeholderItems: [PAGPlaceholderItem]) {
        self.playLocalFileWithPath(path) { [weak self] _ in
            self?.replacePlaceholderLayers(placeholderItems)
        }
    }
    
    /// 播放远程动效文件
    public func playRemoteFileWithURLString(_ urlString: String, pagFileHandler: ((PAGFile) -> Void)? = nil) {
        self.loadRemoteFileWithURLString(urlString) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(pagFile):
                pagFileHandler?(pagFile)
                self.play()
            case .failure:
                break
            }
        }
    }
    
    /// 播放本地动效文件
    public func playLocalFileWithPath(_ filePath: String, pagFileHandler: ((PAGFile) -> Void)? = nil) {
        self.loadLocalFileWithPath(filePath) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(pagFile):
                pagFileHandler?(pagFile)
                self.play()
            case .failure:
                break
            }
        }
        
    }
}

// MARK: - specific
extension PagPlayerView {
    
    /// 等级标签
    public func playLevelTag(_ level: Int) {
        guard let item = LevelConfigModel.demoItems.first(where: { $0.inRange(level) }) else { return }
        
        self.isHideOnAnimationEnd = false
        self.playRemoteFileWithURLString(item.url, placeholderItems: [.init(placeholder: "rank_num", content: .text(content: "\(level)"))])
    }
}

// MARK: - PAGViewListener
extension PagPlayerView: PAGViewListener {
    public func onAnimationStart(_ pagView: PAGView!) {
        Thread.safeMainThreadAsync {
            self.delegate?.pagPlayerDidAnimationStart?(self)
        }
    }
    
    public func onAnimationEnd(_ pagView: PAGView!) {
        Thread.safeMainThreadAsync {
            if self.isHideOnAnimationEnd {
                pagView.isHidden = true
            }
            self.delegate?.pagPlayerDidAnimationEnd?(self)
        }
    }
    
    public func onAnimationCancel(_ pagView: PAGView!) {
        Thread.safeMainThreadAsync {
            if self.isHideOnAnimationEnd {
                pagView.isHidden = true
            }
            self.delegate?.pagPlayerDidAnimationCancel?(self)
        }
    }
    
    public func onAnimationRepeat(_ pagView: PAGView!) {
        Thread.safeMainThreadAsync {
            self.delegate?.pagPlayerDidAnimationRepeat?(self)
        }
    }
    
    public func onAnimationUpdate(_ pagView: PAGView!) {
        Thread.safeMainThreadAsync {
            self.delegate?.pagPlayerDidAnimationUpdate?(self)
        }
    }
}

extension Thread {
    static func safeMainThreadAsync(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
