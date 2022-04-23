//
//  MWDetailRepository.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

class MWDetailRepository: MWDetailRepositoryProtocol {
    
    // MARK: - Properties
    var dataSourceAPI: MWDetailDataSourceAPIProtocol
    var dataSourceLocal: MWDetailDataSourceLocalProtocol
    
    // MARK: - Init
    init(dataSourceAPI: MWDetailDataSourceAPIProtocol, dataSourceLocal: MWDetailDataSourceLocalProtocol) {
        self.dataSourceAPI = dataSourceAPI
        self.dataSourceLocal = dataSourceLocal
    }
    
    // MARK: - Functions
    public func getMarvelCharacterDetail(characterId: Int, completionBlock: @escaping (Result<CharacterModel, MWNetworkError>) -> Void) {
        
        do {
            let characterCached = try dataSourceLocal.getCharacterDetail(characterId)
            completionBlock(.success(characterCached))
        } catch {
            dataSourceAPI.getMarvelCharacterDetail(characterId: characterId) { result in
                switch result {
                case .success(let characterDetail):
                    do {
                        try self.dataSourceLocal.saveCharacterDetail(characterDetail)
                    } catch let error {
                        print(error)
                    }
                    completionBlock(.success(characterDetail))
                case .failure(let mwNetworkError):
                    completionBlock(.failure(mwNetworkError))
                }
            }
        }
    }
    
    public func getRelatedComicCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void) {
        
        do {
            let characterCached = try dataSourceLocal.getRelatedElements(type: .comic, characterId)
            completionBlock(.success(characterCached))
        } catch {
            dataSourceAPI.getRelatedComicCharacter(characterId: characterId) { result in
                switch result {
                case .success(let comics):
                    do {
                        try self.dataSourceLocal.saveRelatedElements(characterId: characterId, type: .comic, comics)
                    } catch let error {
                        print(error)
                    }
                    completionBlock(.success(comics))
                case .failure(let mwNetworkError):
                    completionBlock(.failure(mwNetworkError))
                }
            }
        }
    }
    
    public func getRelatedSerieCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void) {
        
        do {
            let seriesCached = try dataSourceLocal.getRelatedElements(type: .serie, characterId)
            completionBlock(.success(seriesCached))
        } catch {
            dataSourceAPI.getRelatedSerieCharacter(characterId: characterId) { result in
                switch result {
                case .success(let series):
                    do {
                        try self.dataSourceLocal.saveRelatedElements(characterId: characterId, type: .serie, series)
                    } catch let error {
                        print(error)
                    }
                    completionBlock(.success(series))
                case .failure(let mwNetworkError):
                    completionBlock(.failure(mwNetworkError))
                }
            }
        }
    }
}
