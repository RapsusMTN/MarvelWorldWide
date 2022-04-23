//
//  MWHomeCoordinator.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit

class MWHomeCoordinator: MWCoordinatorProtocol, MWHomeCoordinatorProtocol {
    
    // MARK: - Properties
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    func start() {
        let viewController = MWHomeListViewController()
        let dataSourceAPI = MWHomeDataSourceAPI()
        let viewModel = MWHomeViewModel(dataSourceAPI: dataSourceAPI, view: viewController, coordinator: self)
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    // MARK: - Routing
    func navigateToCharacterDetail(characterId: Int) {
        let coordinator = MWDetailCoordinator(navigationController: navigationController, characterId: characterId)
        coordinator.start()
    }
}
