//
//  RelatedElementModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation

public struct RelatedElementModel: Codable {
    public let id: Int
    public let title: String
    public let description: String?
    public let thumbnail: Thumbnail
}
