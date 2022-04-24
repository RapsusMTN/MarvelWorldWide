//
//  BaseViewController.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
import UIKit
import Lottie

/**
    This class represent the parent of all ViewControllers into MWProject.
 */
open class BaseViewController: UIViewController, BaseViewControllerProtocol {
        
    // MARK: - Outlets
    
    // MARK: - Properties
    public var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.manageSpinner(inside: self.view, action: self.isLoading ? .add : .remove)
            }
        }
    }
    
    /// Animation View Loader
    private lazy var spinnerAnimationView: UIView = {
        let viewTransparent = UIView()
        viewTransparent.translatesAutoresizingMaskIntoConstraints = false
        viewTransparent.backgroundColor = .black.withAlphaComponent(0.2)
        
        let viewAnimation = UIView()
        viewAnimation.addAnimation("loaderAnimation", animationMode: .loop, width: 80, height: 80, completion: nil)
        
        viewAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        viewTransparent.addSubview(viewAnimation)
        
        viewAnimation.centerYAnchor.constraint(equalTo: viewTransparent.centerYAnchor).isActive = true
        viewAnimation.centerXAnchor.constraint(equalTo: viewTransparent.centerXAnchor).isActive = true
        
        return viewTransparent
    }()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    public func manageSpinner(inside view: UIView, action: AnimationAction) {
        switch action {
        case .add:
            view.addSubview(spinnerAnimationView)
            
            spinnerAnimationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            spinnerAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            spinnerAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            spinnerAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        case .remove:
            self.spinnerAnimationView.removeFromSuperview()
        }
    }
    
    public func showError(_ message: String) {
        let alert = UIAlertController(title: "Base_controller_error_alert_title_label".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
        if let presentedVC = navigationController?.presentedViewController {
            presentedVC.dismiss(animated: true) {
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
        } else {
            navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Action/Selector
}
