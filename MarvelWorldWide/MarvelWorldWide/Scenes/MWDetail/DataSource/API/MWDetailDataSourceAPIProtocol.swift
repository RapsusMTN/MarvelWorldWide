//
//  MWDetailDataSourceAPIProtocol.swift
//  MarvelWorldWideApp
//
//  Created by akreyers on 16/4/22.
//

import Foundation

public protocol MWDetailDataSourceAPIProtocol: AnyObject {
    // MARK: - Functions
    func getMarvelCharacterDetail(characterId: Int, completionBlock: @escaping (Result<CharacterModel, MWNetworkError>) -> Void)
    func getRelatedSerieCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void)
    func getRelatedComicCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void)
}
