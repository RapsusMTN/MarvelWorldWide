//
//  BaseViewControllerProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit

public protocol BaseViewControllerProtocol: UIViewController {
    // MARK: - Properties
    var isLoading: Bool { get set }
    func showError(_ message: String)
}
