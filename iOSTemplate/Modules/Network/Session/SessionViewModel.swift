//
//  SessionViewModel.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import Foundation

class SessionViewModel: NSObject {
    
    let delegateQueue = OperationQueue()
    
    let jsonUrl: String = "https://raw.githubusercontent.com/yuximin/StaticResources/master/Json/userInfo.json"
    
    func loadJson() {
        guard let url = URL(string: jsonUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.handleResult(data: data, response: response, error: error)
        }
        task.resume()
    }
    
    func loadJsonWithRequest() {
        guard let url = URL(string: jsonUrl) else { return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.handleResult(data: data, response: response, error: error)
        }
        task.resume()
    }
    
    func loadJsonWithCustomSession() {
        guard let url = URL(string: jsonUrl) else { return }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
        let task = session.dataTask(with: url)
        task.resume()
    }
    
}

// MARK: - helper
extension SessionViewModel {
    func handleResult(data: Data?, response: URLResponse?, error: Error?) {
        guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == 200 else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        handleData(data)
    }
    
    func handleData(_ data: Data) {
        do {
            if let jsonObject = (try JSONSerialization.jsonObject(with: data) as? [String: Any]) {
                Logger.info("Response data:", jsonObject)
            }
            
            let userInfo = try JSONDecoder().decode(UserInfoModel.self, from: data)
            Logger.info("Decode data succeed:", userInfo)
            
            let tempData = try JSONEncoder().encode(userInfo)
            Logger.info("Encode userInfo succeed:", tempData.count)
            
            let tempUserInfo = try JSONDecoder().decode(UserInfoModel.self, from: tempData)
            Logger.info("ReDecode data succeed:", tempUserInfo)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
}

// MARK: - URLSessionDataDelegate
extension SessionViewModel: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completionHandler(.cancel)
            return
        }
        
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        handleData(data)
    }
}
