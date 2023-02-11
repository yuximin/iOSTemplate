//
//  JDownloader.swift
//  iOSTemplate
//
//  Created by apple on 2023/2/10.
//

import Foundation

public class JDownloader: NSObject {
    
    private var count: Int = 0
    
    private var dataTask: URLSessionDataTask?
    
    private lazy var delegateQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    private lazy var session: URLSession = {
        URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: delegateQueue)
    }()
    
    private var fileHandle: FileHandle?
    
    private lazy var fileCachePath: String? = {
        guard var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return nil
        }
        
        
        path.append("/test.zip")
        Logger.info(path)
        return path
    }()
    
    override init() {
        super.init()
    }
    
}

// MARK: - interface
extension JDownloader {
    public func startDownloadWithURL(_ url: URL) {
        
        do {
            let data = try Data(contentsOf: url)
            Logger.info(data.count)
        } catch {
            Logger.error("获取Data错误")
        }
        
        let dataTask = session.dataTask(with: url)
        dataTask.resume()
        self.dataTask = dataTask
    }
    
    public func pauseDownload() {
        dataTask?.suspend()
    }
    
    public func resumeDownload() {
        dataTask?.resume()
    }
    
    public func cancelDownload() {
        dataTask?.cancel()
        dataTask = nil
    }
}

// MARK: - URLSessionDataDelegate
extension JDownloader: URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        Logger.info("URLSessionDelegate didReceive response: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
        
//        if let httpResponse = (response as? HTTPURLResponse) {
//            for item in httpResponse.allHeaderFields {
//                Logger.info("\(item.key): \(item.value)")
//            }
//        }
        
        guard let path = fileCachePath else {
            return
        }
        
        FileManager.default.createFile(atPath: path, contents: nil)
        
        if let handle = FileHandle(forWritingAtPath: path) {
            handle.seekToEndOfFile()
            self.fileHandle = handle
        }
        
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        Logger.info("URLSessionDelegate didReceive data: \(data.count) \(Thread.current)")
        
        self.fileHandle?.write(data)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        Logger.info("URLSessionDelegate didCompleteWithError: \(error?.localizedDescription ?? "nil")")
        self.fileHandle?.closeFile()
    }
}
