//
//  MWHomeEndpoint.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

enum MWHomeEndpoint: MWEndpointProtocol {
    
    // MARK: - Service Definition
    case getMarvelCharacterList(limit: Int, offset: Int, startsWithName: String?)
    
    // MARK: - Configuration
    var scheme: String {
        Constant.scheme
    }
    
    var urlBase: String {
        EnvironmentProperty.MARVEL_URL_BASE_KEY
    }
    
    var path: String {
        switch self {
        case .getMarvelCharacterList:
            return "/v1/public/characters"
        }
    }
    
    var parametersUrl: [URLQueryItem]? {
        switch self {
        case .getMarvelCharacterList(let limit, let offset, let name):
            var queryParams = [URLQueryItem(name: Constant.pageLimit, value: String(limit)), URLQueryItem(name: Constant.offset, value: String(offset))]
            if let name = name {
                queryParams.append(URLQueryItem(name: Constant.name, value: name))
            }
            return queryParams
        }
    }
    
    var method: MWURLMethod {
        .GET
    }
    
    var parametersBody: Data? {
        nil
    }
    
    var contentType: MWContentType? {
        .json
    }
    
    var headers: [String : String] {
        [:]
    }
}
