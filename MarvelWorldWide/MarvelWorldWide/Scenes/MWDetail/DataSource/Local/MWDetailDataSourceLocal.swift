//
//  MWDetailDataSourceLocal.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

class MWDetailDataSourceLocal: MWDetailDataSourceLocalProtocol {
    
    // MARK: - Properties
    
    // MARK: - Init
    init() {}
    
    // MARK: - Functions
    func saveCharacterDetail(_ model: CharacterModel) throws {
        try DatabaseManager.shared.saveCharacterDetail(model)
    }
    
    func getCharacterDetail(_ characterId: Int) throws -> CharacterModel {
        try DatabaseManager.shared.getCharacterDetail(characterId)
    }
    
    func saveRelatedElements(characterId: Int, type: RelatedElementType, _ model: [RelatedElementModel]) throws {
        try DatabaseManager.shared.saveRelatedElement(type, characterId, model: model)
    }
    
    func getRelatedElements(type: RelatedElementType, _ characterId: Int) throws -> [RelatedElementModel] {
        try DatabaseManager.shared.getRelatedElement(type: type, characterId)
    }
}
