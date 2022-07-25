//
//  Downloader.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import Foundation

class Downloader: NSObject {
    
    static let shared = Downloader()
    
    private let maxConcurrentOperationCount = 5
    
    private lazy var downloadOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
        return operationQueue
    }()
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: downloadOperationQueue)
        return session
    }()
    
    // MARK: - init
    
    override init() {
        super.init()
    }
    
    // MARK: - public
    
    func addDownloadOperation(_ operation: DownloadOperation) {
        downloadOperationQueue.addOperation(operation)
    }
    
    func cancelAllDownloadOperations() {
        downloadOperationQueue.cancelAllOperations()
    }
    
}

// MARK: - URLSessionDelegate
extension Downloader: URLSessionDelegate {
    
}

// MARK: - URLSessionDownloadTask
extension Downloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
}
