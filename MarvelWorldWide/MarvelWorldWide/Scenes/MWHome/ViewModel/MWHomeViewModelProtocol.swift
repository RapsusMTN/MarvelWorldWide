//
//  MWHomeViewModelProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWHomeViewModelProtocol: AnyObject {
    // MARK: - Properties
    var totalCount: Int { get }
    var currentCount: Int { get }
    var currentFilteredName: String? { get set }
    // MARK: - Functions
    func getMarvelCharacterList(isRefreshData: Bool,  completionTest: ((Result<[CharacterModel], MWNetworkError>)-> Void)?)
    func modelForCellAt(_ index: Int) -> MWHomeListCellModel
    func resetOffsetPage()
    func getCurrentOffset() -> Int
    func getCharacterList() -> [CharacterModel]
}
