//
//  MWHomeDataSourceAPI.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

class MWHomeDataSourceAPI: MWHomeDataSourceAPIProtocol {
    
    // MARK: - Properties
    let session: URLSession
    // Page Limit by default is 20 in API
    let defaultPageLimit = Constant.limit
    
    // MARK: - Init
    init(session: URLSession = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Services
    func getMarvelCharacterList(name: String?, offset: Int, completionBlock: @escaping (Result<[CharacterModel], MWNetworkError>) -> Void) {
        
        MWNetworkFacade.executeRequest(endpoint: MWHomeEndpoint.getMarvelCharacterList(limit: defaultPageLimit, offset: offset, startsWithName: name), model: CharacterModel.self, session: session) { result in
            switch result {
            case .success(let response):
                completionBlock(.success(response.data.results))
            case .failure(let mwNetworkError):
                completionBlock(.failure(mwNetworkError))
            }
        }
    }
}
