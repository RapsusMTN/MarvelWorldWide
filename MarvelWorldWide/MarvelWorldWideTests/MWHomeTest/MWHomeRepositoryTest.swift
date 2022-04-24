//
//  MWHomeRepositoryTest.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import XCTest
@testable import MarvelWorldWide

class MWHomeRepositoryTest: XCTestCase {

    var repository: MWHomeRepository!
    var dataSourceAPIMock: MWHomeDataSourceAPIErrorMock!
    
    override func setUpWithError() throws {
       dataSourceAPIMock = MWHomeDataSourceAPIErrorMock()
       repository = MWHomeRepository(dataSourceAPI: dataSourceAPIMock)
    }

    override func tearDownWithError() throws {

    }

    func test_getMarvelCharacterList_ok() throws {
        dataSourceAPIMock.isErrorActive = false
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_LIST_OK")
        
        repository.getMarvelCharacterList(name: nil, offset: 0) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)
    }
    
    func test_getMarvelCharacterList_error() throws {
        dataSourceAPIMock.isErrorActive = true
        
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACTER_LIST_ERROR")
        
        repository.getMarvelCharacterList(name: nil, offset: 0) { result in
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

class MWHomeDataSourceAPIErrorMock: MWHomeDataSourceAPIProtocol {
    
    var isErrorActive = false
    
    func getMarvelCharacterList(name: String?, offset: Int, completionBlock: @escaping (Result<ResponseModel<CharacterModel>, MWNetworkError>) -> Void) {
        if isErrorActive {
            completionBlock(.failure(MWNetworkError.error(message: "Error mock")))
        } else {
            completionBlock(.success(ResponseModel<CharacterModel>(code: 200, status: "OK", data: DataResponse(offset: 0, limit: 20, total: 1, count: 1, results: []))))
        }
    }
}
