//
//  PAGRemoteURLLoadViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/25.
//

import UIKit
import libpag

class PAGRemoteURLLoadViewController: UIViewController {
    
    private let resourceURL = "https://test-static.ohlatech.com/d/5d6b4b93db3767ce671b7db94aaeb418.pag"
    
    private let resourceURLs = [
        "https://test-static.ohlatech.com/d/c9980eced3be15e80531e2ed2ea6ee09.pag",
        "https://test-static.ohlatech.com/d/5d6b4b93db3767ce671b7db94aaeb418.pag",
        "https://test-static.ohlatech.com/d/6bfb75255ef6add67abafd821a4f6a8b.pag",
        "https://test-static.ohlatech.com/d/93bfe49ef8dcbb24e915a19c4d87d6a5.pag"
    ]
    
    private var currentResourceIndex: Int = 0
    private var currentResourceURL: String {
        if currentResourceIndex >= resourceURLs.count {
            currentResourceIndex = currentResourceIndex % resourceURLs.count
        }
        return resourceURLs[currentResourceIndex]
    }
    
    private var currentDownloadingResourceURL: String = ""
    
    private var pagFile: PAGFile?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        print("清除全部PAG缓存")
        PAGDiskCache.removeAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(pagView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(loadButton)
        buttonStackView.addArrangedSubview(startButton)
        buttonStackView.addArrangedSubview(pauseButton)
        buttonStackView.addArrangedSubview(stopButton)
        
        pagView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(pagView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - PAG
    
    private func loadPAGFile(path: String, completion: @escaping (PAGFile?) -> Void) {
        print(Date(), "加载资源", path)
        
        self.currentDownloadingResourceURL = path
        downloaderPAGView.setPathAsync(path) { pagFile in
            if path != self.currentDownloadingResourceURL {
                print("非当前加载资源", path)
                return
            }

            if pagFile == nil {
                print("资源加载错误", path)
            } else {
                print("资源加载完成", path)
            }

            completion(pagFile)
        }
    }
    
    private func replacePlaceholderLayers(for pagFile: PAGFile) {
        guard let image = UIImage(named: "lucky_turntable_player_0"),
              let imageLayer = pagFile.getLayersByName("imgHead").first as? PAGImageLayer,
              let cgImage = image.cgImage,
              let pagImage = PAGImage.fromCGImage(cgImage) else { return }
        
        imageLayer.setImage(pagImage)
    }
    
    private func startPlay() {
        guard let pagFile = self.pagFile else { return }
        
        self.replacePlaceholderLayers(for: pagFile)
        self.pagView.play()
    }
    
    private func pausePlay() {
        self.pagView.pause()
    }
    
    private func stopPlay() {
        self.pagView.stop()
    }
    
    // MARK: - Action
    
    @objc private func didTapPAGView() {
        print("isPlaying:", self.pagView.isPlaying())
    }
    
    @objc private func didTapLoadButton(_ sender: UIButton) {
        let path = self.currentResourceURL
        self.currentResourceIndex += 1
        
//        guard let path = Bundle.main.path(forResource: "avatar_frame_test", ofType: "pag") else { return }
        
        self.loadPAGFile(path: path) { [weak self] pagFile in
            self?.pagFile = pagFile
            self?.pagView.setComposition(pagFile)
            
            if pagFile == nil {
                print(self?.pagView.getComposition(), self?.pagFile)
                self?.stopPlay()
            }
        }
    }
    
    @objc private func didTapStartButton(_ sender: UIButton) {
        self.startPlay()
    }
    
    @objc private func didTapPauseButton(_ sender: UIButton) {
        self.pausePlay()
    }
    
    @objc private func didTapStopButton(_ sender: UIButton) {
        self.stopPlay()
    }
    
    // MARK: - Lazy View
    
    private lazy var downloaderPAGView: PAGView = {
        let view = PAGView()
        return view
    }()
    
    private lazy var pagView: PAGView = {
        let view = PAGView()
        view.setRepeatCount(0)
        view.add(self)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPAGView))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("资源加载", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapLoadButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("开始播放", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setTitle("暂停播放", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPauseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("停止播放", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapStopButton(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - PAGViewListener
extension PAGRemoteURLLoadViewController: PAGViewListener {
    func onAnimationStart(_ pagView: PAGView!) {
        print("PAGRemoteURLLoadViewController onAnimationStart")
    }
    
    func onAnimationEnd(_ pagView: PAGView!) {
        print("PAGRemoteURLLoadViewController onAnimationEnd")
    }
    
    func onAnimationCancel(_ pagView: PAGView!) {
        print("PAGRemoteURLLoadViewController onAnimationCancel")
    }
    
    func onAnimationRepeat(_ pagView: PAGView!) {
        print("PAGRemoteURLLoadViewController onAnimationRepeat")
    }
    
    func onAnimationUpdate(_ pagView: PAGView!) {
//        print("PAGRemoteURLLoadViewController onAnimationUpdate")
    }
}
