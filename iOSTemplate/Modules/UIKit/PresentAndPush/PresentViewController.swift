//
//  PresentViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/19.
//

import UIKit

class PresentViewController: UIViewController {
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    // MARK: - view
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
