//
//  MWDetailViewControllerProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWDetailViewControllerProtocol: BaseViewController {
    var viewModel: MWDetailViewModelProtocol! { get set }
    var model: MWDetailViewControllerModel? { get set }
    var coordinator: MWDetailCoordinatorProtocol! { get set }
}
