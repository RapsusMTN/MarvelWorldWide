//
//  DatabaseManagerProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 24/4/22.
//

import Foundation

public protocol DatabaseManagerProtocol: AnyObject {
    func saveCharacterDetail(_ model: CharacterModel) throws
    func getCharacterDetail(_ characterId: Int) throws -> CharacterModel
    func saveRelatedElement(_ type: RelatedElementType, _ characterId: Int, model: [RelatedElementModel]) throws
}
