//
//  MWDetailRepositoryTest.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import XCTest
@testable import MarvelWorldWide

class MWDetailRepositoryTest: XCTestCase {
    
    var repository: MWDetailRepository!
    var dataSourceLocal: MWDetailDataSourceLocalMock!
    var dataSourceAPI: MWDetailDataSourceAPIMock!
    
    override func setUpWithError() throws {
        dataSourceAPI = MWDetailDataSourceAPIMock()
        dataSourceLocal = MWDetailDataSourceLocalMock()
        repository = MWDetailRepository(dataSourceAPI: dataSourceAPI, dataSourceLocal: dataSourceLocal)
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_getMarveCharacterDetailLocal_ok() {
        dataSourceLocal.activeCache = true
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_DETAIL_CACHE")
    
        repository.getMarvelCharacterDetail(characterId: 1) { result in
            switch result {
            case .success(let characterDetail):
                XCTAssertEqual(characterDetail.id, 1)
                XCTAssertEqual(characterDetail.name, "MockCharacterDetail")
                XCTAssertEqual(characterDetail.welcomeDescription, "Description Mock detail")
                XCTAssertEqual(characterDetail.thumbnail.path, "path/mock")
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getMarveCharacterDetailAPI_ok() {
        dataSourceLocal.activeCache = false
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_DETAIL_API")
    
        repository.getMarvelCharacterDetail(characterId: 1) { result in
            switch result {
            case .success(let characterDetail):
                XCTAssertEqual(characterDetail.id, 1)
                XCTAssertEqual(characterDetail.name, "CharacterTest")
                XCTAssertEqual(characterDetail.welcomeDescription, "Description")
                XCTAssertEqual(characterDetail.thumbnail.path, "pathTest")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getRelatedComicCharacterLocal_ok() {
        dataSourceLocal.activeCache = true
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_COMIC_CACHE")
    
        repository.getRelatedComicCharacter(characterId: 1) { result in
            switch result {
            case .success(let comics):
                let firstComic = try! XCTUnwrap(comics.first)
                XCTAssertEqual(firstComic.id, 2)
                XCTAssertEqual(firstComic.title, "Title1Mock")
                XCTAssertEqual(firstComic.description, "Description1Mock")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getRelatedComicCharacterAPI_ok() {
        dataSourceLocal.activeCache = false
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_COMIC_API")
    
        repository.getRelatedComicCharacter(characterId: 1) { result in
            switch result {
            case .success(let comics):
                let firstComic = try! XCTUnwrap(comics.first)
                XCTAssertEqual(firstComic.id, 2)
                XCTAssertEqual(firstComic.title, "SpiderManComicTest")
                XCTAssertEqual(firstComic.description, "Spiderman its amazing")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_test_getRelatedSerieCharacterLocal_ok() {
        dataSourceLocal.activeCache = true
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_SERIE_CACHE")
    
        repository.getRelatedSerieCharacter(characterId: 1) { result in
            switch result {
            case .success(let comics):
                let firstComic = try! XCTUnwrap(comics.first)
                XCTAssertEqual(firstComic.id, 2)
                XCTAssertEqual(firstComic.title, "Title1Mock")
                XCTAssertEqual(firstComic.description, "Description1Mock")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_test_getRelatedSerieCharacterAPI_ok() {
        dataSourceLocal.activeCache = false
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_SERIE_API")
    
        repository.getRelatedSerieCharacter(characterId: 1) { result in
            switch result {
            case .success(let comics):
                let firstComic = try! XCTUnwrap(comics.first)
                XCTAssertEqual(firstComic.id, 1)
                XCTAssertEqual(firstComic.title, "SpiderManComicTest")
                XCTAssertEqual(firstComic.description, "Spiderman its amazing")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
}

class MWDetailDataSourceAPIMock: MWDetailDataSourceAPIProtocol {
    func getMarvelCharacterDetail(characterId: Int, completionBlock: @escaping (Result<CharacterModel, MWNetworkError>) -> Void) {
        completionBlock(.success(CharacterModel(id: 1, name: "CharacterTest", welcomeDescription: "Description", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg"), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 2), series: Comics(available: 2, collectionURI: "", items: [], returned: 3), stories: Stories(available: 2, collectionURI: "", items: [], returned: 9), events: Comics(available: 2, collectionURI: "", items: [], returned: 3), urls: [])))
    }
    
    func getRelatedSerieCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void) {
        completionBlock(.success([RelatedElementModel(id: 1, title: "SpiderManComicTest", description: "Spiderman its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg")), RelatedElementModel(id: 6, title: "IronManComicTest", description: "IronMan its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg")), RelatedElementModel(id: 8, title: "TestComicTest", description: "TestComic its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg")), RelatedElementModel(id: 10, title: "MiauManComicTest", description: "Cat its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg"))]))
    }
    
    func getRelatedComicCharacter(characterId: Int, completionBlock: @escaping (Result<[RelatedElementModel], MWNetworkError>) -> Void) {
        completionBlock(.success([RelatedElementModel(id: 2, title: "SpiderManComicTest", description: "Spiderman its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg")), RelatedElementModel(id: 3, title: "IronManComicTest", description: "IronMan its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg")), RelatedElementModel(id: 4, title: "TestComicTest", description: "TestComic its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg")), RelatedElementModel(id: 5, title: "MiauManComicTest", description: "Cat its amazing", thumbnail: Thumbnail(path: "pathTest", thumbnailExtension: "jpg"))]))
    }
}

class MWDetailDataSourceLocalMock: MWDetailDataSourceLocalProtocol {
    
    var activeCache = false
    
    func saveCharacterDetail(_ model: CharacterModel) throws {
        
    }
    
    func getCharacterDetail(_ characterId: Int) throws -> CharacterModel {
        if activeCache {
            return CharacterModel(id: 1, name: "MockCharacterDetail", welcomeDescription: "Description Mock detail", thumbnail: Thumbnail(path: "path/mock", thumbnailExtension: "jpg"), resourceURI: "", comics: Comics(available: 7, collectionURI: "", items: [], returned: 5), series: Comics(available: 11, collectionURI: "", items: [], returned: 2), stories: Stories(available: 4, collectionURI: "", items: [], returned: 4), events: Comics(available: 3, collectionURI: "", items: [], returned: 5), urls: [])
        } else {
            throw MWNetworkError.getModelDataBaseError
        }
    }
    
    func saveRelatedElements(characterId: Int, type: RelatedElementType, _ model: [RelatedElementModel]) throws {
        
    }
    
    func getRelatedElements(type: RelatedElementType, _ characterId: Int) throws -> [RelatedElementModel] {
        if activeCache {
            return [RelatedElementModel(id: 2, title: "Title1Mock", description: "Description1Mock", thumbnail: Thumbnail(path: "path/mock1", thumbnailExtension: "pdf")), RelatedElementModel(id: 2, title: "Title1Mock", description: "Description1Mock", thumbnail: Thumbnail(path: "path/mock1", thumbnailExtension: "pdf")), RelatedElementModel(id: 2, title: "Title1Mock", description: "Description1Mock", thumbnail: Thumbnail(path: "path/mock1", thumbnailExtension: "pdf"))]
        } else {
            throw MWNetworkError.getModelDataBaseError
        }
        
    }
}
