//
//  MWSplashViewController.swift
//  MarvelWorldWideApp
//
//  Created by akreyers on 23/4/22.
//

import UIKit
import Lottie

class MWSplashViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var animationView: UIView!
    
    // MARK: - Properties
    var viewModel: MWSplashViewModelProtocol!
    var coordinator: MWSplashCoordinatorProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// If we necessary to fetch any data or call a webService...
        self.viewModel.splashReady()
    }
}
