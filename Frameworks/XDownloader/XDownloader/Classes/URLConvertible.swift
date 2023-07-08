//
//  URLConvertible.swift
//  XDownloader
//
//  Created by apple on 2023/6/26.
//

import Foundation

public protocol URLConvertible {

    func asURL() throws -> URL
}

extension String: URLConvertible {
    
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw XDownloadError.invalidURL(url: self) }
        
        return url
    }
}

extension URL: URLConvertible {

    public func asURL() throws -> URL { return self }
}

extension URLComponents: URLConvertible {

    public func asURL() throws -> URL {
        guard let url = url else { throw XDownloadError.invalidURL(url: self) }
        
        return url
    }
}
