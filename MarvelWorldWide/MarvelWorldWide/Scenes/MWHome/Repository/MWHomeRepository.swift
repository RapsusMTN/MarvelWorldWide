//
//  MWHomeRepository.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

class MWHomeRepository: MWHomeRepositoryProtocol {
    
    // MARK: - Properties
    var dataSourceAPI: MWHomeDataSourceAPIProtocol
    
    // MARK: - Init
    init(dataSourceAPI: MWHomeDataSourceAPIProtocol) {
        self.dataSourceAPI = dataSourceAPI
    }
    
    // MARK: - Functions
    func getMarvelCharacterList(name: String?, offset: Int, completionBlock: @escaping (Result<[CharacterModel], MWNetworkError>) -> Void) {
        
        dataSourceAPI.getMarvelCharacterList(name: name, offset: offset) { result in
            switch result {
            case .success(let characters):
                completionBlock(.success(characters))
            case .failure(let mwNetworkError):
                completionBlock(.failure(mwNetworkError))
            }
        }
    }
    
    
    // MARK: - DataBase Functions
//    private func getCharacterListFromCache() -> [CharacterModel] {
//        
//        
//        
//    }
    
}
