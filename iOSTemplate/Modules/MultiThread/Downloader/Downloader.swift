//
//  Downloader.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import Foundation

class Downloader {
    
    static let shared = Downloader()
    
    private let maxConcurrentOperationCount = 5
    
    let downloadOperationQueue = OperationQueue()
    
    // MARK: - init
    
    init() {
        setupConfig()
    }
    
    private func setupConfig() {
        downloadOperationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
    // MARK: - public
    
    func addDownloadOperation(_ operation: DownloadOperation) {
        downloadOperationQueue.addOperation(operation)
    }
    
    func cancelAllDownloadOperations() {
        downloadOperationQueue.cancelAllOperations()
    }
    
}
