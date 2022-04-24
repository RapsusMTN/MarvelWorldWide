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
    private var characterList: [CharacterModel] = []
    public func getCharacterList() -> [CharacterModel] {
        characterList
    }
    private var total = 0
    var totalCount: Int {
        total
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
    var isFetchInProgress: Bool = false
    
    /// The last cell of collection items
    var currentCount: Int {
        characterList.count
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
        
        guard !isFetchInProgress else {
          return
        }
        
        isFetchInProgress = true

        !isRefreshData ? self.view.isLoading = true : self.view.endRefreshData()
        
        self.dataSourceAPI.getMarvelCharacterList(name: currentFilteredName, offset: currentOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.currentOffset += 1
                self?.isFetchInProgress = false

                self?.total = response.data.total
                self?.characterList.append(contentsOf: response.data.results)
                
                if response.data.offset > 0 {
                    let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.data.results)
                    self?.view.reloadData(with: indexPathsToReload)
                } else {
                    self?.view.reloadData(with: .none)
                }
                
                if response.data.results.isEmpty {
                    self?.view.showNoContentView()
                }
            
                completionTest?(.success(response.data.results))
            case .failure(let mwNetworkError):
                self?.isFetchInProgress = false
                self?.view.showError(mwNetworkError.description)
                completionTest?(.failure(mwNetworkError))
            }

            !isRefreshData ? self?.view.isLoading = false : self?.view.endRefreshData()
        }
    }
    
    // MARK: - Functions    
    func modelForCellAt(_ index: Int) -> MWHomeListCellModel {
        let currentElement = characterList[index]
        return MWHomeListCellModel(characterId: currentElement.id, urlImage: currentElement.thumbnail.urlImg, title: currentElement.name, description: currentElement.welcomeDescription)
    }
    
    func resetOffsetPage() {
        currentOffset = 0
        characterList.removeAll()
    }
    
    private func calculateIndexPathsToReload(from newCharacters: [CharacterModel]) -> [IndexPath] {
      let startIndex = characterList.count - newCharacters.count
      let endIndex = startIndex + newCharacters.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
