//
//  ScrollableStackView.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit

@available(iOS 9.0, *)
open class ScrollableStackView: UIView {
    
    public let axis: NSLayoutConstraint.Axis
    
    open var alignment: UIStackView.Alignment = .fill {
        didSet {
            self.stackView.alignment = alignment
        }
    }
    
    open var spacing: CGFloat = 0.0 {
        didSet {
            self.stackView.spacing = spacing
        }
    }

    // MARK: - Lifecycle
    
    init(axis: NSLayoutConstraint.Axis) {
        self.axis = axis
        super.init(frame: .zero)
        
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        switch self.axis {
        case .vertical:
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        default:
            adpatRTL()
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
        }
    }
    
    private func adpatRTL() {
        if UIView.isRTL {
            // scrollView旋转180度，这时候scrollView的subview是倒着的，需要再将subview旋转180度使其恢复正常视角
            self.scrollView.transform = CGAffineTransformMakeRotation(.pi)
            self.stackView.transform = CGAffineTransformMakeRotation(.pi)
        } else {
            self.scrollView.transform = .identity
            self.stackView.transform = .identity
        }
    }
    
    // MARK: - Implement UIStackView
    
    open var arrangedSubviews: [UIView] {
        self.stackView.arrangedSubviews
    }
    
    open func addArrangedSubview(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }
    
    open func removeArrangedSubview(_ view: UIView) {
        self.stackView.removeArrangedSubview(view)
    }
    
    open func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        self.stackView.insertArrangedSubview(view, at: stackIndex)
    }
    
    @available(iOS 11.0, *)
    public func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        self.stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }
    
    @available(iOS 11.0, *)
    public func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        self.stackView.customSpacing(after: arrangedSubview)
    }
    
    // MARK: - View
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = self.axis
        stackView.distribution = .fill
        stackView.alignment = self.alignment
        stackView.spacing = self.spacing
        return stackView
    }()
}
