//
//  ResourceDownloadManager.swift
//  ResourceService
//
//  Created by ZhangHong on 2023/10/25.
//

import Foundation

public class ResourceDownloadManager {
    
    public static let shared: ResourceDownloadManager = ResourceDownloadManager()
    
    init() {
        
    }
    
    private var runningOperations: [ResourceDownloadOperation] = []
    
    public func download(_ url: String, completionBlock: ResourceDownloadCompletionBlock?) {
        
        DispatchQueue.main.async {
            
            if url.isEmpty {
                
                completionBlock?(.failure(.urlEmpty))
                return
            }
            
            if let runningOperation = self.runningOperation(url) {
                
                if let completionBlock = completionBlock {
                    
                    runningOperation.add(completionBlock: completionBlock)
                }
            } else {
                
                let operation = ResourceDownloadOperation(url: url)
                
                if let completionBlock = completionBlock {
                    
                    operation.add(completionBlock: completionBlock)
                }
                
                self.runningOperations.append(operation)
                
                operation.start()
            }
        }
    }
    
    private func runningOperation(_ url: String) -> ResourceDownloadOperation? {
        
        for operation in self.runningOperations {
            
            if operation.url == url {
                
                return operation
            }
        }
        
        return nil
    }
    
    internal func remove(_ needRemoveOperation: ResourceDownloadOperation) {
        
        if let index = self.runningOperations.firstIndex(where: { $0 === needRemoveOperation }) {
            
            self.runningOperations.remove(at: index)
        }
    }
}
