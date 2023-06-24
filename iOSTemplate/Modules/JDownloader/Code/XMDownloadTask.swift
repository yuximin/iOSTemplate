//
//  XMDownloadTask.swift
//  iOSTemplate
//
//  Created by apple on 2023/6/23.
//

import Foundation

class XMDownloadTask {
    let url: URL
    private let task: URLSessionDownloadTask
    private let cache: XMCache
    private var completionHandlers: [JDownloader.CompletionHandler] = []
    
    var taskIdentifier: Int {
        task.taskIdentifier
    }
    
    var state: URLSessionTask.State {
        task.state
    }
    
    init(url: URL, task: URLSessionDownloadTask, cache: XMCache) {
        self.url = url
        self.task = task
        self.cache = cache
    }
    
    func resume() {
        task.resume()
    }
    
    func suspend() {
        task.suspend()
    }
    
    func cancel() {
        task.cancel()
    }
    
    func appendCompletionHandler(_ completion: @escaping JDownloader.CompletionHandler) {
        completionHandlers.append(completion)
    }
    
    func executeCompletionHandlers(result: Result<String, Error>) {
        for completion in completionHandlers {
            completion(result)
        }
        
        clearCompletionHanders()
    }
    
    func clearCompletionHanders() {
        completionHandlers = []
    }
    
    func saveFile(from location: URL) {
        cache.saveFile(from: location, targetName: url.lastPathComponent)
    }
}
