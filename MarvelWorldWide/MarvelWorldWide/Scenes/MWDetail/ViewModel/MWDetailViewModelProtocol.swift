//
//  MWDetailViewModelProtocol.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public protocol MWDetailViewModelProtocol: AnyObject {
    // MARK: - Properties
    var comics: [RelatedElementModel] { get }
    var series: [RelatedElementModel] { get }
    func getImageURL() -> URL?
    func getTitle() -> String?
    func getDescription() -> String?
    // MARK: - Functions
    func getMarvelCharacterDetail()
    func getRelatedComicCharacter()
    func getRelatedSerieCharacter()
    func getCollectionElement(_ list: [RelatedElementModel]) -> [CommonElement]
}
