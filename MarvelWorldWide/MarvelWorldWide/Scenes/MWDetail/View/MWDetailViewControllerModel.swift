//
//  MWDetailViewControllerModel.swift
//  MarvelWorldWideApp
//
//  Created by akreyers on 16/4/22.
//

import Foundation

public struct MWDetailViewControllerModel {
    let imageURL: URL?
    let title: String?
    let description: String?
    let comics: [CommonElement]
    let series: [CommonElement]
}
