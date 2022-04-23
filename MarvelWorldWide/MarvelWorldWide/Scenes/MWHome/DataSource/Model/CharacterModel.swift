//
//  CharacterModel.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
// MARK: - CharacterModel
public struct CharacterModel: Codable {
    let id: Int
    let name, welcomeDescription: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]

    public enum CodingKeys: String, CodingKey {
        case id, name
        case welcomeDescription = "description"
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
public struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
public struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
public struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
public struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

// MARK: - Thumbnail
public struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    var urlImg: URL? {
        return URL(string: String(format: "%@.%@", path, thumbnailExtension))
    }
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
public struct URLElement: Codable {
    let type: String
    let url: String
}
