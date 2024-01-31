//
//  XMSessionTask.swift
//  XDownloader
//
//  Created by apple on 2024/1/5.
//

import Foundation

class XMSessionTask {
    
    public typealias CallbackToken = Int

    struct TaskCallback {
        let onCompleted: () -> Void
        let queue: DispatchQueue
    }
    
    let task: URLSessionDataTask
    
    private let lock = NSLock()
    
    private var callbacksStore = [CallbackToken: TaskCallback]()

    var callbacks: [TaskCallback] {
        lock.lock()
        defer { lock.unlock() }
        return Array(callbacksStore.values)
    }
    
    private var currentToken = 0
    private var started = false
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
    
    func addCallback(_ callback: TaskCallback) -> CallbackToken {
        lock.lock()
        defer { lock.unlock() }
        callbacksStore[currentToken] = callback
        defer { currentToken += 1 }
        return currentToken
    }

    func removeCallback(_ token: CallbackToken) -> TaskCallback? {
        lock.lock()
        defer { lock.unlock() }
        if let callback = callbacksStore[token] {
            callbacksStore[token] = nil
            return callback
        }
        return nil
    }

    func resume() {
        guard !started else { return }
        started = true
        task.resume()
    }

    func cancel(token: CallbackToken) {
        guard let callback = removeCallback(token) else {
            return
        }
//        onCallbackCancelled.call((token, callback))
    }

    func forceCancel() {
        for token in callbacksStore.keys {
            cancel(token: token)
        }
    }

    func didReceiveData(_ data: Data) {
//        mutableData.append(data)
    }
}
