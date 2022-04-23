//
//  MWSplashViewModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

class MWSplashViewModel: MWSplashViewModelProtocol {
    
    // MARK: - Properties
    let view: MWSplashViewController
    let coordinator: MWSplashCoordinatorProtocol
    
    // MARK: - Init
    init(view: MWSplashViewController, coordinator: MWSplashCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    func splashReady() {
        self.coordinator.navigateToHome()
    }
}
