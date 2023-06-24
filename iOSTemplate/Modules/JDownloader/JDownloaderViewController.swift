//
//  JDownloaderViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/10.
//

import UIKit

class JDownloaderViewController: UIViewController {
    
    private var downloader: JDownloader?

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(startButton)
        buttonsStackView.addArrangedSubview(cancelButton)
        
        buttonsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - action
    
    @objc private func didTapStart(_ sender: UIButton) {
        startDownload()
    }
    
    @objc private func didTapCancel(_ sender: UIButton) {
        cancelDownload()
    }
    
    // MARK: - view
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10.0
        return stackView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("开始下载", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
            button.configuration = configuration
        } else {
            button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        }
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapStart(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消下载", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
            button.configuration = configuration
        } else {
            button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        }
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapCancel(_:)), for: .touchUpInside)
        return button
    }()

}

// MARK: - helper
extension JDownloaderViewController {
    
    private func startDownload() {
        Logger.info("JDownloader start download")
        guard let url = URL(string: "https://github.com/yuximin/StaticResources/blame/master/Test/test.zip?raw=true") else {
            return
        }

        let cache = XMCache(identifier: "com.cache.test")
        let downloader = JDownloader(cache: cache)
        downloader.downloadFileWithURL(url)
        self.downloader = downloader
    }
    
    private func cancelDownload() {
        Logger.info("JDownloader stop download")
//        downloader?.cancelDownload()
    }
}
