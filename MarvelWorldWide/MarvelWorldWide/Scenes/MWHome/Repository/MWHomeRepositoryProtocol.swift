//
//  MWHomeRepositoryProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWHomeRepositoryProtocol: AnyObject {
    // MARK: - Properties
    var dataSourceAPI: MWHomeDataSourceAPIProtocol { get set }
}
