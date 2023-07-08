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
    private var progressHandlers: [XDownloader.ProgressHandler] = []
    private var completionHandlers: [XDownloader.CompletionHandler] = []
    
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
    
    func appendProgressHandler(_ progress: XDownloader.ProgressHandler?) {
        if let progress = progress {
            progressHandlers.append(progress)
        }
    }
    
    func executeProgressHandlers(progress: Progress) {
        for handler in progressHandlers {
            handler(progress)
        }
    }
    
    func clearProgressHandlers() {
        self.progressHandlers = []
    }
    
    func appendCompletionHandler(_ completion: XDownloader.CompletionHandler?) {
        if let completion = completion {
            self.completionHandlers.append(completion)
        }
    }
    
    func executeCompletionHandlers(result: Result<String, Error>, shouldClear: Bool) {
        for handler in completionHandlers {
            handler(result)
        }
        
        if shouldClear {
            clearProgressHandlers()
            clearCompletionHanders()
        }
    }
    
    func clearCompletionHanders() {
        self.completionHandlers = []
    }
    
    func saveFile(from location: URL, completion: ((Result<String, Error>) -> Void)? = nil) {
        cache.saveFile(from: location, targetName: url.lastPathComponent, completion: completion)
    }
}
