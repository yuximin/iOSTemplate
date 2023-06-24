//
//  URLDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/5/29.
//

import UIKit
import Alamofire

class URLDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "URL"
        view.backgroundColor = .white
        
        test1()
        test2()
        test3()
//        qosQueues2()
    }
    
    private func test1() {
        guard let baseUrl = URL(string: "https://www.baidu.com") else { return }
        
        guard let fanyiUrl = URL(string: "fanyi/filename.json?type=1&time=20230529", relativeTo: baseUrl) else { return }
        
        print("baseUrl.absoluteString = ", baseUrl.absoluteString)
        print("baseUrl.relativeString = ", baseUrl.relativeString)
        print("fanyiUrl.absoluteString = ", fanyiUrl.absoluteString)
        print("fanyiUrl.relativeString = ", fanyiUrl.relativeString)
        
        print("fanyiUrl.pathComponents", fanyiUrl.pathComponents)
        print("fanyiUrl.lastPathComponent", fanyiUrl.lastPathComponent)
        print("fanyiUrl.pathExtension", fanyiUrl.pathExtension)
        print("fanyiUrl.query", fanyiUrl.query ?? "")
    }
    
    private func test2() {
//        guard let url = URL(string: "https://www.baidu.com/fanyi/resource?t=1111&c=5555") else { return }
        
        guard let baseUrl = URL(string: "https://www.baidu.com") else { return }
        
        guard let fanyiUrl = URL(string: "fanyi/filename.json?type=1&time=20230529", relativeTo: baseUrl) else { return }
        
        guard let urlComponents = URLComponents(url: fanyiUrl, resolvingAgainstBaseURL: false) else { return }
        
        print("")
//        let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "")
    }
    
    private func test3() {
        AF.request("https://www.baidu.com").response { response in
            print("")
        }
    }
    
    func qosQueues2() {
        let queue1 = DispatchQueue(label: "com.omg.td1", qos: .userInteractive)
        let queue2 = DispatchQueue(label: "com.omg.td2", qos: .utility)
        
        queue1.async {
            for j in 0..<10 {
                print("queue1异步队列执行--😊 \(j)")
            }
        }
        
        queue2.async {
            for k in 0..<10 {
                print("queue2异步队列执行--😢 \(k)")
            }
        }
        
        // 实践证明：`main queue`默认就有一个很高的权限
        for n in 0..<10 {
            print("main queue--🐤 \(n)")
        }
    }

}
