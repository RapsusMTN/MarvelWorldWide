//
//  MWHomeListViewControllerProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWHomeListViewControllerProtocol: BaseViewController {
    // MARK: - Properties
    var viewModel: MWHomeViewModelProtocol! { get set }
    var coordinator: MWHomeCoordinatorProtocol! { get set }
    // MARK: - Functions
    func reloadData()
    func hideNoContentView()
    func endRefreshData()
    func showNoContentView()
}
