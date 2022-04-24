//
//  MWDetailViewModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public class MWDetailViewModel: MWDetailViewModelProtocol {
    
    // MARK: - Properties
    let repository: MWDetailRepositoryProtocol
    let view: MWDetailViewControllerProtocol
    let coordinator: MWDetailCoordinatorProtocol
    
    private var _comics: [RelatedElementModel] = []
    public var comics: [RelatedElementModel] { _comics }
    
    private var _series: [RelatedElementModel] = []
    public var series: [RelatedElementModel] { _series }
    
    /// Character ID
    let characterId: Int
    private var imageURL: URL?
    public func getImageURL() -> URL? { imageURL }
    
    private var title: String?
    public func getTitle() -> String? { title }
    
    private var description: String?
    public func getDescription() -> String? { description }
    
    // MARK: - Init
    public init(repository: MWDetailRepositoryProtocol, view: MWDetailViewControllerProtocol, coordinator: MWDetailCoordinatorProtocol, characterId: Int) {
        self.repository = repository
        self.view = view
        self.coordinator = coordinator
        self.characterId = characterId
    }
    
    // MARK: - Services
    public func getMarvelCharacterDetail(completionTest: ((Result<CharacterModel, MWNetworkError>)-> Void)? = nil) {
        
        self.view.isLoading = true
        
        self.repository.getMarvelCharacterDetail(characterId: characterId) { [weak self] result in
            switch result {
            case .success(let characterModel):
                self?.imageURL = characterModel.thumbnail.urlImg
                self?.title = characterModel.name
                self?.description = characterModel.welcomeDescription
                self?.getRelatedComicCharacter()
                completionTest?(.success(characterModel))
            case .failure(let mwNetworkError):
                self?.view.showError(mwNetworkError.description)
                self?.view.isLoading = false
                completionTest?(.failure(mwNetworkError))
            }
        }
    }
    
    public func getRelatedComicCharacter(completionTest: ((Result<[RelatedElementModel], MWNetworkError>)-> Void)? = nil) {
                        
        self.repository.getRelatedComicCharacter(characterId: characterId) { [weak self] result in
            switch result {
            case .success(let comics):
                self?._comics = comics
                self?.getRelatedSerieCharacter()
                completionTest?(.success(comics))
            case .failure(let mwNetworkError):
                self?.view.showError(mwNetworkError.description)
                self?.view.isLoading = false
                completionTest?(.failure(mwNetworkError))
            }
        }
    }
    
    public func getRelatedSerieCharacter(completionTest: ((Result<[RelatedElementModel], MWNetworkError>)-> Void)? = nil) {
                        
        self.repository.getRelatedSerieCharacter(characterId: characterId) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let series):
                
                self?._series = series
                let elementComics = strongSelf.getCollectionElement(strongSelf.comics)
                let elementSeries = strongSelf.getCollectionElement(series)
                let controllerModel = MWDetailViewControllerModel(imageURL: strongSelf.imageURL, title: strongSelf.title, description: strongSelf.description, comics: elementComics, series: elementSeries)
                self?.view.model = controllerModel
                completionTest?(.success(series))
            case .failure(let mwNetworkError):
                self?.view.showError(mwNetworkError.description)
                completionTest?(.failure(mwNetworkError))
            }
            self?.view.isLoading = false
        }
    }
    
    // MARK: - Functions
    public func getCollectionElement(_ list: [RelatedElementModel]) -> [CommonElement] {
        list.map { element in
            CommonElement(title: element.title, imageURL: element.thumbnail.urlImg, description: element.description)
        }
    }
}
