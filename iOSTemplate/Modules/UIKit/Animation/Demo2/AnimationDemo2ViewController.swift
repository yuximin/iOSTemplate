//
//  AnimationDemo2ViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/3/10.
//

import UIKit

class AnimationDemo2ViewController: UIViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - view
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 10
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(AnimationDemo2Cell.self, forCellWithReuseIdentifier: "AnimationDemo2Cell")
        return collectionView
    }()

}

// MARK: - UICollectionViewDataSource
extension AnimationDemo2ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt \(indexPath)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationDemo2Cell", for: indexPath)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension AnimationDemo2ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplayItem \(indexPath)")
        if let animationDemo2Cell = (cell as? AnimationDemo2Cell) {
            if let animationKeys = animationDemo2Cell.rotationView.layer.animationKeys() {
                print("willDisplayItem AnimationKeys:", animationKeys.joined(separator: ","))
                for animationKey in animationKeys {
                    if let animation = animationDemo2Cell.rotationView.layer.animation(forKey: animationKey) {
                        animationDemo2Cell.rotationView.layer.removeAnimation(forKey: animationKey)
                        animationDemo2Cell.rotationView.layer.add(animation, forKey: animationKey)
                        
                        if let animationKeys = animationDemo2Cell.rotationView.layer.animationKeys() {
                            print("willDisplayItem 111 AnimationKeys:", animationKeys.joined(separator: ","))
                        }
                    }
                }
            } else {
                print("willDisplayItem AnimationKeys: nil")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("didEndDisplayingItem \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80.0)
    }
}
