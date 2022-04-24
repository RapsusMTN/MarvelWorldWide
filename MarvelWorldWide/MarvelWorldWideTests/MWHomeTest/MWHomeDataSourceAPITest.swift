//
//  MWHomeDataSourceAPITest.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import Foundation
import XCTest
@testable import MarvelWorldWide

class MWHomeDataSourceAPITest: XCTestCase {
    
    private var sessionMock: URLSessionMock!

    override func setUpWithError() throws {
        sessionMock = URLSessionMock()
    }

    override func tearDownWithError() throws {
    }
    
    func test_getMarvelCharacterList_ok() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_LIST_OK")

        let responseData = getMockFromBundle(name: "characterListResponseMock", bundleClass: self)
        
        sessionMock.dataMock = responseData
        sessionMock.statusCode = 200
        
        
        let dataSourceAPI = MWHomeDataSourceAPI(session: sessionMock)
        
        dataSourceAPI.getMarvelCharacterList(name: nil, offset: 0) { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.data.results.first?.id, 1009499)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getMarvelCharacterList_error() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_LIST_ERROR")

        let responseData = getMockFromBundle(name: "characterErrorResponseMock", bundleClass: self)
        
        sessionMock.dataMock = responseData
        sessionMock.statusCode = 404
        
        
        let dataSourceAPI = MWHomeDataSourceAPI(session: sessionMock)
        
        dataSourceAPI.getMarvelCharacterList(name: nil, offset: 0) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertEqual(mwNetworkError.description, "We couldn't find that character")
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
}
