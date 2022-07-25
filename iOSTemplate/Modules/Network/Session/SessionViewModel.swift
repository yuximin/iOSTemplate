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
    let mp4Url: String = "https://github.com/yuximin/StaticResources/raw/master/Mp4/HotAirBalloon.mp4"
    
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
    
    func downloadTask() {
        guard let url = URL(string: mp4Url) else { return }
        
        Logger.info("begin")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
        let task = session.downloadTask(with: url)
        Logger.info("resume")
        task.resume()
        Logger.info("end")
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

// MARK: - URLSessionDownloadDelegate
extension SessionViewModel: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        Logger.info("location:", location)
        let fileManager = FileManager.default
        var dstURL = location.deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Library/Caches", isDirectory: true).appendingPathComponent("a.mp4")
        do {
            try fileManager.moveItem(at: location, to: dstURL)
        } catch {
            Logger.error(error)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        Logger.info("bytesWritten:", bytesWritten, "totalBytesWritten:", totalBytesWritten, "totalBytesExpectedToWrite:", totalBytesExpectedToWrite)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        Logger.info("fileOffset:", fileOffset, "expectedTotalBytes:", expectedTotalBytes)
    }
}
