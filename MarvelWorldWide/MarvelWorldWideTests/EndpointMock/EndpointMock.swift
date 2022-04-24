//
//  EndpointMock.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import Foundation
import MarvelWorldWide

public enum EndpointMock: MWEndpointProtocol {

    // MARK: - Service Definition
    case getMarvelCharacterList(limit: Int, offset: Int, startsWithName: String?)
    case getMarvelCharacterDetail(characterId: Int)
    case getRelatedComicCharacter(characterId: Int)
    case getRelatedSerieCharacter(characterId: Int)
    
    // MARK: - Configuration
    public var scheme: String {
        "https"
    }
    
    public var urlBase: String {
        "comic.test.com"
    }
    
    public var path: String {
        switch self {
        case .getMarvelCharacterDetail(let characterId):
            return "/v1/public/characters/\(characterId)"
        case .getRelatedComicCharacter(let characterId):
            return "/v1/public/characters/\(characterId)/comics"
        case .getRelatedSerieCharacter(let characterId):
            return "/v1/public/characters/\(characterId)/series"
        case .getMarvelCharacterList:
            return "/v1/public/characters"
        }
    }
    
    public var parametersUrl: [URLQueryItem]? {
        switch self {
        case .getMarvelCharacterList(let limit, let offset, let name):
            var queryParams = [URLQueryItem(name: "limit", value: String(limit)), URLQueryItem(name: "offset", value: String(offset))]
            if let name = name {
                queryParams.append(URLQueryItem(name: "startsWithName", value: name))
            }
            return queryParams
        default:
            return nil
        }
    }
    
    public var method: MWURLMethod {
        .GET
    }
    
    public var parametersBody: Data? {
        nil
    }
    
    public var contentType: MWContentType? {
        .json
    }
    
    public var headers: [String : String] {
        [:]
    }
}
