//
//  AFNetworkingViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/9.
//

import UIKit
import AFNetworking

class AFNetworkingViewController: ListViewController {
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "初级", rowItems: [
                ListRowItem(title: "原生", tapAction: {
                    guard let url = URL(string: "https://www.baidu.com") else { return }
                    
                    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
                    let task = session.dataTask(with: url) { data, response, error in
                        print("whaley log -- 111")
                    }
                    task.resume()
                }),
                ListRowItem(title: "DataTask", tapAction: {
                    let sessionManager = AFHTTPSessionManager.init()
                    sessionManager.responseSerializer.acceptableContentTypes = ["image/jpeg"]
                    sessionManager.get("https://t7.baidu.com/it/u=2168645659,3174029352&fm=193&f=GIF", parameters: nil, headers: [:]) { progress in
                        Logger.info("进度：\(progress)")
                    } success: { dataTask, item in
                        Logger.info("成功")
                    } failure: { dataTask, error in
                        Logger.info("失败：\(error.localizedDescription)")
                    }
                })
            ])
        ]
    }
    
    private func dataTaskTest() {
        print("whaley log -- kkkk")
    }

}
