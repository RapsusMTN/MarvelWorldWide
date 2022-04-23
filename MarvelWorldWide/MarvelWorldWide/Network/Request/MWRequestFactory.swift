//
//  MWRequestFactory.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/// Class responsible to create the request with custom endpoint (Enumeration that implement the endpoint protocol)
public class MWRequestFactory {
        
    /**
     Configure the request for the communication manager methods.
     
     - Parameter endpoint: Enumeration than implement the Endpoint protocol. Will be used to configure the request.
     - Parameter timeout: Timeout for the request
     
     - Returns: Configured request ready to use with communication manager
     
     - SeeAlso: Endpoint.swift
     */
    
    public static func setup(endpoint: MWEndpointProtocol, timeout: Double? = nil) -> URLRequest? {
        
        // Set the url for the request
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.urlBase
        components.path = endpoint.path
        
        // Default Marvel Query Items (Params)
        let queryItems: [URLQueryItem] = []
        components.queryItems = queryItems
        components.addTimestamp()
        components.addPublicApiKey()
        components.addSecureHashIntoQueryParam()
        
        if let parametersUrl = endpoint.parametersUrl {
            parametersUrl.forEach { param in
                components.queryItems?.append(param)
            }
        }
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Add Body
        urlRequest.httpBody = endpoint.parametersBody
        
        // Add Headers
        endpoint.headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        
        // Add ContentType
        if let contentType = endpoint.contentType {
            switch contentType {
            case .multipart:
                urlRequest.setValue("\(urlRequest.httpBody?.count ?? 0)", forHTTPHeaderField: "Content-Length")
            default:
                urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            }
        }
        return urlRequest
    }
}
