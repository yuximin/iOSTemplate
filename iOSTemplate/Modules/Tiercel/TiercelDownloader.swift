//
//  TiercelDownloader.swift
//  iOSTemplate
//
//  Created by apple on 2023/6/17.
//

import UIKit
import Tiercel

public class TiercelDownloader: NSObject {
    
    public typealias ProgressHandler = (Progress) -> Void
    public typealias CompletionHandler = (Result<String, Error>) -> Void
    
    private var progressHandlersMap: Protected<[DownloadTask: [ProgressHandler]]> = Protected([:])
    private var completionHandlersMap: Protected<[DownloadTask: [CompletionHandler]]> = Protected([:])
    
    private let cache: Cache
    private let sessionManager: SessionManager
    
    // MARK: - init
    
    public init(identifier: String, cacheDirectory: String) {
        let downloadPath = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent(cacheDirectory)
        let cache = Cache(identifier, downloadPath: downloadPath)
        self.cache = cache
        
        var configuration = SessionConfiguration()
        configuration.allowsCellularAccess = true
        self.sessionManager = SessionManager(identifier, configuration: configuration, cache: cache)
        super.init()
    }
    
    // MARK: - interface
    
    public func downloadFileWithURLString(_ urlString: String, progress: ProgressHandler? = nil, completion: CompletionHandler? = nil) {
        guard let task = sessionManager.download(urlString) else {
            completion?(.failure(DownloadError.createTaskFailure))
            return
        }
        
        // 注册进度回调
        if let progressHandler = progress {
            progressHandlersMap.write { map in
                if map[task] != nil {
                    map[task]?.append(progressHandler)
                } else {
                    map[task] = [progressHandler]
                }
            }
        }
        
        // 注册完成回调
        if let completionHandler = completion {
            completionHandlersMap.write { map in
                if map[task] != nil {
                    map[task]?.append(completionHandler)
                } else {
                    map[task] = [completionHandler]
                }
            }
        }
        
        task.progress(handler: { [weak self] task in
            self?.progressHandlersMap.write({ map in
                guard let handlers = map[task] else { return }
                
                for handler in handlers {
                    handler(task.progress)
                }
            })
        }).completion(handler: { [weak self] task in
            self?.progressHandlersMap.write({ map in
                map[task] = nil
            })
            
            self?.completionHandlersMap.write({ map in
                guard let handlers = map[task] else { return }
                
                for handler in handlers {
                    if task.status == .succeeded {
                        handler(.success(task.filePath))
                    } else {
                        let error = task.error ?? NSError(domain: "com.ohla.download", code: -100, userInfo: [NSLocalizedDescriptionKey: "unknown error"])
                        handler(.failure(error))
                    }
                }
                
                map[task] = nil
            })
        })
    }
}

public enum DownloadError: Error {
    case createTaskFailure
}

extension DownloadError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .createTaskFailure:
            return "Create task failure."
        }
    }
}
