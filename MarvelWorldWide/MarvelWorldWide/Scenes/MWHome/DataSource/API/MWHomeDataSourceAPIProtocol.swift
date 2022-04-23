//
//  MWHomeDataSourceAPIProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWHomeDataSourceAPIProtocol: AnyObject {
    // MARK: - Functions
    func getMarvelCharacterList(name: String?, offset: Int, completionBlock: @escaping (Result<[CharacterModel], MWNetworkError>) -> Void)
}
