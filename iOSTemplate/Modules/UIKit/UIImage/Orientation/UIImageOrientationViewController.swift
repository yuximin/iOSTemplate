//
//  UIImageOrientationViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/4.
//

import UIKit

class UIImageOrientationViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth = (UIScreen.main.bounds.size.width - 5.0 * 2) / 2
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(UIImageOrientationItemCell.self, forCellWithReuseIdentifier: "UIImageOrientationItemCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - UICollectionViewDataSource
extension UIImageOrientationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIImageOrientationItemCell", for: indexPath)
        if let cell = cell as? UIImageOrientationItemCell {
            cell.operation = UIImage.Orientation(rawValue: indexPath.item) ?? .up
        }
        return cell
    }
    
}
