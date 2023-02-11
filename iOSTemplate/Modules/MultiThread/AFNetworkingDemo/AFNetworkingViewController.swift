//
//  AFNetworkingViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/9.
//

import UIKit
import AFNetworking

class AFNetworkingViewController: ListViewController {

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            ListSection(title: "初级", rows: [
                ListRow(title: "原生"),
                ListRow(title: "DataTask")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension AFNetworkingViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("初级", "原生"):
            guard let url = URL(string: "https://www.baidu.com") else {
                break
            }
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            let task = session.dataTask(with: url) { data, response, error in
                print("whaley log -- 111")
            }
            task.resume()
            
        case ("初级", "DataTask"):
            let sessionManager = AFHTTPSessionManager.init()
            sessionManager.responseSerializer.acceptableContentTypes = ["image/jpeg"]
            sessionManager.get("https://t7.baidu.com/it/u=2168645659,3174029352&fm=193&f=GIF", parameters: nil, headers: [:]) { progress in
                Logger.info("进度：\(progress)")
            } success: { dataTask, item in
                Logger.info("成功")
            } failure: { dataTask, error in
                Logger.info("失败：\(error.localizedDescription)")
            }

        default:
            break
        }
    }
}

// MARK: - Method
extension AFNetworkingViewController {
    private func dataTaskTest() {
        print("whaley log -- kkkk")
    }
}
