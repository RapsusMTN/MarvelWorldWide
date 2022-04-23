//
//  MWDetailEndpoint.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

enum MWDetailEndpoint: MWEndpointProtocol {
    
    // MARK: - Service Definition
    case getMarvelCharacterDetail(characterId: Int)
    case getRelatedComicCharacter(characterId: Int)
    case getRelatedSerieCharacter(characterId: Int)
    
    // MARK: - Configuration
    var scheme: String {
        Constant.scheme
    }
    
    var urlBase: String {
        EnvironmentProperty.MARVEL_URL_BASE_KEY
    }
    
    var path: String {
        switch self {
        case .getMarvelCharacterDetail(let characterId):
            return "/v1/public/characters/\(characterId)"
        case .getRelatedComicCharacter(let characterId):
            return "/v1/public/characters/\(characterId)/comics"
        case .getRelatedSerieCharacter(let characterId):
            return "/v1/public/characters/\(characterId)/series"
        }
    }
    
    var parametersUrl: [URLQueryItem]? {
        nil
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
