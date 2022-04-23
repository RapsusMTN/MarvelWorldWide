//
//  MWHomeViewModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

class MWHomeViewModel: MWHomeViewModelProtocol {
    
    // MARK: - Properties
    let dataSourceAPI: MWHomeDataSourceAPIProtocol
    let view: MWHomeListViewControllerProtocol
    let coordinator: MWHomeCoordinatorProtocol
    
    /// List of character items
    private var characterList: [CharacterModel] = [] {
        didSet {
            self.view.reloadData()
        }
    }
    public func getCharacterList() -> [CharacterModel] {
        characterList
    }
    
    private var currentOffset: Int = 0
    
    /// Getter to test currentOffset
    public func getCurrentOffset() -> Int {
        currentOffset
    }
    /// The current filter name to send with query param (nameStartsWith)
    var currentFilteredName: String? {
        didSet {
            resetOffsetPage()
        }
    }
    /// Flag to indicate that there is more content to fetch
    var hasMoreContentToFetch: Bool = true
    
    /// The last cell of collection items
    var lastCell: Int {
        characterList.count - 1
    }
    
    // MARK: - Init
    init(dataSourceAPI: MWHomeDataSourceAPIProtocol ,view: MWHomeListViewControllerProtocol, coordinator: MWHomeCoordinatorProtocol) {
        self.dataSourceAPI = dataSourceAPI
        self.view = view
        self.coordinator = coordinator
    }
    
    // MARK: - Service Functionss
    func getMarvelCharacterList(isRefreshData: Bool = false, completionTest: ((Result<[CharacterModel], MWNetworkError>)-> Void)? = nil) {
        
        self.view.hideNoContentView()
        
        !isRefreshData ? self.view.isLoading = true : self.view.endRefreshData()
        
        self.dataSourceAPI.getMarvelCharacterList(name: currentFilteredName, offset: currentOffset) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let characterList):
                if let _ = self?.currentFilteredName {
                    characterList.isEmpty ? self?.view.showNoContentView() : self?.view.hideNoContentView()
                }
                self?.hasMoreContentToFetch = characterList.isEmpty ? false : true
                guard strongSelf.hasMoreContentToFetch else {
                    self?.view.isLoading = false
                    return
                }
                
                if strongSelf.characterList.isEmpty {
                    self?.characterList = characterList
                } else {
                    characterList.forEach { strongSelf.characterList.append($0)}
                }
                completionTest?(.success(characterList))
            case .failure(let mwNetworkError):
                self?.view.showError(mwNetworkError.description)
                completionTest?(.failure(mwNetworkError))
            }
            
            !isRefreshData ? self?.view.isLoading = false : self?.view.endRefreshData()
        }
    }
    
    // MARK: - Functions
    func numberOfRows() -> Int {
        characterList.count
    }
    
    func modelForCellAt(_ index: Int) -> MWHomeListCellModel {
        let currentElement = characterList[index]
        return MWHomeListCellModel(characterId: currentElement.id, urlImage: currentElement.thumbnail.urlImg, title: currentElement.name, description: currentElement.welcomeDescription)
    }
    
    func fetchMorePage() {
        currentOffset += 1
        self.getMarvelCharacterList()
    }
    
    func resetOffsetPage() {
        hasMoreContentToFetch = true
        currentOffset = 0
        characterList.removeAll()
    }
}
