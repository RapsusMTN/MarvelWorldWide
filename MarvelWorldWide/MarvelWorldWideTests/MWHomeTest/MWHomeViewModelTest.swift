//
//  MWHomeViewModelTest.swift
//  MarvelWorldWideTests
//
//  Created by akreyers on 24/4/22.
//

import Foundation
import XCTest
@testable import MarvelWorldWide

class MWHomeViewModelTest: XCTestCase {
    
    var dataSourceAPIMock: MWHomeDataSourceAPIMock!
    var viewModel: MWHomeViewModel!

    override func setUpWithError() throws {
        dataSourceAPIMock = MWHomeDataSourceAPIMock()
        let view = MWHomeListViewControllerMock()
        let coordinator = MWHomeCoordinator(navigationController: UINavigationController())
        viewModel = MWHomeViewModel(dataSourceAPI: dataSourceAPIMock, view: view, coordinator: coordinator)
        view.viewModel = viewModel
        view.coordinator = coordinator
        
    }

    override func tearDownWithError() throws {
    }

    func test_getMarvelCharacterList_ok() {
        let expectation = XCTestExpectation(description: "GET_MARVEL_CHARACER_LIST_OK")
                
        viewModel.getMarvelCharacterList(isRefreshData: false) { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(self.viewModel.getCharacterList().count, characters.count)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(waiter, .completed)

    }
    
    func test_model_for_cell_ok() {
        let expectation = XCTestExpectation(description: "GET_MODEL_FOR_CELL_OK")
        
        viewModel.getMarvelCharacterList(isRefreshData: false) { result in
            switch result {
            case .success:
                let model = self.viewModel.modelForCellAt(1)
                XCTAssertEqual(model.title, "Test22")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func test_reset_offset_page_ok() {
        viewModel.resetOffsetPage()
        
        XCTAssertEqual(viewModel.getCurrentOffset(), 0)
        XCTAssertTrue(viewModel.getCharacterList().isEmpty)
    }
}

// MARK: - Mock
class MWHomeListViewControllerMock: BaseViewController, MWHomeListViewControllerProtocol {
    
    func reloadData(with newIndexPathsToReload: [IndexPath]?) {
        
    }
    
    var viewModel: MWHomeViewModelProtocol!
    
    var coordinator: MWHomeCoordinatorProtocol!
        
    override func showError(_ message: String) {
        
    }
    
    func reloadData() {
        
    }
    
    func hideNoContentView() {
        
    }
    
    func endRefreshData() {
        
    }
    
    func showNoContentView() {
        
    }
}

class MWHomeDataSourceAPIMock: MWHomeDataSourceAPIProtocol {
    func getMarvelCharacterList(name: String?, offset: Int, completionBlock: @escaping (Result<ResponseModel<CharacterModel>, MWNetworkError>) -> Void) {
        completionBlock(.success(responseMock))
    }
    
    let responseMock = ResponseModel<CharacterModel>(code: 200, status: "OK", data: DataResponse(offset: 0, limit: 20, total: 4, count: 4, results: [CharacterModel(id: 1, name: "Test1", welcomeDescription: "Description1", thumbnail: Thumbnail(path: "path/test", thumbnailExtension: "jpg"), resourceURI: "uri", comics: Comics(available: 1, collectionURI: "collectionURItest", items: [], returned: 2), series: Comics(available: 3, collectionURI: "test", items: [], returned: 2), stories: Stories(available: 2, collectionURI: "", items: [], returned: 2), events: Comics(available: 1, collectionURI: "test2", items: [], returned: 2), urls: []), CharacterModel(id: 1, name: "Test22", welcomeDescription: "Description1", thumbnail: Thumbnail(path: "path/test", thumbnailExtension: "jpg"), resourceURI: "uri", comics: Comics(available: 1, collectionURI: "collectionURItest", items: [], returned: 2), series: Comics(available: 3, collectionURI: "test", items: [], returned: 2), stories: Stories(available: 2, collectionURI: "", items: [], returned: 2), events: Comics(available: 1, collectionURI: "test2", items: [], returned: 2), urls: []), CharacterModel(id: 2, name: "Test2", welcomeDescription: "Description2", thumbnail: Thumbnail(path: "path/test", thumbnailExtension: "jpg"), resourceURI: "uri", comics: Comics(available: 1, collectionURI: "collectionURItest", items: [], returned: 2), series: Comics(available: 3, collectionURI: "test", items: [], returned: 2), stories: Stories(available: 2, collectionURI: "", items: [], returned: 2), events: Comics(available: 1, collectionURI: "test2", items: [], returned: 2), urls: []), CharacterModel(id: 3, name: "Test3", welcomeDescription: "Description3", thumbnail: Thumbnail(path: "path/test", thumbnailExtension: "jpg"), resourceURI: "uri", comics: Comics(available: 1, collectionURI: "collectionURItest", items: [], returned: 2), series: Comics(available: 3, collectionURI: "test", items: [], returned: 2), stories: Stories(available: 2, collectionURI: "", items: [], returned: 2), events: Comics(available: 1, collectionURI: "test2", items: [], returned: 2), urls: [])]))
}
