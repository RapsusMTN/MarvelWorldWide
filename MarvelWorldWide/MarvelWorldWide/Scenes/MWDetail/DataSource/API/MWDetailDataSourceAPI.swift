//
//  MWDetailDataSourceAPI.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public class MWDetailDataSourceAPI: MWDetailDataSourceAPIProtocol {
    
    // MARK: - Properties
    let session: URLSession
    // Page Limit by default is 20 in API
    let defaultPageLimit = Constant.limit
    
    // MARK: - Init
    init(session: URLSession = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Services
    public func getMarvelCharacterDetail(characterId: Int, completionBlock: @escaping (Result<CharacterModel, MWNetworkError>) -> Void) {
        
        MWNetworkFacade.executeRequest(endpoint: MWDetailEndpoint.getMarvelCharacterDetail(characterId: characterId), model: CharacterModel.self, session: session) { result in
            switch result {
            case .success(let response):
                guard let characterDetail = response.data.results.first else {
                    let mwNetworkError = MWNetworkError.error(message: "Detail not found!!")
                    completionBlock(.failure(mwNetworkError))
                    return
                }
                completionBlock(.success(characterDetail))
            case .failure(let mwNetworkError):
                completionBlock(.failure(mwNetworkError))
            }
        }
    }
    
    public func getRelatedComicCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void) {
        
        MWNetworkFacade.executeRequest(endpoint: MWDetailEndpoint.getRelatedComicCharacter(characterId: characterId), model: RelatedElementModel.self, session: session) { result in
            switch result {
            case .success(let response):
                completionBlock(.success(response.data.results))
            case .failure(let mwNetworkError):
                completionBlock(.failure(mwNetworkError))
            }
        }
    }
    
    public func getRelatedSerieCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void) {
        
        MWNetworkFacade.executeRequest(endpoint: MWDetailEndpoint.getRelatedSerieCharacter(characterId: characterId), model: RelatedElementModel.self, session: session) { result in
            switch result {
            case .success(let response):
                completionBlock(.success(response.data.results))
            case .failure(let mwNetworkError):
                completionBlock(.failure(mwNetworkError))
            }
        }
    }
}
