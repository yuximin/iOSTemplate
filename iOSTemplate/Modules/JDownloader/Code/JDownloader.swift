//
//  JDownloader.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/10.
//

import Foundation

public class JDownloader: NSObject {
    
    public typealias CompletionHandler = (Result<String, Error>) -> Void
    
    private var session: URLSession?
    
    private let cache: XMCache
    
    private var downloadTasks: [XMDownloadTask] = []
    
    // MARK: - init
    
    init(cache: XMCache) {
        self.cache = cache
        super.init()
        
        let delegateQueue = OperationQueue()
        delegateQueue.maxConcurrentOperationCount = 1
        self.session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: delegateQueue)
    }
}

// MARK: - interface
extension JDownloader {
    public func downloadFileWithURL(_ url: URL, cache: XMCache? = nil, completion: CompletionHandler? = nil) {
        guard let session = self.session else { return }
        
        let downloadTask: XMDownloadTask
        if let cacheDownloadTask = self.downloadTasks.first(where: { $0.url == url }) {
            downloadTask = cacheDownloadTask
        } else {
            let useCache = cache ?? self.cache
            let task = session.downloadTask(with: URLRequest(url: url))
            downloadTask = XMDownloadTask(url: url, task: task, cache: useCache)
            self.downloadTasks.append(downloadTask)
        }
        
        if let completion = completion {
            downloadTask.appendCompletionHandler(completion)
        }
        
        if downloadTask.state == .completed {
            return
        }
        
        if downloadTask.state != .running {
            downloadTask.resume()
        }
    }
}

// MARK: - URLSessionDownloadDelegate
extension JDownloader: URLSessionDownloadDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        Logger.info("URLSessionDownloadDelegate didCompleteWithError:", error?.localizedDescription ?? "nil")
        
        guard let error = error,
              let downloadTask = (task as? URLSessionDownloadTask),
              let xmDownloadTask = self.downloadTasks.first(where: { $0.taskIdentifier == downloadTask.taskIdentifier }) else { return }
        
        xmDownloadTask.executeCompletionHandlers(result: .failure(error))
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        Logger.info("URLSessionDownloadDelegate didFinishDownloadingTo:", location.absoluteString)
        
        guard let task = self.downloadTasks.first(where: { $0.taskIdentifier == downloadTask.taskIdentifier }) else { return }
        
        task.saveFile(from: location)
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        Logger.info("URLSessionDownloadDelegate didWriteData:", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite, CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite))
    }
}
