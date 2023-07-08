//
//  XDownloadError.swift
//  XDownloader
//
//  Created by apple on 2023/6/26.
//

import Foundation

enum XDownloadError: Error {
    public enum CacheErrorReason {
        case cannotCreateDirectory(path: String, error: Error)
        case cannotRemoveItem(path: String, error: Error)
        case cannotCopyItem(atPath: String, toPath: String, error: Error)
        case cannotMoveItem(atPath: String, toPath: String, error: Error)
        case cannotRetrieveAllTasks(path: String, error: Error)
        case cannotEncodeTasks(path: String, error: Error)
        case fileNotExist(path: String)
        case readDataFailed(path: String)
        case clearCacheFailed(path: String)
    }
    
    case unknown
    case invalidURL(url: URLConvertible)
    case cacheError(reason: CacheErrorReason)
}

extension XDownloadError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "unkown error"
        case let .invalidURL(url):
            return "URL is not valid: \(url)"
        case let .cacheError(reason):
            return reason.errorDescription
        }
    }
}

extension XDownloadError.CacheErrorReason {
    public var errorDescription: String? {
        switch self {
        case let .cannotCreateDirectory(path, error):
            return "can not create directory, path: \(path), underlying: \(error)"
        case let .cannotRemoveItem(path, error):
            return "can not remove item, path: \(path), underlying: \(error)"
        case let .cannotCopyItem(atPath, toPath, error):
            return "can not copy item, atPath: \(atPath), toPath: \(toPath), underlying: \(error)"
        case let .cannotMoveItem(atPath, toPath, error):
            return "can not move item atPath: \(atPath), toPath: \(toPath), underlying: \(error)"
        case let .cannotRetrieveAllTasks(path, error):
            return "can not retrieve all tasks, path: \(path), underlying: \(error)"
        case let .cannotEncodeTasks(path, error):
            return "can not encode tasks, path: \(path), underlying: \(error)"
        case let .fileNotExist(path):
            return "file not exist, path: \(path)"
        case let .readDataFailed(path):
            return "read data failed, path: \(path)"
        case let .clearCacheFailed(path):
            return "clear cache failed, path: \(path)"
        }
    }
}
