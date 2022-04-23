//
//  MWDetailDataSourceLocalProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWDetailDataSourceLocalProtocol: AnyObject {
    func saveCharacterDetail(_ model: CharacterModel) throws
    func getCharacterDetail(_ characterId: Int) throws -> CharacterModel
    func saveRelatedElements(characterId: Int, type: RelatedElementType, _ model: [RelatedElementModel]) throws
    func getRelatedElements(type: RelatedElementType, _ characterId: Int) throws -> [RelatedElementModel]
}
