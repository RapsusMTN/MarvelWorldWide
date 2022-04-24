//
//  MWDetailDataSourceLocal.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import XCTest
@testable import MarvelWorldWide

class MWDetailDataSourceLocalTest: XCTestCase {
    
    var dataBaseManager: DatabaseManager!
    var dataSourceLocal: MWDetailDataSourceLocal!
    let expectedModel = CharacterModel(id: 1, name: "CharacterTest", welcomeDescription: "Description", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg"), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 2), series: Comics(available: 2, collectionURI: "", items: [], returned: 3), stories: Stories(available: 2, collectionURI: "", items: [], returned: 9), events: Comics(available: 2, collectionURI: "", items: [], returned: 3), urls: [])
    let expectedComicModel = RelatedElementModel(id: 2, title: "SpiderManComicTest", description: "Spiderman its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg"))
    let expectedSerieModel = RelatedElementModel(id: 4, title: "SpiderSerieTest", description: "The best serie test", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "pdf"))
    
    override func setUpWithError() throws {
        dataSourceLocal = MWDetailDataSourceLocal()
        dataBaseManager = DatabaseManager.shared
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_saveCharacterDetail_ok() throws {
        XCTAssertNoThrow(try dataSourceLocal.saveCharacterDetail(expectedModel))
        
        let modelPersisted = try dataBaseManager.getCharacterDetail(expectedModel.id)
        
        XCTAssertEqual(expectedModel.id, modelPersisted.id)
        XCTAssertEqual(expectedModel.name, modelPersisted.name)
        XCTAssertEqual(expectedModel.welcomeDescription, modelPersisted.welcomeDescription)
    }
    
    func test_getCharacterDetail_ok() throws {
        XCTAssertNoThrow(try dataSourceLocal.saveCharacterDetail(expectedModel))
        
        let modelPersisted = try dataSourceLocal.getCharacterDetail(expectedModel.id)
        XCTAssertEqual(expectedModel.id, modelPersisted.id)
        XCTAssertEqual(expectedModel.name, modelPersisted.name)
        XCTAssertEqual(expectedModel.welcomeDescription, modelPersisted.welcomeDescription)
    }
    
    func test_saveComicRelatedElements_ok() throws {
        XCTAssertNoThrow(try dataSourceLocal.saveRelatedElements(characterId: 10, type: .comic, [expectedComicModel]))
        
        let modelPersisted = try dataBaseManager.getRelatedElement(type: .comic, 10)
        
        let firstComic = try XCTUnwrap(modelPersisted.first)
        
        XCTAssertEqual(firstComic.id, expectedComicModel.id)
        XCTAssertEqual(firstComic.title, expectedComicModel.title)
        XCTAssertEqual(firstComic.description, expectedComicModel.description)
    }
    
    func test_saveSerieRelatedElements_ok() throws {
        XCTAssertNoThrow(try dataSourceLocal.saveRelatedElements(characterId: 8, type: .serie, [expectedSerieModel]))
        
        let modelPersisted = try dataBaseManager.getRelatedElement(type: .serie, 8)
        
        let firstSerie = try XCTUnwrap(modelPersisted.first)
        
        XCTAssertEqual(firstSerie.id, expectedSerieModel.id)
        XCTAssertEqual(firstSerie.title, expectedSerieModel.title)
        XCTAssertEqual(firstSerie.description, expectedSerieModel.description)
    }
    
    func test_getComicRelatedElements_ok() throws {
        XCTAssertNoThrow(try dataSourceLocal.saveRelatedElements(characterId: 14, type: .comic, [expectedComicModel]))
        
        let modelPersisted = try dataSourceLocal.getRelatedElements(type: .comic, 14)
        
        let firstComic = try XCTUnwrap(modelPersisted.first)
        
        XCTAssertEqual(firstComic.id, expectedComicModel.id)
        XCTAssertEqual(firstComic.title, expectedComicModel.title)
        XCTAssertEqual(firstComic.description, expectedComicModel.description)
    }
    
    func test_getSerieRelatedElements_ok() throws {
        XCTAssertNoThrow(try dataSourceLocal.saveRelatedElements(characterId: 15, type: .serie, [expectedSerieModel]))
        
        let modelPersisted = try dataSourceLocal.getRelatedElements(type: .serie, 15)
        
        let firstSerie = try XCTUnwrap(modelPersisted.first)
        
        XCTAssertEqual(firstSerie.id, expectedSerieModel.id)
        XCTAssertEqual(firstSerie.title, expectedSerieModel.title)
        XCTAssertEqual(firstSerie.description, expectedSerieModel.description)
    }
}
