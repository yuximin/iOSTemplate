//
//  XMCache.swift
//  iOSTemplate
//
//  Created by apple on 2023/6/23.
//

import UIKit

public class XMCache {
    
    public let cachePath: String
    
    private let fileManager: FileManager = FileManager.default
    
    public init(cachePath: String) {
        self.cachePath = cachePath
    }
    
    public init(identifier: String) {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        self.cachePath = ((path as NSString).appendingPathComponent("com.XDownloader.cache") as NSString).appendingPathComponent(identifier)
    }
    
    func saveFile(from location: URL, targetName: String, completion: ((Result<String, Error>) -> Void)? = nil) {
        if !fileManager.fileExists(atPath: self.cachePath) {
            do {
                try fileManager.createDirectory(atPath: self.cachePath, withIntermediateDirectories: true)
            } catch {
                completion?(.failure(XDownloadError.cacheError(reason: .cannotCreateDirectory(path: self.cachePath, error: error))))
            }
        }
        
        var fileURL = URL(fileURLWithPath: self.cachePath)
        fileURL.appendPathComponent(targetName)
        
        do {
            try fileManager.moveItem(at: location, to: fileURL)
            completion?(.success(fileURL.absoluteString))
        } catch {
            completion?(.failure(XDownloadError.cacheError(reason: .cannotMoveItem(atPath: location.absoluteString, toPath: fileURL.absoluteString, error: error))))
        }
    }
}

extension XMCache {
    public func filePath(fileName: String) -> String? {
        if fileName.isEmpty {
            return nil
        }
        
        let path = (cachePath as NSString).appendingPathComponent(fileName)
        return path
    }
    
    public func fileExists(fileName: String) -> Bool {
        guard let path = filePath(fileName: fileName) else { return false }
        return fileManager.fileExists(atPath: path)
    }
    
    public func sizeOfCache() -> Double {
        guard fileManager.fileExists(atPath: self.cachePath),
              let files = fileManager.subpaths(atPath: self.cachePath),
              !files.isEmpty else { return 0 }
        
        var size: Double = 0
        for file in files {
            let fullPath = (self.cachePath as NSString).appendingPathComponent(file)
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: fullPath, isDirectory: &isDirectory),
               !isDirectory.boolValue,
               let fileAttributes = try? fileManager.attributesOfItem(atPath: fullPath) {
                if let fileSize = fileAttributes[FileAttributeKey.size] as? Double {
                    size += fileSize
                }
            }
        }
        return size
    }
    
    public func clearCache(completion: ((Result<Void, Error>) -> Void)? = nil) {
        do {
            try fileManager.removeItem(atPath: self.cachePath)
            completion?(.success(()))
        } catch {
            completion?(.failure(XDownloadError.cacheError(reason: .readDataFailed(path: self.cachePath))))
        }
    }
}
