//
//  CellPackageViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/6.
//

import UIKit

class CellPackageViewController: UIViewController {
    
    let viewModel = CellPackageViewModel()
    
    // MARK: - view
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellPackageCell.self, forCellWithReuseIdentifier: "CellPackageCell")
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        return collectionView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - UICollectionViewDataSource
extension CellPackageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellPackageCell", for: indexPath)
        if let cellPackageCell = cell as? CellPackageCell {
            let item = CellPackageItem(model: viewModel.models[indexPath.item])
            cellPackageCell.item = item
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension CellPackageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = viewModel.models[indexPath.item]
        return model.itemSize
    }
}
