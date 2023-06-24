//
//  XMCache.swift
//  iOSTemplate
//
//  Created by apple on 2023/6/23.
//

import UIKit

public class XMCache {
    let downloadPath: String
    
    private let fileManager: FileManager
    
    init(downloadPath: String) {
        self.downloadPath = downloadPath
        self.fileManager = FileManager.default
    }
    
    init(identifier: String) {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        self.downloadPath = (path as NSString).appendingPathComponent(identifier)
        self.fileManager = FileManager.default
    }
    
    func saveFile(from location: URL, targetName: String) {
        if !fileManager.fileExists(atPath: self.downloadPath) {
            do {
                try fileManager.createDirectory(atPath: self.downloadPath, withIntermediateDirectories: true)
            } catch {
                Logger.error("[XMCache] Create directory error:", error.localizedDescription)
            }
        }
        
        var fileURL: URL
        if #available(iOS 16.0, *) {
            fileURL = URL(filePath: self.downloadPath)
            fileURL.append(path: targetName)
        } else {
            fileURL = URL(fileURLWithPath: self.downloadPath)
            fileURL.appendPathComponent(targetName)
        }
        
        do {
            try fileManager.moveItem(at: location, to: fileURL)
        } catch {
            Logger.error("[XMCache] Move file error:", error.localizedDescription)
        }
    }
}
