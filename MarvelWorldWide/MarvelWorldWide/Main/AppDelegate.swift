//
//  AppDelegate.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let splashCoordinator = MWSplashCoordinator(navigationController: navigationController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = splashCoordinator.getViewControllerScene()
        
        return true
    }
}

