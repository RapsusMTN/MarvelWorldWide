//
//  URLComponentExtension.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
import CryptoSwift
/**
 This extension creates the secure params or others to RequestFactory class
*/
extension URLComponents {
    mutating func addSecureHashIntoQueryParam() {
        let ts = Int(Date().timeIntervalSince1970)
        let publicAPIKey = EnvironmentProperty.PUBLIC_API_KEY
        let privateApiKey = EnvironmentProperty.PRIVATE_API_KEY
        let fullExpression = String(ts) + privateApiKey + publicAPIKey
        
        self.addQueryParam(name: Constant.hash, value: fullExpression.md5())
    }
    
    mutating func addTimestamp() {
        addQueryParam(name: Constant.timestamp, value: String(Int(Date().timeIntervalSince1970)))
    }
    
    mutating func addPublicApiKey() {
        addQueryParam(name: Constant.apiKey, value: EnvironmentProperty.PUBLIC_API_KEY)
    }
    
    mutating func addQueryParam(name: String, value: String) {
        self.queryItems?.append(URLQueryItem(name: name, value: value))
    }
}
