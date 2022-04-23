//
//  MWEndpointProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
/**
 This protocol must be implemented into all services declaration
 */
public protocol MWEndpointProtocol {
    /// Property with the part of the endpoint, will be concatenated to urlBase to forming complete url
    /// Scheme
    var scheme: String { get }
    /// UrlBase
    var urlBase: String { get }
    /// Path
    var path: String { get }
    /// Property will be send by header, example: ?param1=1&param2=2
    var parametersUrl: [URLQueryItem]? { get }
    /// Property url methods for the request: (GET,POST,DELETE...)
    var method: MWURLMethod { get }
    /// Property on the body, the format of its depends of the parameter  content type
    var parametersBody: Data? { get }
    /// ContentType
    var contentType: MWContentType? { get }
    /// Headers
    var headers: [String: String] { get }
}
