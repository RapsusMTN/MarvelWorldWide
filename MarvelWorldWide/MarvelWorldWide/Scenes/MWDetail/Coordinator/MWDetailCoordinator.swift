//
//  MWDetailCoordinator.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
import UIKit

public class MWDetailCoordinator: MWCoordinatorProtocol, MWDetailCoordinatorProtocol {
    
    // MARK: - Properties
    public var navigationController: UINavigationController
    public var characterId: Int
    
    // MARK: - Init
    public init(navigationController: UINavigationController, characterId: Int) {
        self.navigationController = navigationController
        self.characterId = characterId
    }
    
    // MARK: - Start
    public func start() {
        let viewController = MWDetailViewController()
        let dataSourceAPI = MWDetailDataSourceAPI()
        let dataSourceLocal = MWDetailDataSourceLocal()
        let repository = MWDetailRepository(dataSourceAPI: dataSourceAPI, dataSourceLocal: dataSourceLocal)
        let viewModel = MWDetailViewModel(repository: repository, view: viewController, coordinator: self, characterId: characterId)
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Routing
    
}
