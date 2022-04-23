//
//  MWHomeListCellModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public struct MWHomeListCellModel {
    let characterId: Int
    let urlImageCell: URL?
    let title: String
    let description: String
    
    init(characterId: Int, urlImage: URL?, title: String, description: String) {
        self.characterId = characterId
        self.urlImageCell = urlImage
        self.title = title
        self.description = description
    }
}
