//
//  PagImageViewListViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/5/10.
//

import UIKit

class PagImageViewListViewController: UIViewController {
    
    var paths: [String] = []
    
    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPaths()
        setupUI()
    }
    
    // MARK: - ui
    
    private func createPaths() {
        var paths: [String] = []
        for i in 0..<10 {
            let fileName: String
            let num = i % 2
            switch num {
            case 0:
                fileName = "vip_badge_12"
            case 1:
                fileName = "vip_badge_13"
            default:
                fileName = "vip_badge_12"
            }
            if let path = Bundle.main.path(forResource: fileName, ofType: "pag") {
                paths.append(path)
            }
        }
        self.paths = paths
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(reloadButton)
        reloadButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - view
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 150
        tableView.dataSource = self
        tableView.register(PagImageViewListItemCell.self, forCellReuseIdentifier: "PagImageViewListItemCell")
        return tableView
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("重新加载", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
        return button
    }()
}

// MARK: - action
extension PagImageViewListViewController {
    @objc private func didTapReload() {
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PagImageViewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagImageViewListItemCell", for: indexPath)
        (cell as? PagImageViewListItemCell)?.playFileWithPath(paths[indexPath.row])
        return cell
    }
}
