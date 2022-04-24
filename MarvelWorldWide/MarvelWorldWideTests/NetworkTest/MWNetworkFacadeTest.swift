//
//  MWNetworkFacadeTest.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import Foundation
import XCTest
@testable import MarvelWorldWide

class MWNetworkFacadeTest: XCTestCase {
    
    private var sessionMock: URLSessionMock!

    override func setUpWithError() throws {
        sessionMock = URLSessionMock()
    }

    override func tearDownWithError() throws {}
    
    func test_execute_request_ok() {
        let expectation = XCTestExpectation(description: "EXECUTE_REQUEST_200_OK")
        let endpoint = EndpointMock.getMarvelCharacterDetail(characterId: 1)
        let responseData = getMockFromBundle(name: "characterListResponseMock", bundleClass: self)
        
        sessionMock.dataMock = responseData
        sessionMock.statusCode = 200
        
        MWNetworkFacade.executeRequest(endpoint: endpoint, model: CharacterModel.self, session: sessionMock) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.code, 200)
                expectation.fulfill()
            case .failure(let mwNetworkError):
                XCTFail(mwNetworkError.description)
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
        
    }
    
    func test_execute_request_decoded_error() {
        let expectation = XCTestExpectation(description: "EXECUTE_REQUEST_DECODER_ERROR")
        let endpoint = EndpointMock.getMarvelCharacterDetail(characterId: 1)
        let responseData = getMockFromBundle(name: "characterListWrongResponseMock", bundleClass: self)
        
        sessionMock.dataMock = responseData
        sessionMock.statusCode = 200
        
        MWNetworkFacade.executeRequest(endpoint: endpoint, model: CharacterModel.self, session: sessionMock) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertEqual(mwNetworkError.description, "Test_error_generic".localized())
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
        
    }
    
    func test_execute_request_error_404() {
        let expectation = XCTestExpectation(description: "EXECUTE_REQUEST_DECODER_ERROR")
        let endpoint = EndpointMock.getMarvelCharacterDetail(characterId: 1)
        let responseData = getMockFromBundle(name: "characterErrorResponseMock", bundleClass: self)
        let expectedError = MWNetworkError.error(message: "We couldn't find that character")
        
        sessionMock.dataMock = responseData
        sessionMock.statusCode = 404
        
        MWNetworkFacade.executeRequest(endpoint: endpoint, model: CharacterModel.self, session: sessionMock) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertEqual(mwNetworkError.description, expectedError.description)
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
        
    }
    
    func test_execute_request_decoded_error_404() {
        let expectation = XCTestExpectation(description: "EXECUTE_REQUEST_DECODER_ERROR_404")
        let endpoint = EndpointMock.getMarvelCharacterDetail(characterId: 1)
        let responseData = getMockFromBundle(name: "characterErrorDecodeResponseMock", bundleClass: self)
        
        sessionMock.dataMock = responseData
        sessionMock.statusCode = 404
        
        MWNetworkFacade.executeRequest(endpoint: endpoint, model: CharacterModel.self, session: sessionMock) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let mwNetworkError):
                XCTAssertEqual(mwNetworkError.description, "Test_error_generic".localized())
                expectation.fulfill()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
        
    }
}
