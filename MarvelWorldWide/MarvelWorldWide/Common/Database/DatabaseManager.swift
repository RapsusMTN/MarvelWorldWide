//
//  DatabaseManager.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation


/**
 Singleton pattern to manage persistance operations between app
 */
final class DatabaseManager: NSObject {
    
    // MARK: - Properties
    private struct Static {
        static var instance: DatabaseManager?
    }
    
    /// Singleton Instance
    static var shared: DatabaseManager {
        if Static.instance == nil {
            Static.instance = DatabaseManager()
        }
        return Static.instance!
    }
    
    // MARK: - Functions
    func saveCharacterDetail(_ model: CharacterModel) throws  {
        let uniqueKey = model.id
        
        do {
            let encodedModel = try JSONEncoder().encode(model)
            UserDefaults.standard.setValue(encodedModel, forKey: String(uniqueKey))
        } catch {
            throw MWNetworkError.parserError(message: error.localizedDescription)
        }
    }
    
    func getCharacterDetail(_ characterId: Int) throws -> CharacterModel {
        guard let characterDetailData = UserDefaults.standard.value(forKey: String(characterId)) as? Data else {
            throw MWNetworkError.saveModelDataBaseError
        }
        
        do {
            let decodedModel = try JSONDecoder().decode(CharacterModel.self, from: characterDetailData)
            return decodedModel
        } catch {
            throw MWNetworkError.getModelDataBaseError
        }
    }
            
    func saveRelatedElement(_ type: RelatedElementType, _ characterId: Int, model: [RelatedElementModel]) throws {
        let key = type == .comic ? "Comics\(characterId)" : "Series\(characterId)"
        
        do {
            let encodedModel = try JSONEncoder().encode(model)
            UserDefaults.standard.setValue(encodedModel, forKey: String(key))
        } catch {
            throw MWNetworkError.parserError(message: error.localizedDescription)
        }
    }
    
    func getRelatedElement(type: RelatedElementType ,_ characterId: Int) throws -> [RelatedElementModel] {
        let key = type == .comic ? "Comics\(characterId)" : "Series\(characterId)"
        
        guard let characterDetailData = UserDefaults.standard.value(forKey: key) as? Data else {
            throw MWNetworkError.saveModelDataBaseError
        }
        
        do {
            let decodedModel = try JSONDecoder().decode([RelatedElementModel].self, from: characterDetailData)
            return decodedModel
        } catch {
            throw MWNetworkError.getModelDataBaseError
        }
    }
}
