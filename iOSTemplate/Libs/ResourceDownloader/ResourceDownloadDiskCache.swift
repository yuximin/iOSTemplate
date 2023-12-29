//
//  ResourceDownloadDiskCache.swift
//  ResourceService
//
//  Created by ZhangHong on 2023/10/25.
//

import Foundation

public class ResourceDownloadDiskCache {
    
    public static let shared: ResourceDownloadDiskCache = ResourceDownloadDiskCache()
    
    init() {
                
        self.createCacheDirectoryIfNotExist(self.directory)
    }
    
    private let directory: String = {
        
        let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        return cachesDirectory + "/karawan/resource/"
    }()
    
    private func cacheKey(for url: String) -> String {
        
        var cacheKey = url.rd.md5
        
        let pathExtension = (url as NSString).pathExtension
        
        if pathExtension.isEmpty == false {
            
            cacheKey += "." + pathExtension
        }
        
        return cacheKey
    }
    
    func save(_ data: Data, for url: String) -> String? {
        
        let cacheKey = self.cacheKey(for: url)
        
        if cacheKey.count == 0 {
            
            return nil
        }
        
        guard let filePath = self.filePath(cacheKey) else { return nil }
        
        self.createCacheDirectoryIfNotExist(self.directory)
        
        if FileManager.default.createFile(atPath: filePath, contents: data) {
            
            return filePath
        } else {
            
            return nil
        }
    }
    
    public func isExists(for url: String) -> String? {
        
        let cacheKey = self.cacheKey(for: url)
        
        if cacheKey.count == 0 {
            
            return nil
        }
        
        guard let filePath = self.filePath(cacheKey) else { return nil }
        
        if FileManager.default.fileExists(atPath: filePath) {
            
            return filePath
        } else {
            
            return nil
        }
    }
    
    private func filePath(_ cacheKey: String) -> String? {
        
        if cacheKey.count == 0 {
            
            return nil
        }
        
        return self.directory + cacheKey
    }
    
    private func createCacheDirectoryIfNotExist(_ directory: String) {
        
        if FileManager.default.fileExists(atPath: directory) == false {
            
            do {
                
                try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
        }
    }
    
    public func clearCache() {
        
        DispatchQueue.global().async {
            
            do {
                
                try FileManager.default.removeItem(atPath: self.directory)
            } catch {
                
            }
        }
    }
}
