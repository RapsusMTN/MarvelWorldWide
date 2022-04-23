//
//  MWSplashCoordinator.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
import UIKit


class MWSplashCoordinator: MWParentCoordinatorProtocol, MWSplashCoordinatorProtocol {
    
    // MARK: - Properties
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    // MARK: - Start
    func getViewControllerScene() -> UIViewController {
        let viewController = MWSplashViewController()
        let viewModel = MWSplashViewModel(view: viewController, coordinator: self)
        viewController.viewModel = viewModel
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: true)
        
        return navigationController
    }
    
    // MARK: - Routing
    func navigateToHome() {
        
    }
}
