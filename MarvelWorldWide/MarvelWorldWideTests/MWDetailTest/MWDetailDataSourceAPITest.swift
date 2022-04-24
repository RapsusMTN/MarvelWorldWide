//
//  MWDetailDataSourceAPITest.swift
//  MarvelWorldWideAppTests
//
//  Created by akreyers on 19/4/22.
//

import XCTest
@testable import MarvelWorldWide

class MWDetailDataSourceAPITest: XCTestCase {
    
    var sessionMock: URLSessionMock!

    override func setUpWithError() throws {
        sessionMock = URLSessionMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getMarvelCharacterDetail_ok() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_DETAIL_OK")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterDetailResponseMock", bundleClass: self)
        let expectedCharacterDetail = CharacterModel(id: 1009499, name: "Polaris", welcomeDescription: "", thumbnail: Thumbnail(path: "", thumbnailExtension: ""), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 1), series: Comics(available: 1, collectionURI: "", items: [], returned: 2), stories: Stories(available: 1, collectionURI: "", items: [], returned: 2), events: Comics(available: 2, collectionURI: "", items: [], returned: 2), urls: [])
        
        sessionMock.statusCode = 200
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getMarvelCharacterDetail(characterId: 1009499) { result in
            switch result {
            case .success(let characterDetail):
                XCTAssertEqual(characterDetail.id, expectedCharacterDetail.id)
                XCTAssertEqual(characterDetail.name, expectedCharacterDetail.name)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getMarvelCharacterDetail_error() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_DETAIL_ERROR")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterErrorResponseMock", bundleClass: self)
        
        sessionMock.statusCode = 404
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getMarvelCharacterDetail(characterId: 23133232) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertNotNil(mwNetworkError)
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getMarverCharacterDetail_empty_error() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_DETAIL_EMPTY_ERROR")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterDetailEmptyResponseMock", bundleClass: self)
        
        sessionMock.statusCode = 200
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getMarvelCharacterDetail(characterId: 23133232) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertEqual(mwNetworkError.description, "Detail not found!!")
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
        
        
    }
    
    func test_getMarvelCharacterComic_ok() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_COMIC_OK")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterComicResponseMock", bundleClass: self)
        let expectedComic = RelatedElementModel(id: 3, title: "Avengers: The Initiative (2007) #19", description: "Join 3-D MAN, CLOUD 9, KOMODO, HARDBALL, and heroes around America in the battle that will decide the fate of the planet and the future of the Initiative program. Will the Kill Krew Army win the day?", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806", thumbnailExtension: "jpg"))
        
        sessionMock.statusCode = 200
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getRelatedComicCharacter(characterId: 1011334) { result in
            switch result {
            case .success(let comics):
                XCTAssertEqual(comics[0].title, expectedComic.title)
                XCTAssertEqual(comics[0].description, expectedComic.description)
                XCTAssertEqual(comics[0].thumbnail.path, expectedComic.thumbnail.path)
                XCTAssertEqual(comics[0].thumbnail.thumbnailExtension, expectedComic.thumbnail.thumbnailExtension)
                expectation.fulfill()
            case .failure(let mwNetworkError):
                XCTAssertNil(mwNetworkError)
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getMarvelCharacterComic_error() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_COMIC_ERROR")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterErrorResponseMock", bundleClass: self)
        
        sessionMock.statusCode = 404
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getRelatedComicCharacter(characterId: 2112131241343242423) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertNotNil(mwNetworkError)
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getRelatedCharacterSerie_ok() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_SERIE_OK")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterSerieResponseMock", bundleClass: self)
        let expectedSerie = RelatedElementModel(id: 1, title: "Avengers: The Initiative (2007 - 2010)", description: nil, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/514a2ed3302f5", thumbnailExtension: "jpg"))
        
        sessionMock.statusCode = 200
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getRelatedSerieCharacter(characterId: 1011334) { result in
            switch result {
            case .success(let series):
                XCTAssertEqual(series[0].title, expectedSerie.title)
                XCTAssertNil(series[0].description)
                XCTAssertEqual(series[0].thumbnail.path, expectedSerie.thumbnail.path)
                XCTAssertEqual(series[0].thumbnail.thumbnailExtension, expectedSerie.thumbnail.thumbnailExtension)
                expectation.fulfill()
            case .failure(let mwNetworkError):
                XCTAssertNil(mwNetworkError)
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }

    func test_getRelatedCharacterSerie_error() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_SERIE_ERROR")
        
        let dataSourceAPI = MWDetailDataSourceAPI(session: sessionMock)
        let responseData = getMockFromBundle(name: "characterErrorResponseMock", bundleClass: self)

        sessionMock.statusCode = 404
        sessionMock.dataMock = responseData
        
        dataSourceAPI.getRelatedSerieCharacter(characterId: 101133434545443543) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertNotNil(mwNetworkError)
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
}

