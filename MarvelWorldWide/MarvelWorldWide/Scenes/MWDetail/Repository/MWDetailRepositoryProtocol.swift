//
//  MWDetailRepositoryProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWDetailRepositoryProtocol: AnyObject {
    func getMarvelCharacterDetail(characterId: Int, completionBlock: @escaping (Result<CharacterModel, MWNetworkError>) -> Void)
    func getRelatedComicCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void)
    func getRelatedSerieCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void)
}
