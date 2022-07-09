//
//  DownloaderViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import UIKit

class DownloaderViewController: UITableViewController {
    
    let viewModel = DownloaderViewModel()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "下载器"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(didTapAdd(_:)))
    }
    
    // MARK: - action
    
    @objc private func didTapAdd(_ sender: Any) {
        Logger.info("添加下载")
    }

}

// MARK: - TableView Delegate
extension DownloaderViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
