//
//  CollectionViewStyle1ViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/1.
//

import UIKit
import FSPagerView

class CollectionViewStyle1ViewController: UIViewController {
    
    // MARK: - view
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.scrollDirection = .horizontal
        let itemWidth = UIScreen.main.bounds.width - 50 * 2
        pagerView.itemSize = CGSize(width: itemWidth, height: itemWidth * 192.0 / 337.0)
        let transformer = FSPagerViewTransformer(type: .linear)
        transformer.minimumScale = 0.75
        pagerView.transformer = transformer
        pagerView.decelerationDistance = FSPagerView.automaticDistance
        pagerView.isInfinite = false
        pagerView.interitemSpacing = 5
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: "NormalCollectionViewCell")
        return pagerView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(pagerView)
        pagerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }

}

// MARK: - FSPagerViewDataSource
extension CollectionViewStyle1ViewController: FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "NormalCollectionViewCell", at: index)
        if let cell = cell as? NormalCollectionViewCell {
            cell.title = "\(index)"
        }
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension CollectionViewStyle1ViewController: FSPagerViewDelegate {
    
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
}
