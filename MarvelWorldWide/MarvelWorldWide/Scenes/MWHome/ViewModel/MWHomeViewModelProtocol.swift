//
//  MWHomeViewModelProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWHomeViewModelProtocol: AnyObject {
    // MARK: - Properties
    var lastCell: Int { get }
    var currentFilteredName: String? { get set }
    var hasMoreContentToFetch: Bool { get set }
    // MARK: - Functions
    func getMarvelCharacterList(isRefreshData: Bool,  completionTest: ((Result<[CharacterModel], MWNetworkError>)-> Void)?)
    func numberOfRows() -> Int
    func modelForCellAt(_ index: Int) -> MWHomeListCellModel
    func resetOffsetPage()
    func fetchMorePage()
    func getCurrentOffset() -> Int
    func getCharacterList() -> [CharacterModel]
}
