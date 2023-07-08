//
//  XDownloader.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/10.
//

import Foundation

public class XDownloader: NSObject {
    
    public typealias ProgressHandler = (Progress) -> Void
    public typealias CompletionHandler = (Result<String, Error>) -> Void
    
    private var session: URLSession?
    private let cache: XMCache
    public let operationQueue: DispatchQueue
    private var downloadTasks: [XMDownloadTask] = []
    
    // MARK: - init
    
    public init(identifier: String) {
        self.cache = XMCache(identifier: identifier)
        self.operationQueue = DispatchQueue(label: "com.XDownloader.operationQueue.\(identifier)")
        super.init()
        
        let delegateQueue = OperationQueue()
        delegateQueue.maxConcurrentOperationCount = 1
        delegateQueue.underlyingQueue = self.operationQueue
        delegateQueue.name = "com.XDownloader.delegateQueue.\(identifier)"
        self.session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: delegateQueue)
    }
}

// MARK: - interface
extension XDownloader {
    public func downloadFileWithURLConvertible(_ urlConvertible: URLConvertible, progress: ProgressHandler? = nil, completion: CompletionHandler? = nil) {
        self.operationQueue.async {
            guard let session = self.session,
                  let url = try? urlConvertible.asURL() else { return }
            
            let fileName = url.lastPathComponent
            if self.cache.fileExists(fileName: fileName),
               let cachePath = self.cache.filePath(fileName: fileName) {
                completion?(.success(cachePath))
                return
            }
            
            let downloadTask: XMDownloadTask
            if let cacheDownloadTask = self.downloadTasks.first(where: { $0.url == url }) {
                downloadTask = cacheDownloadTask
            } else {
                let task = session.downloadTask(with: URLRequest(url: url))
                downloadTask = XMDownloadTask(url: url, task: task, cache: self.cache)
                downloadTask.resume()
                self.downloadTasks.append(downloadTask)
            }
            
            downloadTask.appendProgressHandler(progress)
            downloadTask.appendCompletionHandler(completion)
        }
    }
}

// MARK: - URLSessionDownloadDelegate
extension XDownloader: URLSessionDownloadDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error,
              let downloadTask = (task as? URLSessionDownloadTask),
              let xDownloadTask = self.downloadTasks.first(where: { $0.taskIdentifier == downloadTask.taskIdentifier }) else { return }
        
        xDownloadTask.executeCompletionHandlers(result: .failure(error), shouldClear: true)
        self.downloadTasks.removeAll { $0.url == xDownloadTask.url }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let xDownloadTask = self.downloadTasks.first(where: { $0.taskIdentifier == downloadTask.taskIdentifier }) else { return }
        
        xDownloadTask.saveFile(from: location) { [weak self, weak xDownloadTask] result in
            xDownloadTask?.executeCompletionHandlers(result: result, shouldClear: true)
            self?.downloadTasks.removeAll { $0.url == xDownloadTask?.url }
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let xDownloadTask = self.downloadTasks.first(where: { $0.taskIdentifier == downloadTask.taskIdentifier }) else { return }
        
        let progress = Progress()
        progress.completedUnitCount = totalBytesWritten
        progress.totalUnitCount = totalBytesExpectedToWrite
        xDownloadTask.executeProgressHandlers(progress: progress)
    }
}
