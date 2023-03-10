//
//  PagTestViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/3/6.
//

import UIKit

class PagTestViewController: UIViewController {
    
    /// 类型 0-固定麦位，1-滑动麦位
    private var type: Int = 0
    
    /// 个数
    private var pagNumber: Int = 20
    
    /// 资源是否为空
    private var isEmpty: Bool = false
    
    private var pagFileNames: [String] = []

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        resetPagFiles()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(sortButton)
        sortButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - view
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50.0, height: 50.0)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PagTestCell.self, forCellWithReuseIdentifier: "PagTestCell")
        return collectionView
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("数据重排", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSort(_:)), for: .touchUpInside)
        return button
    }()

}

// MARK: - action
extension PagTestViewController {
    @objc private func didTapSort(_ sender: UIButton) {
        sortPagFiles()
    }
}

extension PagTestViewController {
    private func resetPagFiles() {
        var fileNames: [String] = []
        for i in 0..<pagNumber {
            if isEmpty {
                fileNames.append("")
            } else {
//                fileNames.append("avatarFrame\(i)")
                fileNames.append("https://test-static.ohlaapp.cn/d/72d795054cb46d4223a988272aaf56c1.svga")
            }
        }
        
        pagFileNames = fileNames
        collectionView.reloadData()
    }
    
    private func sortPagFiles() {
        var fileNames = self.pagFileNames
        
        if self.isEmpty, fileNames.isEmpty {
            return
        }
        
        let temp = fileNames[0]
        for i in 0..<fileNames.count {
            if i + 1 >= fileNames.count {
                fileNames[i] = temp
            } else {
                fileNames[i] = fileNames[i + 1]
            }
        }
        
        pagFileNames = fileNames
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension PagTestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagFileNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagTestCell", for: indexPath)
        if let pagTestCell = cell as? PagTestCell {
            pagTestCell.resourceString = pagFileNames[indexPath.item]
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension PagTestViewController: UICollectionViewDelegate {
    
}
