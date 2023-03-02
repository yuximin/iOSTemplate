//
//  PagEasyPlayViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/21.
//

import UIKit
import libpag

class PagEasyPlayViewController: UIViewController {
    
    private var pagFile: PAGFile?

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadPagResource()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(pagView)
        pagView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300.0, height: 300.0))
        }
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.top.equalTo(pagView.snp.bottom).offset(10.0)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120.0, height: 30.0))
        }
    }
    
    private func loadPagResource() {
        guard let path = Bundle.main.path(forResource: "pk_main", ofType: "pag") else {
            return
        }
        
        guard let pagFile = PAGFile.load(path) else {
            return
        }
        
        self.pagView.setComposition(pagFile)
        self.pagFile = pagFile
    }
    
    // MARK: - action
    
    @objc private func didTapPlay(_ sender: UIButton) {
//        self.pagView.setProgress(0)
//        if self.pagView.isPlaying() {
//            self.pagView.stop()
//        }
//        self.pagFile = nil
//        loadPagResource()
        self.pagView.play()
    }
    
    // MARK: - view
    
    private lazy var pagView: PAGView = {
        let view = PAGView()
        view.setRepeatCount(1)
        view.add(self)
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("播放", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPlay(_:)), for: .touchUpInside)
        return button
    }()

}

// MARK: - PAGViewListener
extension PagEasyPlayViewController: PAGViewListener {
    func onAnimationStart(_ pagView: PAGView!) {
        print("whaley log -- PagEasyPlayViewController onAnimationStart: \(Thread.current)")
    }
    
    func onAnimationEnd(_ pagView: PAGView!) {
        print("whaley log -- PagEasyPlayViewController onAnimationEnd: \(Thread.current)")
    }
    
    func onAnimationCancel(_ pagView: PAGView!) {
        print("whaley log -- PagEasyPlayViewController onAnimationCancel: \(Thread.current)")
    }
    
    func onAnimationRepeat(_ pagView: PAGView!) {
        print("whaley log -- PagEasyPlayViewController onAnimationRepeat: \(Thread.current)")
    }
    
    func onAnimationUpdate(_ pagView: PAGView!) {
        print("whaley log -- PagEasyPlayViewController onAnimationUpdate: \(pagView.getProgress())")
    }
}
