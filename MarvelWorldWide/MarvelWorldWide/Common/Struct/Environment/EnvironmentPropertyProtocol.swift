//
//  EnvironmentPropertyProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol EnvironmentPropertyProtocol {
    // MARK: - Properties
    static var KEY_ENVIRONMENT: String { get }
    static var PUBLIC_API_KEY: String { get }
    static var PRIVATE_API_KEY: String { get }
    static var MARVEL_URL_BASE_KEY: String { get }
}
