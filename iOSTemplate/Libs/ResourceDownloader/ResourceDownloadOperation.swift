//
//  ResourceDownloadOperation.swift
//  ResourceService
//
//  Created by ZhangHong on 2023/10/25.
//

import Foundation

public typealias ResourceDownloadCompletionBlock = (Result<String, ResourceDownloadError>) -> Void

class ResourceDownloadOperation {
    
    init(url: String) {
        
        self.url = url
    }
    
    let url: String
    
    private var completionBlocks: [ResourceDownloadCompletionBlock] = []
    
    func add(completionBlock: @escaping ResourceDownloadCompletionBlock) {
        
        self.completionBlocks.append(completionBlock)
    }
    
    func start() {
        
        let url = self.url
        
        print("ResourceDownload-开始\(url)")
        
        if let filePath = ResourceDownloadDiskCache.shared.isExists(for: url) {

            print("ResourceDownload-取出缓存\(url)")
            
            self.success(filePath: filePath)
            
            return
        }
        
        ResourceDownloader.shared.downloadData(self.url) { [weak self] result in
            
            switch result {
            case .success(let data):
                
                DispatchQueue.global().async { [weak self] in
                    
                    let filePath = ResourceDownloadDiskCache.shared.save(data, for: url)
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        if let filePath = filePath {

                            print("ResourceDownload-下载成功\(url)")

                            self?.success(filePath: filePath)
                        } else {
                            
                            print("ResourceDownload-缓存失败\(url)")
                            
                            self?.failure(error: .saveFailure)
                        }
                    }
                }
            case .failure(let error):
                
                print("ResourceDownload-下载失败\(url)-\(error)")
                
                self?.failure(error: .downloadFailure)
            }
        }
    }
    
    func success(filePath: String) {
        
        ResourceDownloadManager.shared.remove(self)
        
        for completionBlock in self.completionBlocks {
            
            completionBlock(.success(filePath))
        }
    }
    
    func failure(error: ResourceDownloadError) {

        ResourceDownloadManager.shared.remove(self)
        
        for completionBlock in self.completionBlocks {
            
            completionBlock(.failure(error))
        }
    }
}
