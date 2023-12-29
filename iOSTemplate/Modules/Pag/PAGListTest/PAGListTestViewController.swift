//
//  PAGListTestViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/27.
//

import UIKit

class PAGListTestViewController: UIViewController {
    
    var avatarResourceURLs = [
        "https://test-static.ohlatech.com/d/5d6b4b93db3767ce671b7db94aaeb418.pag",
        "https://test-static.ohlatech.com/d/6bfb75255ef6add67abafd821a4f6a8b.pag",
        "https://test-static.ohlatech.com/d/93bfe49ef8dcbb24e915a19c4d87d6a5.pag",
        "https://test-static.ohlatech.com/d/facda634091cc39b436dd8a443f85cdd.pag",
        "https://test-static.ohlatech.com/d/c6f70c9bac7c871c5e0b8a5e4e75c636.pag",
        "https://test-static.ohlatech.com/d/6ff6ee6bd27f8e133203d35af5920d4f.pag",
        "https://test-static.ohlatech.com/d/f1296b6e5c6efe60e2a5f01a8d19f98b.pag",
        "https://test-static.ohlatech.com/d/0d05c403a8163ebe68c53b8c52e5e138.pag",
        "https://test-static.ohlatech.com/d/fa223fca1036a8cf18ff7aaf6dd9b586.pag",
        "https://test-static.ohlatech.com/d/eeab85ab2d11128634b881714fd87b8d.pag",
        "https://test-static.ohlatech.com/d/def7c352ed54e6122b04ca4e34e286d5.pag"
    ]
    
    var items: [(String, Int, Int)] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createItems()
        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createItems() {
        let count: Int = 500
        var items: [(String, Int, Int)] = []
        for _ in 0..<count {
            let avatarFrame = self.avatarResourceURLs[Int(arc4random()) % self.avatarResourceURLs.count]
            let vipLevel = Int(arc4random() % 15) + 1
            let level = Int(arc4random() % 150) + 1
            items.append((avatarFrame, vipLevel, level))
        }
        print("create items:", items)
        self.items = items
    }
    
    // MARK: - Lazy View
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(reusableCell: PAGListTestCell.self)
        return tableView
    }()
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PAGListTestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PAGListTestCell(style: .default, reuseIdentifier: "PAGListTestCell")
//        let cell: PAGListTestCell = tableView.dequeueReusableCell(for: indexPath)
        cell.row = indexPath.row
        cell.avatarResourceURL = self.items[indexPath.row].0
        cell.vipLevel = self.items[indexPath.row].1
        cell.level = self.items[indexPath.row].2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PAGListTestCell else { return }
        print("whaley log -- level:", cell.level)
        print("whaley log -- levelView isPlaying:", cell.levelView.isPlaying)
        print("whaley log -- levelView resourceURL:", cell.levelView.currentResourceUrl)
        print("whaley log -- levelView pagFile:", (cell.levelView.pagFile != nil))
        
        print("whaley log -- levelImageView resourceURL:", cell.levelImageView.currentRemoteURLString ?? "nil")
        print("whaley log -- levelImageView path:", cell.levelImageView.pagImageView?.getPath() ?? "nil")
        print("whaley log -- levelImageView isPlaying:", cell.levelImageView.pagImageView?.isPlaying() ?? false)
    }
}
