//
//  MimicDYCommentView.swift
//  iOSTemplate
//
//  Created by apple on 2025/3/7.
//

import UIKit

class MimicDYCommentView: UIView {
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    
    private var isDragScrollView = false
    private var scrollView: UIScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addPanGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addSubview(tableView)
        contentView.addSubview(closeButton)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(self).multipliedBy(3.0/4.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
    }
    
    private func addPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        panGestureRecognizer.delegate = self
        self.panGestureRecognizer = panGestureRecognizer
        self.contentView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: self.contentView)
        
        if self.isDragScrollView {
            if let scrollView = self.scrollView,
               scrollView.contentOffset.y <= 0 {
                // 顶端
                if translation.y > 0 {
                    // 向下滑动
                    self.scrollView?.contentOffset = .zero
                    self.scrollView?.panGestureRecognizer.isEnabled = false
                    self.scrollView?.panGestureRecognizer.isEnabled = true
                    self.isDragScrollView = false
                    self.contentView.transform = CGAffineTransform(translationX: 0, y: translation.y)
                }
            }
        } else {
            if translation.y > 0 {
                // 向下滑动
                self.contentView.transform = self.contentView.transform.translatedBy(x: 0, y: translation.y)
            } else if translation.y < 0 && self.contentView.frame.origin.y > (self.frame.size.height - self.contentView.frame.size.height) {
                let transform = self.contentView.transform.translatedBy(x: 0, y: translation.y)
                if transform.ty < 0 {
                    self.contentView.transform = .identity
                } else {
                    self.contentView.transform = transform
                }
            }
        }
        
        panGestureRecognizer?.setTranslation(.zero, in: self.contentView)
        
        if panGestureRecognizer?.state == .ended {
            
            let velocity = panGestureRecognizer?.velocity(in: self.contentView).y ?? 0
            if velocity > 300 && self.isDragScrollView == false {
                self.dismiss()
            } else if velocity < -300 && self.isDragScrollView == false {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                    self.contentView.transform = .identity
                }
            } else if self.contentView.frame.origin.y >= self.frame.size.height - self.contentView.frame.size.height / 2.0 {
                self.dismiss()
            } else {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                    self.contentView.transform = .identity
                }
            }
        }
    }
    
    // MARK: - View
    private lazy var backgroundView: UIControl = {
        let view = UIControl()
        view.backgroundColor = "#000000".color.withAlphaComponent(0.5)
        view.addTarget(self, action: #selector(didTapBackground), for: .touchUpInside)
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
}

// MARK: - Action
private extension MimicDYCommentView {
    
    @objc func didTapBackground() {
        self.dismiss()
    }
    
    @objc func didTapClose() {
        self.dismiss()
    }
}

extension MimicDYCommentView {
    
    func show(at parent: UIView) {
        parent.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.layoutIfNeeded()
        
        self.backgroundView.alpha = 0
        self.contentView.transform = CGAffineTransform(translationX: 0, y: self.frame.size.height - self.contentView.frame.minY)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.backgroundView.alpha = 1
            self.contentView.transform = .identity
        }
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.backgroundView.alpha = 0
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.frame.size.height - self.contentView.frame.minY)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MimicDYCommentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.textColor = .black
        return cell
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MimicDYCommentView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            
            var touchView = touch.view
            
            while touchView != nil {
                if let touchView, touchView.isKind(of: UIScrollView.self) {
                    self.isDragScrollView = true
                    self.scrollView = touchView as? UIScrollView
                    break
                }
                
                if touchView == self.contentView {
                    self.isDragScrollView = false
                    break
                }
                
                touchView = touchView?.next as? UIView
            }
            
        }
        
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            var needCheck: Bool = false
            if let scrollViewPanGestureRecognizerClass = NSClassFromString("UIScrollViewPanGestureRecognizer"),
               otherGestureRecognizer.isKind(of: scrollViewPanGestureRecognizerClass) {
                needCheck = true
            } else if let panGestureRecognizerClass = NSClassFromString("UIPanGestureRecognizer"),
                      otherGestureRecognizer.isKind(of: panGestureRecognizerClass) {
                needCheck = true
            }
            
            if needCheck, otherGestureRecognizer.view?.isKind(of: UIScrollView.self) == true {
                return true
            }
        }
        
        return false
    }
}
