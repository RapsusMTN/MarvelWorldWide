//
//  MWCoordinatorProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
/**
 - This protocol have a default behaviour of a Coordinator class responsible of flow navigation app only, and dependency injection,
 - Warning All of Coordinator classes must be implement this protocol!
 */
public protocol MWCoordinatorProtocol: AnyObject {
    // MARK: - Properties
    var navigationController: UINavigationController { get }
    // MARK: - Functions
    func start()
}
/**
 - This protocol have a default behaviour of a Coordinator class responsible of flow navigation app when you needs a sceneViewController to navigate out of this.
 */
public protocol MWParentCoordinatorProtocol: AnyObject {
    // MARK: - Properties
    var navigationController: UINavigationController { get }
    // MARK: - Functions
    func getViewControllerScene() -> UIViewController
}
