//
//  URLSessionMock.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import Foundation

public class URLSessionMock: URLSession {
    
    var dataMock: Data?
    var statusCode: Int = 200
    var error: Error?
    
    public override var configuration: URLSessionConfiguration {
        return .default
    }
    
    public override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: request.allHTTPHeaderFields!)
        completionHandler(dataMock, response, error)
        return URLSession.shared.dataTask(with: request.url!)
    }
}
