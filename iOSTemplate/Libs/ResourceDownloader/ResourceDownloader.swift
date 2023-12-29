//
//  ResourceDownloader.swift
//  ResourceService
//
//  Created by ZhangHong on 2023/10/25.
//

import Foundation
import Alamofire

class ResourceDownloader {
    
    static let shared: ResourceDownloader = ResourceDownloader()
    
    private let session = {
        
        let session = Session()
        
        return session
    }()
    
    func downloadData(_ url: String,
                      queue: DispatchQueue = .main,
                      completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        let request = self.session.request(url)
        
        request.responseData(queue: queue, completionHandler: { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
                
            case .success(let data):
                
                completionBlock(.success(data))
            case .failure(let error):
                
                completionBlock(.failure(error))
            }
        })
    }
}
