//
//  ResourceDownloadError.swift
//  ResourceService
//
//  Created by ZhangHong on 2023/10/25.
//

import Foundation

public enum ResourceDownloadError: Error {
    
    case urlEmpty    // url是空的
    case downloadFailure // 下载失败
    case saveFailure // 缓存失败
}

extension ResourceDownloadError {
    
    var message: String {
        
        switch self {
        case .urlEmpty:
            return "url是空的"
            
        case .downloadFailure:
            return "下载失败"
            
        case .saveFailure:
            return "缓存失败"
            
        }
    }
}
 
